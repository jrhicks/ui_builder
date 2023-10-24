import "idiomorph"

function rememberScrollPositionOnTurboLoad() {
  let scrollTop = 0
  let activeElement = null;
  window.Highcharts = Highcharts
  addEventListener("turbo:before-visit", (args) => {
    scrollTop = document.scrollingElement.scrollTop
    setTimeout(() => {
      activeElement = document.activeElement && document.activeElement.id
    }, 0)
    activeElement = document.activeElement && document.activeElement.id
  })

  addEventListener("turbo:load", () => {
    document.scrollingElement.scrollTo(0, scrollTop)
    if (activeElement) {
      let element = document.getElementById(activeElement)
      if (element) {
        element.focus()
      }
    }
    activeElement = null
    scrollTop = 0
  })
}

function morphTurboFrameRenders() {
  addEventListener("turbo:before-frame-render", (event) => {
    event.detail.render = (prevEl, newEl) => {
      Idiomorph.morph(prevEl, newEl.children, {
        morphStyle: "innerHTML",
        callbacks: {
          beforeNodeMorphed: (p, n) => {
            if (p.attributes && p.attributes['data-prevent-morph'] && p.getAttribute('data-prevent-morph') != 'false') {
              return false;
            }
          }
        }
      })
    };
  });
}

export default { morphTurboFrameRenders, rememberScrollPositionOnTurboLoad }