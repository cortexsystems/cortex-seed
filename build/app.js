(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);throw new Error("Cannot find module '"+o+"'")}var f=n[o]={exports:{}};t[o][0].call(f.exports,function(e){var n=t[o][1][e];return s(n?n:e)},f,f.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
var View, main;

View = require('./view');

main = function() {
  return window.addEventListener('cortex-ready', function() {
    return window.Cortex.app.getConfig().then(function(config) {
      window.CortexView = new View(config);
      return window.Cortex.scheduler.onPrepare(window.CortexView.prepare);
    })["catch"](function(e) {
      console.error('Failed to initialize the application.', e);
      throw e;
    });
  });
};

module.exports = main();



},{"./view":2}],2:[function(require,module,exports){
var View,
  bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

View = (function() {
  function View(config) {
    this.prepare = bind(this.prepare, this);
    this._name = config['cortex-seed.name'];
  }

  View.prototype.prepare = function(offer) {
    var container, node;
    container = document.getElementById('container');
    node = this._createHelloWorldNode();
    return offer((function(_this) {
      return function(done) {
        _this._render(node, container);
        return setTimeout(done, 5000);
      };
    })(this));
  };

  View.prototype._render = function(node, continer) {
    while (continer.firstChild != null) {
      continer.removeChild(continer.firstChild);
    }
    return continer.appendChild(node);
  };

  View.prototype._createHelloWorldNode = function() {
    var h1, text;
    h1 = document.createElement('h1');
    text = document.createTextNode("Hello, " + this._name);
    h1.appendChild(text);
    return h1;
  };

  return View;

})();

module.exports = View;



},{}]},{},[1])