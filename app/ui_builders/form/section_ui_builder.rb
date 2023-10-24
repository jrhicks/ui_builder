# https://www.teamdesk.net/help/forms/customize-form-layout/

class Form::SectionUIBuilder
  attr_accessor :field_width,
                :fields,
                :form_component,
                :label_above,
                :name,
                :same_row,
                :width,
                :color

  def initialize(name, form_component:, width: 4, same_row: true)
    @fields = []
    @form_component = form_component
    @name = name
    @same_row = same_row
    @width = width
    @color = nil
  end

  def default_field_width(field_width)
    @field_width = field_width
  end

  def string(name, mode=:show, label: nil, width: nil, &block)
    label = name.to_s.titleize if label.nil?
    width = @field_width if width.nil?
    field = Form::FieldUIBuilder.new(
      form_component: @form_component, 
      name: name, 
      label: label, 
      width: width, 
      type: 'string', 
      mode: mode)
    block.call(field) if block
    @fields << field
    field
  end

  def select(name, mode=:show, options: [], label: nil, width: nil, &block)
    label = name.to_s.titleize if label.nil?
    width = @field_width if width.nil?
    field = Form::FieldUIBuilder.new(
      form_component: @form_component, 
      name: name, 
      label: label, 
      width: width, 
      type: 'select', 
      options: options,
      mode: mode)
    block.call(field) if block
    @fields << field
    field
  end

  def text(name, mode=:show, label: nil, width: nil, &block)
    label = name.to_s.titleize if label.nil?
    width = @field_width if width.nil?
    field = Form::FieldUIBuilder.new(
      form_component: @form_component, 
      name: name, 
      label: label, 
      width: width, 
      type: 'text', 
      mode: mode)
    block.call(field) if block
    @fields << field
    field
  end

  def color(color_str)
    @color = Form::ColorUIBuilder.new(color_str)
  end

  def dark_color
    if @color
      @color.dark
    else
      'gray-700'
    end
  end

  def medium_color
    if @color
      @color.medium
    else
      'gray-100'
    end
  end

  def light_color
    if @color
      @color.light
    else
      'gray-50'
    end
  end


end