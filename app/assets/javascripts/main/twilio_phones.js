// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

fetch_twilio_phone = function() {
  if ($('#twilio_phone_sid').exists()) {
    $.ajax({
       type: "GET",
       url: "/tels/" + $('#tel_id').val() + "/twilio_phones",
       success: function(numbers){
         $('#twilio_phone_sid').children().remove();
         for (var i = 0; i < numbers.length; i++) {
           $('#twilio_phone_sid')
             .append($('<option>')
             .attr({ value: numbers[i].sid })
             .text(numbers[i].number));
         }
       }
     });
  }
};

