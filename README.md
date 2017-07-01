# cordova-plugin-firebase-remoteconfig<br>[![NPM version][npm-version]][npm-url] [![NPM downloads][npm-downloads]][npm-url]
> Cordova plugin for [Firebase Remote Config](https://firebase.google.com/docs/remote-config/)

## Installation

    cordova plugin add cordova-plugin-firebase-remoteconfig --save

## Supported Platforms

- iOS
- Android

## Methods

### update(_ttlSeconds_, _callback_, _errorCallback_)
Fetches remote config values with appropriate TTL and then activates them.
```js
cordova.plugins.firebase.remoteconfig.update(8 * 3600, function() {
    // your config was updated
});
```

### getBoolean(_key_, [_namespace_, ]_callback_, _errorCallback_)
```js
cordova.plugins.firebase.remoteconfig.getBoolean("myBool", function(value) {
    // use value from remote config
});
```

### getString(_key_, [_namespace_, ]_callback_, _errorCallback_)
```js
cordova.plugins.firebase.remoteconfig.getString("myStr", function(value) {
    // use value from remote config
});
```

### getNumber(_key_, [_namespace_, ]_callback_, _errorCallback_)
```js
cordova.plugins.firebase.remoteconfig.getNumber("myNumber", function(value) {
    // use value from remote config
});
```

### getBytes(_key_, [_namespace_, ]_callback_, _errorCallback_)
```js
cordova.plugins.firebase.remoteconfig.getBytes("myByteArray", function(value) {
    // use value from remote config
});
```

[npm-url]: https://www.npmjs.com/package/cordova-plugin-firebase-remoteconfig
[npm-version]: https://img.shields.io/npm/v/cordova-plugin-firebase-remoteconfig.svg
[npm-downloads]: https://img.shields.io/npm/dt/cordova-plugin-firebase-remoteconfig.svg