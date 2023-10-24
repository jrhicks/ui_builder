import { Controller } from "@hotwired/stimulus"
import UIBuilder from "ui_builder"

// Connects to data-controller="form-ui-builder"
export default class extends Controller {
  static targets = ["field", "form"]

  connect() {
  }

  entriesToHash(entries) {
    let hash = {}
    for (var pair of entries) {
      let key = pair[0]
      let value = pair[1]
      hash[pair[0]] = this.cast(key, pair[1])
    }
    return hash
  }

  cast(field_name, value) {
    // console.log(this.fieldTargets.map((f) => f.dataset.name))
    let field = this.fieldTargets.find((f) => f.dataset.name == field_name)
    // console.log({ field_name, value, field })
    if (field) {
      if (field.dataset.scalarType == "integer") {
        return parseInt(value)
      } else {
        return value
      }
    }
    return value
  }

  getFormData() {
    const form = new FormData(this.formTarget);
    return this.entriesToHash(form.entries())
  }

  disableDynamicFields() {
    this.fieldTargets.forEach((target) => {
      if (target.dataset.dynamic == "true") {
        target.classList.add("opacity-75");
        // disable all input elements inside target
        target.querySelectorAll("input").forEach((input) => {
          input.disabled = true;
        });
        target.querySelectorAll("select").forEach((input) => {
          input.disabled = true;
        });
      }
    })
  }

  setUserInputState(event) {
    let data = this.getFormData()
    let tfid = this.formTarget.dataset.tfid
    let ui_builder = new UIBuilder(tfid)
    ui_builder.setState({ user_input: data })
  }

  inputChanged(event) {
    this.setUserInputState(event)
    this.disableDynamicFields()
  }
}


