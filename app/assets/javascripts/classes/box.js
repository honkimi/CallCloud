// box property
var $boxWidth = 120;
var $boxHeight = 90;
var $boxNum = 1;
var $boxGroup = "box";

function layer(layer) {
  return $('canvas').getLayer(layer);
}

var Box = function(number, name, action, devision, myparent) {
  this.number = number;
  this.name = name;
  this.action = action;
  this.devision = devision;
  this.myparent = myparent;
  this.children = [];
  this.group = $boxGroup;
};

Box.prototype = {
  addChild: function(child) {
    this.children.push(child);
  },
  setBasePoint: function() {
    if (this.myparent == null) {
      this.baseX = $dispX / 2;
      this.baseY = 280;
      this.arrowBaseY = 280;
    } else {
      this.baseX = $dispX / (this.myparent.children.length + 1) * this.number;
      if (this.devision > 1) {
        this.baseY = this.myparent.baseY + ($boxHeight + 50) * (this.myparent.number);
      } else {
        this.baseY = this.myparent.baseY + $boxHeight + 10;
      }
      this.arrowBaseY = this.baseY + $boxHeight / 2;
    }
    for (var i = 0; i < this.children.length; i++) {
      this.children[i].setBasePoint();
    }
  },
  draw: function() {
    // bring to front of rect.
    //for (var i = this.children.length - 1; i >= 0; i--) {
    for (var i = 0; i < this.children.length; i++) {
      this.children[i].draw();
    }
    if (this.myparent == null) {
      // if root and no chilren, set action.
      if (this.children.length == 0) {
        var rootText = new TextView(this.action, this.baseX, this.baseY - $boxHeight / 3, "action" + layerNameBase, 16, true, this.group);
        rootText.draw();
      }
      return;
    }
    var layerNameBase = "" + this.devision + this.number + this.myparent.number;
    // draw arrow
    var arrow = new ArrowView(this.myparent.baseX, this.myparent.arrowBaseY, this.baseX, this.baseY - $boxHeight / 2, "arrow" + layerNameBase, this.group);
    arrow.draw();
    // draw rect
    var rect = new RectView(this.baseX, this.baseY, $boxWidth, $boxHeight, "rect" + layerNameBase, this.group);
    rect.draw();
    // box above line
    var aboveLine = new LineView(this.baseX - $boxWidth / 2, this.baseY - $boxHeight / 6, $boxWidth, 'rectabove' + layerNameBase, this.group);
    aboveLine.draw();
    // box below line
    var belowLine = new LineView(this.baseX - $boxWidth / 2, this.baseY + $boxHeight / 6, $boxWidth, 'rectbelow' + layerNameBase, this.group);
    belowLine.draw();
    // above text
    var aboveText = new TextView(this.number + "#", this.baseX, this.baseY - $boxHeight / 3, "Number" + layerNameBase, 16, false, this.group);
    aboveText.draw();
    // center text
    var centerText = new TextView(this.name, this.baseX, this.baseY, "Name" + layerNameBase, 16, true, this.group);
    centerText.draw();
    // below text
    var belowText = new TextView(this.action, this.baseX, this.baseY + $boxHeight / 3, "Action" + layerNameBase, 14, true, this.group);
    belowText.draw();
    // add text
    if (this.devision <= 1) {
      var addImg = new ImageView(this.baseX, this.baseY + $boxHeight - 30, 32, 'addImg' + layerNameBase, this.group);
      var self = this;
      addImg.drawAdd(function(){
        if (self.children.length == 0) {
          // remove self action
          self.action = "--";
        }
        if (self.children.length > 5) {
          alert('追加できるのは最大６つまでです。\nそれ以上あると、電話発信側も煩わしく感じますよね。');
          return;
        }
        self.addChild(new Box(self.children.length + 1, "追加", base_tel, self.devision + 1, self));
        self.redraw();
      });
    }
    // del btn if last
    if (this.number == this.myparent.children.length) {
      var delImg = new ImageView(this.baseX + layer('rect' + layerNameBase).width / 2 - 15, this.baseY - layer('rect' + layerNameBase).height / 3, 26, 'delImg' + layerNameBase, this.group);
      var self = this;
      delImg.drawDel(function() {
        if (self.myparent.children.length == 1) {
          // if last, set action in current.
          self.myparent.action = self.action;
        }
        self.myparent.children = self.myparent.children.splice(0, self.myparent.children.length - 1);
        self.redraw();
      });
    }
  },

  getRoot: function () {
    if (this.myparent == null) {
      return this;
    } else if (this.myparent.myparent == null) {
      return this.myparent;
    } else if (this.myparent.myparent.myparent == null) {
      return this.myparent.myparent;
    }
  },

  getResult: function() {
    var resultArr = [];
    var devisionMax = 2;
    var numberMax = 6;
    for (var i = 1; i <= devisionMax; i++) {
      for (var j = 1; j <= numberMax; j ++) {
        // layer1
        if (i == 1) {
          // all k val is 0.
          var name = layer('Name' + i + j + 0);
          var action = layer('Action' + i + j + 0);
          if (name == undefined) {
            continue;
          }
          resultArr[j - 1] = {
            "number": j,
            "name": name.text,
            "action": action.text
          }
          continue;
        }

        // layer 2
        for (var k = 1; k <= numberMax; k ++) {
          if (resultArr[k - 1] != undefined && resultArr[k - 1]["children"] == undefined) {
            resultArr[k - 1]["children"] = [];
          }
          var name = layer('Name' + i + j + k);
          var action = layer('Action' + i + j + k);
          if (name == undefined) {
            continue;
          }
          resultArr[k - 1]["children"].push({
            "number": j,
            "name": name.text,
            "action": action.text
          });
        }
      }
    }
    var result = {"actions": resultArr};
    return result;
  },

  redraw: function() {
    $('canvas').removeLayerGroup($boxGroup)
        .drawLayers();
    this.getRoot().setBasePoint();
    this.getRoot().draw();
  }
};

