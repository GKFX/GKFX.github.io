$(document).ready(function() {
  $("#demo div").hide();

  $("#demo")
  .click(function() {
    $("#demo div")
      .each(function(n) {
        if ($(this).is(":hidden")) {
          if (n & 1) {
            $(this)
              .css({right: "-100%", position: "relative"})
              .show()
              .animate({right: "50px"}, {duration: 200})
              .animate({right: "0"});
          } else {
            $(this)
              .css({left: "-100%", position: "relative"})
              .show()
              .animate({left: "50px"}, {duration: 200})
              .animate({left: "0"});
          }
          return false;
        }
      });
  });


  $("body>div")
  .prepend("<div style=\"edit-button\"></div>");
  // onclick=\"this.parentNode.contentEditable = true;\"
});
