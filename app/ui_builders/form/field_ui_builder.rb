# https://guides.rubyonrails.org/form_helpers.html#other-helpers-of-interest

class Form::FieldUIBuilder < BaseUIBuilder
  attr_accessor :form_component, :is_dynamic, :user_input
  param_attr :name, default: nil
  param_attr :label, default: nil
  param_attr :width, default: 4
  param_attr :type, default: :string
  param_attr :mode, default: :show
  param_attr :options, default: []
  param_attr :scalar_type, default: 'string'
  param_attr :show_if, default: nil

  def initialize(form_component:, name:, label:, width:, type:, mode:, options: [])
    @form_component = form_component
    turbo_frame_id = "#{form_component.turbo_frame_id}_#{name.to_s.underscore}"
    super(turbo_frame_id)
    @params.name = name if name
    @params.label = label if label
    @params.width = width if width
    @params.type = type if type
    @params.mode = mode if mode
    @params.options = normalize_options(options)
    @is_dynamic = false
  end

  def should_show?
    @params.mode != :hide || @params.show_if.call(@form_component.params.model)
  end

  # Returns array of name,id pairs [[name, id], ...]
  def normalize_options(options)
    if options == nil
      return []
    end
    # If active Record Scope
    if options.class.superclass == ActiveRecord::Relation
      @params.scalar_type = :integer
      return options.map { |o| [o.name, o.id] }
    end
    # If Array
    if options.is_a?(Array)
      if options.first.is_a?(Array)
        return options
      else
        return options.map { |o| [o, o] }
      end
    end

    if options.is_a?(Proc)
      @is_dynamic = true
      dynamic_options = options.call(@form_component.params.model)
      return normalize_options(dynamic_options)
    end

    return [["Error: Invalid Options", "Error: Invalid Options"]]
  end

  def options(options)
    @params.options = normalize_options(options)
  end

  def show_if(proc)
    @params.show_if = proc
    @is_dynamic = true
  end

  def static_or_dynamic
    if @is_dynamic
      return "dynamic"
    else
      return "static"
    end
  end

  def encoded_conditions
    Base64.encode64(
      {
        show_if: @show_if
      }.to_json
    )
  end

end