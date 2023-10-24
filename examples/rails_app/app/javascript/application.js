// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import Highcharts from 'highcharts'
import UIBuilderListeners from './ui_builder_listeners'

(function () {
  window.Highcharts = Highcharts
  UIBuilderListeners.rememberScrollPositionOnTurboLoad()
  UIBuilderListeners.morphTurboFrameRenders()
})();

