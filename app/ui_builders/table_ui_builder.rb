class TableUIBuilder < BaseUIBuilder
  param_attr :columns, default: []
  param_attr :actions, default: []
  param_attr :scope, default: nil
  param_attr :stripe_height, default: 4
  state_attr :sort_by, default: nil
  state_attr :sort_dir, default: nil
  state_attr :page, default: 1


  def action(name, multiple: false, &block)
    @params.actions << OpenStruct.new(
      name: name,
      multiple: multiple,
      block: block,
      title: name.to_s.titleize
    )
  end

  def has_actions?
    @params.actions.any?
  end

  def pagy_records
    fscope = joined_scope
    if @state.sort_by
      fscope = fscope.reorder("#{@state[:sort_by]} #{@state[:sort_dir]}")
    end
    pagy, records = pagy(fscope, page: @state.page)
    [pagy, records]
  end

  def sortable?(column)
    if column.field.to_s["."]
      false
    else
      true
    end
  end

  def col(field, &block)
    @params.columns << OpenStruct.new(
      field: field,
      block: block,
      render: build_render_method(field, block)
    )
  end

  def toggle_sort_state(column)
    if @state.sort_by == column.field.to_s
      sort_dir = @state.sort_dir == "asc" ? "desc" : "asc"
    else
      sort_dir = "asc"
    end
    new_state(sort_by: column.field, sort_dir: sort_dir)
  end

  def action_url(action:, record:)
    n = action.name.to_s
    case n
    when "view"
      @view_context.polymorphic_path(record)
    when "edit"
      @view_context.polymorphic_path([:edit, record])
    else
      "."
    end
  end

  private

  # Builds a lambda that can be used to render
  # Believe to be optomized so we don't have to
  # decide how to render for each cell in a large
  # table

  def build_render_method(field, block)
    field = field.to_s
    if field.include?(".")
      return lambda do |record|
        field.split(".").inject(record) { |r, f| r.send(f) }
      end
    end
    if block
      return lambda do |record|
        capture { block.call(record) }
      end
    end
    lambda do |record|
      record.send(field)
    end
  end

  # Searches all column fields for a period "."
  # and modifies the scope to join to those tables
  # to avoid a N+1 query

  def joined_scope
    fscope = @params.scope
    joins = @params.columns.map {|c| c.field.to_s }.select { |f| f.include?(".") }.map { |f| f.split(".").first }.uniq
    joins.each do |join|
      # fscope = fscope.joins(join.to_sym)
      # fscope = fscope.left_outer_joins(join.to_sym)
      fscope = fscope.includes(join.to_sym)
    end
    fscope
  end

end
