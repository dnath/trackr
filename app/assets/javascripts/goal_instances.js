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
});

