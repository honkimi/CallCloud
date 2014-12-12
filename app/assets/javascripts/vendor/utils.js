jQuery.fn.exists = function(){return Boolean(this.length > 0);}

showSnack = function(msg) {
   $.snackbar({
      content: msg,
      style: "toast"
   });
}


