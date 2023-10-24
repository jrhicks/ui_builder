class FormUIBuilder < BaseUIBuilder
  state_attr :user_input, default: {}
  param_attr :model, default: OpenStruct.new()
  param_attr :sections, default: []
  param_attr :label_above, default: true
  param_attr :mode, default: :show

  def before_call
    load_user_input_into_model(@params.model)
  end

  def section(name, width: 4, &block)
    s = Form::SectionUIBuilder.new(name, form_component: self, width: width)
    @params.sections << s
    block.call(s) if block
  end

  def load_user_input_into_model(model)
    @state.user_input.each do |key, value|
      model.send("#{key}=", value)
    end
  end

end
