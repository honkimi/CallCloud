var TextView = function(text, baseX, baseY, name, fontSize, hasEvent, group, color) {
  this.text = text;
  this.baseX = baseX;
  this.baseY = baseY;
  this.name = name;
  this.color = color;
  this.fontSize = fontSize;
  this.hasEvent = hasEvent;
  this.group = group;
  this.canvas = $('canvas')
};
TextView.prototype  = {
  draw: function(onSetText) {
    if (this.group == undefined) {
      this.group = "nogroup";
    }
    if (this.hasEvent) {
      var self = this;
      this.drawText(function(){
        if (self.text == "--") {
          return;
        }
        $.prompt({
          state0: {
            title: self.capitaliseFirstLetter(self.name),
            html: '<label><input type="text" name="value" style="width: 300px" value="' + self.text + '"><br />' ,
            buttons: { OK: 1 },
            submit:function(e,v,m,f){ 
              self.update({text: f.value});
              self.text = f.value;
              if (onSetText != undefined) {
                onSetText(f.value);
              }
              e.preventDefault();
              $.prompt.close();
            }
          }
        });
      });
    } else {
      this.drawText(function(){});
    }
  },
  drawText: function(clicked) {
    if (!this.hasEvent || this.text == "--") {
       this.color = "#868C8E";
    } else if (this.color == undefined) {
       this.color = "black";
    } 
    this.canvas.drawText({
        fillStyle: this.color,
        strokeStyle: this.color,
        strokeWidth: "0.5",
        x: this.baseX,
        y: this.baseY,
        fontSize: this.fontSize,
        fontFamily: "sans-serif",
        text: this.text,
        name: this.name,
        groups: [this.group],
        click: function() {
          clicked();
        }
    });
  },
  update: function(option) {
    this.canvas.setLayer(this.name, option)
      .drawLayers();
  },
  capitaliseFirstLetter: function(string) {
    return string.charAt(0).toUpperCase() + string.slice(1);
  }
};

var ArrowView = function(x1, y1, x2, y2, name, group) {
  this.x1 = x1;
  this.y1 = y1;
  this.x2 = x2;
  this.y2 = y2;
  this.name = name;
  this.group = group;
  this.canvas = $('canvas')
}

ArrowView.prototype = {
  draw: function() {
    if (this.group == undefined) {
      this.group = "nogroup";
    }
    return this.canvas.drawLine({
      strokeStyle: 'gray',
      strokeWidth: 2,
      rounded: true,
      groups: [this.group],
      name: this.name,
      endArrow: true,
      arrowRadius: 15,
      arrowAngle: 60,
      x1: this.x1, y1: this.y1,
      x2: this.x1, y2: this.y1,
    }).animateLayer(this.name, {
      x2: this.x2,
      y2: this.y2
    }, 1000);
  } 
}

var ImageView = function(x, y, size, name, group) {
  this.x = x;
  this.y = y;
  this.size = size;
  this.name = name;
  this.group = group;
  this.canvas = $('canvas')
}

ImageView.prototype = {
  drawAdd: function(clicked) {
    this.draw('img/circle.png');
    var addText = new TextView("+", this.x, this.y, this.name, 22,clicked , this.group, "black");
    addText.drawText(clicked);
  },
  drawDel: function(clicked) {
    this.draw('img/circle_red.png');
    var delText = new TextView("-", this.x, this.y, this.name, 22, clicked , this.group, "red");
    delText.drawText(clicked);
  }, 
  draw: function(imgUrl) {
    this.canvas.drawImage({
      source: imgUrl,
      x: this.x, y: this.y,
      width: this.size, height: this.size,
      groups: [this.group]
    });
  }
}

var RectView = function(x, y, width, height, name, group) {
  this.x = x;
  this.y = y;
  this.width = width;
  this.height = height;
  this.name = name;
  this.group = group;
  this.canvas = $('canvas')
}

RectView.prototype = {
  draw: function() {
    if (this.group == undefined) {
      this.group = "nogroup";
    }
    this.canvas.drawRect({
      fillStyle: "#CCCCCC",
      strokeStyle: "black",
      strokeWidth: 1,
      x: this.x,
      y: this.y,
      groups: [this.group],
      width: this.width,
      height: this.height,
      name: this.name,
      bringToFront: true
    });
  }
}

var LineView = function(x, y, width, name, group) {
  this.x = x;
  this.y = y;
  this.width = width;
  this.name = name;
  this.group = group;
  this.canvas = $('canvas')
}

LineView.prototype = {
  draw: function() {
    this.canvas.drawLine({
      strokeStyle: '#000',
      strokeWidth: 1,
      rounded: true,
      name: this.name,
      x1: this.x, y1: this.y,
      groups: [this.group],
      x2: this.x + this.width, y2: this.y
    });
  }
}
