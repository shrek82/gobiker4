define("lib/1.0.0/lib", [ "./jquery", "./popup", "./class", "./ajaxForm", "./jquery_form" ], function(require, exports, module) {
    window.$ = window.jQuery = require("./jquery");
    //定义基本功能
    var lib = {};
    module.exports = lib;
    //基本库扩展
    lib.popup = require("./popup");
    lib.Class = require("./class");
    lib.ajaxForm = require("./ajaxForm");
});