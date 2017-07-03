var exec = require("cordova/exec");
var PLUGIN_NAME = "FirebaseConfig";

function getParameter(type, key, namespace, success, error) {
    if (typeof namespace === "function") {
        error = success;
        success = namespace;
        namespace = "";
    }

    exec(success, error, PLUGIN_NAME, "get" + type, [key, namespace]);
}

module.exports = {
    update: function(ttlSeconds, success, error) {
        exec(success, error, PLUGIN_NAME, "update", [ttlSeconds || 0]);
    },
    getBoolean: function(key, namespace, success, error) {
        getParameter("Boolean", key, namespace, function(value) {
            success(value === 1);
        }, error);
    },
    getString: function(key, namespace, success, error) {
        getParameter("String", key, namespace, success, error);
    },
    getNumber: function(key, namespace, success, error) {
        getParameter("Number", key, namespace, success, error);
    },
    getBytes: function(key, namespace, success, error) {
        getParameter("Bytes", key, namespace, success, error);
    }
};
