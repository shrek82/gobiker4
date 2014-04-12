define("lib/1.0.0/lib-debug", [ "./jquery-debug", "./popup-debug", "./ajaxForm-debug", "./jquery_form-debug" ], function(require, exports, module) {
    window.$ = window.jQuery = require("./jquery-debug");
    //定义基本功能
    var lib = {};
    lib.popup = require("./popup-debug");
    //ajax表单提交
    lib.ajaxForm = require("./ajaxForm-debug");
    module.exports = lib;
});