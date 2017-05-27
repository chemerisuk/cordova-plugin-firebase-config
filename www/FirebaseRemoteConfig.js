var exec = require("cordova/exec");
var PLUGIN_NAME = "FirebaseRemoteConfigPlugin";

function getParameter(type, key, namespace, success, error) {
    if (typeof namespace === "function") {
        error = success;
        success = namespace;
        namespace = null;
    }

    exec(success, error, PLUGIN_NAME, "get" + type, [key, namespace]);
}

module.exports = {
    update: function(ttlSeconds, success, error) {
        exec(success, error, PLUGIN_NAME, "update", [ttlSeconds]);
    },
    getBoolean: function(key, namespace, success, error) {
        getParameter("Boolean", key, namespace, success, error);
    },
    getByteArray: function(key, namespace, success, error) {
        getParameter("ByteArray", key, namespace, success, error);
    },
    getDouble: function(key, namespace, success, error) {
        getParameter("Double", key, namespace, success, error);
    },
    getLong: function(key, namespace, success, error) {
        getParameter("Long", key, namespace, success, error);
    },
    getString: function(key, namespace, success, error) {
        getParameter("String", key, namespace, success, error);
    }
};
