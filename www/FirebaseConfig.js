var exec = require("cordova/exec");
var PLUGIN_NAME = "FirebaseConfig";

function promiseParameter(type, key) {
    return new Promise(function(resolve, reject) {
        exec(resolve, reject, PLUGIN_NAME, "get" + type, [key || ""]);
    });
}

module.exports = {
    update: function(ttlSeconds) {
        return new Promise(function(resolve, reject) {
            exec(resolve, reject, PLUGIN_NAME, "update", [ttlSeconds || 0]);
        });
    },
    getBoolean: function(key) {
        return promiseParameter("Boolean", key);
    },
    getString: function(key) {
        return promiseParameter("String", key);
    },
    getNumber: function(key) {
        return promiseParameter("Number", key);
    },
    getBytes: function(key) {
        return promiseParameter("Bytes", key);
    }
};
