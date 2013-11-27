# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
$('.input-large').click(function() {
  var checked; 
  if ($(this).is(':checked')) {
    checked = true;
  } else {
    checked = false;
  } 
  $.ajax({
      type: "POST",
      url: "/goal_instance/complete",
      data: { id: $(this).data('post-id'), checked: checked }
   });     
});# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

