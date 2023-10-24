module Ub
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path("templates", __dir__)

    def copy_javascript
      directory "javascript", "app/javascript"
      directory "javascript_controllers", "app/javascript/controllers"
    end
  end
end
  