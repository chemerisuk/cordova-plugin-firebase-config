# cordova-plugin-firebase-config<br>[![NPM version][npm-version]][npm-url] [![NPM downloads][npm-downloads]][npm-url]
> Cordova plugin for [Firebase Remote Config](https://firebase.google.com/docs/remote-config/)

## Installation

    cordova plugin add cordova-plugin-firebase-config --save

## Supported Platforms

- iOS
- Android

## Methods

### update(_ttlSeconds_, _callback_, _errorCallback_)
Fetches remote config values with appropriate TTL and then activates them.
```js
cordova.plugins.firebase.config.update(8 * 3600, function() {
    // your config was updated
});
```

### getBoolean(_key_, [_namespace_, ]_callback_, _errorCallback_)
```js
cordova.plugins.firebase.config.getBoolean("myBool", function(value) {
    // use value from remote config
});
```

### getString(_key_, [_namespace_, ]_callback_, _errorCallback_)
```js
cordova.plugins.firebase.config.getString("myStr", function(value) {
    // use value from remote config
});
```

### getNumber(_key_, [_namespace_, ]_callback_, _errorCallback_)
```js
cordova.plugins.firebase.config.getNumber("myNumber", function(value) {
    // use value from remote config
});
```

### getBytes(_key_, [_namespace_, ]_callback_, _errorCallback_)
```js
cordova.plugins.firebase.config.getBytes("myByteArray", function(value) {
    // use value from remote config
});
```

[npm-url]: https://www.npmjs.com/package/cordova-plugin-firebase-config
[npm-version]: https://img.shields.io/npm/v/cordova-plugin-firebase-config.svg
[npm-downloads]: https://img.shields.io/npm/dt/cordova-plugin-firebase-config.svg