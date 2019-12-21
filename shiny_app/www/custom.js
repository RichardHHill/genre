
$(document).on("click", "#quiz_buttons .btn-default", function() {
  Shiny.setInputValue("js_quiz_selection", this.id.substr(11), { priority: "event"});
})
