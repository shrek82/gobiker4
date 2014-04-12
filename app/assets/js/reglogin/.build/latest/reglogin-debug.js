define("reglogin/latest/reglogin-debug", [ "lib/latest/lib-debug", "./login-debug", "./register-debug" ], function(require, exports, module) {
    var lib = require("lib/latest/lib-debug");
    exports.login = require("./login-debug");
    exports.register = require("./register-debug");
});