class TcGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("templates", __dir__)

  def create_component_file
    template "component.rb.erb", "app/turbo_components/#{file_name}_component.rb"
  end

  def create_view_file
    template "view.slim.erb", "app/views/turbo_components/_#{file_name}.html.slim"
  end

private

  def plural_name
    file_name.pluralize
  end

  def snake_case_name
    file_name.underscore
  end

  def camel_case_name
    file_name.camelize
  end

  def titleized_name
    file_name.titleize
  end

end