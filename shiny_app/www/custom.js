
$(document).on("click", "#quiz_buttons .btn-default", function() {
  Shiny.setInputValue("js_quiz_selection", this.id.substr(11), { priority: "event"});
});

$(document).on("keyup", function(e) {
  if (e.keyCode == 77) { //m
    Shiny.onInputChange("type_select_m", Math.random());
  }
});

$(document).on("keyup", function(e) {
  if (e.keyCode == 70) { //f
    Shiny.onInputChange("type_select_f", Math.random());
  }
});

