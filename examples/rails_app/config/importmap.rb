# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "el-transition" # @0.0.7
pin "idiomorph", to: "https://ga.jspm.io/npm:idiomorph@0.0.9/dist/idiomorph.js"
pin "highcharts", to: "https://ga.jspm.io/npm:highcharts@11.1.0/highcharts.js"
pin "ui_builder", to: "ui_builder.js"