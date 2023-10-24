// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "idiomorph"
import Highcharts from 'highcharts'

// frontend/javascript/turbo-scroll.js
// This JavaScript saves the scroll position of each element with the "data-turbo-permanent" attribute.
// When the next page is renders, we restore the scroll position.
(function () {
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

  // addEventListener("turbo:before-render", (event) => {
  //   console.log(event)
  //   event.detail.render = async (prevEl, newEl) => {
  //     await new Promise((resolve) => setTimeout(() => resolve(), 0));
  //     await Idiomorph.morph(prevEl, newEl);
  //   };
  // });

  // addEventListener("turbo:before-frame-render", (event) => {
  //   event.detail.render = (prevEl, newEl) => {
  //     Idiomorph.morph(prevEl, newEl.children, {
  //       morphStyle: "innerHTML",
  //       callbacks: {
  //         beforeNodeMorphed: (p, n) => {
  //           if (p.attributes && p.attributes['data-prevent-morph'] && p.getAttribute('data-prevent-morph') != 'false') {
  //             return false;
  //           }
  //         }
  //       }
  //     })
  //   };
  // });


})();

