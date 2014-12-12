// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

fetch_invite_notice = function() {

  $.ajax({
     type: "GET",
     url: "/invites",
     success: function(data){
       console.log(data);
       $("#noticeArea .badge").text(data.length);
       for (var i = 0; i < data.length; i++) {
         $("#noticeArea .notify_list").append(
           "<li><a href='/invites/" + data[i].invite.id +"/edit'>" + data[i].user.email + "から" + data[i].tel.organize_name + "への招待が届いています。</a></li>"
         );
       }

     }
   });

}
