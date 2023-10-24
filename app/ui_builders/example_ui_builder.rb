class ExampleUIBuilder < BaseUIBuilder
  state_attr :show, default: 'preview'
  param_attr :name, default: nil
  param_attr :variation, default: nil
  param_attr :klass, default: nil

  def code_file_path(type)
    Rails.root.join("app", "views", "examples", @params.name, "_#{@params.variation}.html.#{type}")
  end

  def slim_file_path
    code_file_path("slim")
  end  
  
  def title
    @name.titleize
  end

  def partial
    "/examples/#{@params.name}/#{@params.variation.underscore}"
  end
end
