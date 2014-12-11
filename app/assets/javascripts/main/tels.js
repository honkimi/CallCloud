// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(function(){
  var telId = "";

  var ajaxHtml = function(url) {
    $.ajax({
       type: "GET",
       url: url,
       success: function(msg){
         $("#tel_contents").html(msg);
       }
     });
  };

  var getContents = function(id) {
    telId = id;
    ajaxHtml("/tels/" + telId);
  };

  // on load
  if($('#tels_index .tel_list li').exists()) {
    $('.tel_list li').first().addClass('active');
    getContents($('.tel_list li').attr('data'));
  }

  // event
  $('.tel_list li').click(function() {
    $(this).siblings().removeClass('active');
    $(this).addClass('active');
    getContents($('.tel_list li.active').attr('data'));
  });

  $(document).on('click', '.tel-tab li', function() {
    console.log("called");
    $(this).siblings().removeClass('active');
    $(this).addClass('active');
    var url = $('.tel-tab li.active').attr('data').replace("id", telId);
    ajaxHtml(url);
  });


})
