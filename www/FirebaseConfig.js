var exec = require("cordova/exec");
var PLUGIN_NAME = "FirebaseConfig";

function promiseParameter(type, key) {
    return new Promise(function(resolve, reject) {
        exec(resolve, reject, PLUGIN_NAME, "get" + type, [key || ""]);
    });
}

module.exports = {
    VALUE_SOURCE_STATIC: 0,
    VALUE_SOURCE_DEFAULT: 1,
    VALUE_SOURCE_REMOTE: 2,

    fetch: function(expirationDuration) {
        return new Promise(function(resolve, reject) {
            exec(resolve, reject, PLUGIN_NAME, "fetch", [expirationDuration || 0]);
        });
    },
    activate: function() {
        return new Promise(function(resolve, reject) {
            exec(resolve, reject, PLUGIN_NAME, "activate", []);
        });
    },
    fetchAndActivate: function() {
        return new Promise(function(resolve, reject) {
            exec(resolve, reject, PLUGIN_NAME, "fetchAndActivate", []);
        });
    },
    getValueSource: function(key) {
        return promiseParameter("ValueSource", key);
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
