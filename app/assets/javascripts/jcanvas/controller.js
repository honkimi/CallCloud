// initialize layer setting.
$.jCanvas.defaults.layer = true;

// user settings
number = "受付番号: " + $("#number").val(); // see box.js base_tel.
base_tel = $("#base_tel_bumber").val(); // see box.js base_tel.
first_msg = $("#first_msg").val();

//disp property
var $dispX = 900;

var telText = new TextView(number, $dispX / 2, 50, "tel", 24, false);
telText.draw();

var firstMsgText = new TextView(first_msg, $dispX / 2, 170, "first", 16, true);
firstMsgText.draw();

var arrow = new ArrowView($dispX / 2, 80, $dispX / 2, 130, 'telToFirst');
arrow.draw();

var drawRoot = function(json) {
   var actions = json.actions;
   var root = new Box(0, "Root", "", 0, null, -1);
   for (var i = 0; i < actions.length; i++) {
     var theAction = actions[i];
     var box = new Box(theAction.number, theAction.name, theAction.action, 1, root);
     for (var j = 0; j < theAction.children.length; j++) {
       var theChild = theAction.children[j];
       var boxChild = new Box(theChild.number, theChild.name, theChild.action, 2, box);
       box.addChild(boxChild);
     }
     root.addChild(box);
   }
   root.setBasePoint();
   root.draw();
   return root;
};

var addImg = function(root) {
  // create add btn root
  var addImgTop = new ImageView($dispX / 2, 220, 32, 'addImg', "nogroup");
  addImgTop.drawAdd(function(){
    if (root.children.length > 5) {
      alert('追加できるのは最大６つまでです。\nそれ以上あると、電話発信側も煩わしく感じますよね。');
      return;
    }
    root.addChild(new Box(root.children.length + 1, "追加", base_tel, 1, root));
    root.redraw();
  });
}

var setSubmit = function(root) {
  // create submit btn
  $('#tel_show .save').on('click', function() {
    var json = root.getResult();
    jsonString = JSON.stringify(json);
    param = {
      sheet: jsonString,
      first_msg: $('canvas').getLayer('first').text
    };

    $.ajax({
       type: "PUT",
       url: "/tels/" + $('.tel_list li.active').attr('data') + "/sheets",
       data: param,
       success: function(msg){
         var msg = "やった！保存に成功しました。";
         if (msg.status == "ng") {
           msg = "おっと、保存に失敗しました。";
         }
         $.snackbar({
            content: msg,
            style: "toast"
         });
       }
     });
  });
};

if ($('.tel_list li.active').attr('data') != undefined) {
  $.ajax({
     type: "GET",
     url: "/tels/" + $('.tel_list li.active').attr('data') + "/sheets",
     success: function(json){
       var root = drawRoot(json);
       addImg(root);
       setSubmit(root);
     }
  });
}




