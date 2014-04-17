define("lib/latest/lib-debug", [ "./jquery-debug", "./popup-debug", "./class-debug", "./ajaxForm-debug", "./jquery_form-debug" ], function(require, exports, module) {
    window.$ = window.jQuery = require("./jquery-debug");
    //定义基本功能
    var lib = {};
    module.exports = lib;
    //基本库扩展
    lib.popup = require("./popup-debug");
    lib.Class = require("./class-debug");
    lib.ajaxForm = require("./ajaxForm-debug");
});