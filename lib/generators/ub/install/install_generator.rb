module Ub
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path("templates", __dir__)

    def copy_js
      copy_file "form_ui_builder_controller.js", "app/javascript/controllers/form_ui_builder_controller.js"
      copy_file "ui_builder.js", "app/javascript/ui_builder.js"
    end
  end
end
  