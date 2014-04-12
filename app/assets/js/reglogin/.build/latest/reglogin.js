define("reglogin/latest/reglogin", [ "lib/latest/lib", "./login", "./register" ], function(require, exports, module) {
    var lib = require("lib/latest/lib");
    exports.login = require("./login");
    exports.register = require("./register");
});