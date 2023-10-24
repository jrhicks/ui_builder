import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="highchart"
export default class extends Controller {
  static targets = ["json"]
  connect() {
    let encodedData = this.jsonTarget.dataset.encoded
    let jsonData = atob(encodedData)
    console.log(jsonData)
    let chartData = JSON.parse(jsonData)
    let tfid = this.jsonTarget.dataset.tfid
    Highcharts.chart(tfid, chartData)
  }
}
