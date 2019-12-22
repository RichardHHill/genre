
$(document).on("click", "#quiz_buttons .btn-default", function() {
  Shiny.setInputValue("js_quiz_selection", this.id.substr(11), { priority: "event"});
});

$(document).on("keyup", function(e) {
  if (e.keyCode == 77) {
    Shiny.onInputChange("key_m", Math.random());
  } else if (e.keyCode == 70) {
    Shiny.onInputChange("key_f", Math.random());
  } else if (e.keyCode == 13) {
    Shiny.onInputChange("key_enter", Math.random());
  } else if (e.keyCode == 27) {
    Shiny.onInputChange("key_esc", Math.random());
  }
});

