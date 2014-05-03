// File: vango.js
define(function (require, exports, module) {
  (function (root, factory) {
    if (typeof exports === "object") {
      // Node
      module.exports = factory();
      // AMD loader
    }
    else if (typeof define === "function" && define.amd) {
      define(factory);
    }
    else{
      // Browser
      root.Vango = factory();
    }
  })(this, function () {
    // Factory for build Vango
    // return Vango
  })
})