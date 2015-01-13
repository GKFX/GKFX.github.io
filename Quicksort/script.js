$(document).ready(function() {
  $("#demo div").hide();

  $("#demo")
  .click(function() {
    $("#demo div")
      .each(function() {
        if ($(this).is(":hidden")) {
          $(this).slideDown(500);
          return false;
        }
      });
  });
});
