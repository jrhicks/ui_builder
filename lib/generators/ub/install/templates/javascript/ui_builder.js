import { Turbo } from "@hotwired/turbo-rails"

export default class UIBuilder {

  constructor(tfid) {
    this.tfid = tfid
  }

  entriesToHash(entries) {
    let hash = {}
    for (var pair of entries) {
      hash[pair[0]] = pair[1]
    }
    return hash
  }

  urlParams() {
    let url = new URL(window.location.href)
    let params = this.entriesToHash(url.searchParams.entries())
    return params
  }

  getState() {
    let params = this.urlParams()
    let turbo_state_str = params.turbo_state
    if (turbo_state_str) {
      let turbo_stats_json = atob(turbo_state_str)
      let turbo_state = JSON.parse(turbo_stats_json)
      return turbo_state
    } else {
      return {}
    }
  }

  createUrl(state) {
    let tfid = this.tfid
    let currentState = this.getState()
    let tfidState = currentState[tfid]
    let newTfidState = { ...tfidState, ...state }
    let newState = { ...currentState, [tfid]: newTfidState }
    let newStateStr = JSON.stringify(newState)
    let newStateBase64 = btoa(newStateStr)
    let url = new URL(window.location.href)
    url.searchParams.set("turbo_state", newStateBase64)
    return url.href
  }

  visit(url) {
    // https://world.hey.com/ericparshall/trying-to-use-turbo-visit-but-within-a-turbo-frame-4ef11ee0

    // Turbo.visit(url)
    // Get turbu-frame element with id tfid
    let frame = document.getElementById(this.tfid)

    // This works too but requires more params to visit()
    // let frame = element.closest('turbo-frame')

    if (frame) {
      frame.src = url
    } else {
      Turbo.visit(url)
    }
  }

  setState(state) {
    let url = this.createUrl(state)
    this.visit(url)
  }

}


