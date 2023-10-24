import { Controller } from "@hotwired/stimulus"
import Highcharts from 'highcharts'

// Connects to data-controller="highchart"
export default class extends Controller {
  static targets = ["json"]
  connect() {
    let encodedData = this.jsonTarget.dataset.encoded
    let jsonData = atob(encodedData)
    let chartData = JSON.parse(jsonData)
    let tfid = this.jsonTarget.dataset.tfid
    Highcharts.chart(tfid, chartData)
  }
}
