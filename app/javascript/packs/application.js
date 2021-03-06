// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.



require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

let div_cover = null;

const toggleHoverBtn = (color) => {
  document.querySelector(`a.${color}`)?.classList.toggle("btn-hover");
}

const handleCoverClick = event => {
  // if (div_cover !== event.target) return;
  div_cover.style.opacity = '0';
  document.querySelector("#btn-cover").style.display = "none";
}



const eventHandler = () => {
  console.log("event handler");


  console.log(div_cover);
  div_cover?.addEventListener("click", handleCoverClick);

  window.addEventListener('keyup', (e) => {
    if (!div_cover) { return ; }
    const cover_opacity = document.querySelector("#cover")?.style.opacity
    console.log(e.key);
    if (e.key == ' ') {
      handleCoverClick(e);
    }
    if (e.key == 'v') {
      if (cover_opacity == '' || cover_opacity == '1') {
        handleCoverClick(e);
      } else {
        toggleHoverBtn("green");
        setTimeout(() => {
          document.querySelector("a.green")?.click();
          toggleHoverBtn("green");
        }, 300);
      }
    }
    if (e.key == 'b') {
      if (cover_opacity == '' || cover_opacity == '1') {
        handleCoverClick(e);
      } else {
        toggleHoverBtn("red");
        setTimeout(() => {
          document.querySelector("a.red")?.click();
          toggleHoverBtn("red");
        }, 300);
      }
    }

  });
}

MutationObserver = window.MutationObserver || window.WebKitMutationObserver;

var observer = new MutationObserver(function(mutations, observer) {
    // fired when a mutation occurs

    setTimeout(() => {
      // console.log(mutations, observer);
      div_cover = document.querySelector("#cover");
      console.log("mutation");
      eventHandler();
    },400)
    // ...
});

// define what element should be observed by the observer
// and what types of mutations trigger the callback
observer.observe(document, {
  subtree: true,
  attributes: true
  //...
});
