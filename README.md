# cordova-plugin-firebase-config<br>[![NPM version][npm-version]][npm-url] [![NPM downloads][npm-downloads]][npm-url]
> Cordova plugin for [Firebase Remote Config](https://firebase.google.com/docs/remote-config/)

## Installation

    cordova plugin add cordova-plugin-firebase-config --save

If you need to set a specific dependency version on Android then use variable `FIREBASE_VERSION`.

## Supported Platforms

- iOS
- Android

## Preferences
You can specify `FirebaseRemoteConfigDefaults` in `config.xml` to define filename of a file with default values.

On Android the file is located at `platforms/android/res/xml/${filename}.xml` and has a structure like below:
```xml
<?xml version="1.0" encoding="utf-8"?>
<defaultsMap>
    <entry>
        <key>param1</key>
        <value>value1</value>
    </entry>
</defaultsMap>
```

On iOS file the file is located at `platforms/ios/<Your App Name>/${filename}.plist` and has a structure like below:
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>param1</key>
    <string>value1</string>
</dict>
</plist>
```

## Methods
Every method call returns a promise which is optionally fulfilled with an appropriate value.

### update(_ttlSeconds_, _callback_, _errorCallback_)
Fetches remote config values with appropriate TTL and then activates them.
```js
cordova.plugins.firebase.config.update(8 * 3600).then(function() {
    // your config was updated
});
```

### getBoolean(_key_, [_namespace_, ]_callback_, _errorCallback_)
```js
cordova.plugins.firebase.config.getBoolean("myBool").then(function(value) {
    // use value from remote config
});
```

### getString(_key_, [_namespace_, ]_callback_, _errorCallback_)
```js
cordova.plugins.firebase.config.getString("myStr").then(function(value) {
    // use value from remote config
});
```

### getNumber(_key_, [_namespace_, ]_callback_, _errorCallback_)
```js
cordova.plugins.firebase.config.getNumber("myNumber").then(function(value) {
    // use value from remote config
});
```

### getBytes(_key_, [_namespace_, ]_callback_, _errorCallback_)
```js
cordova.plugins.firebase.config.getBytes("myByteArray").then(function(value) {
    // use value from remote config
});
```

[npm-url]: https://www.npmjs.com/package/cordova-plugin-firebase-config
[npm-version]: https://img.shields.io/npm/v/cordova-plugin-firebase-config.svg
[npm-downloads]: https://img.shields.io/npm/dt/cordova-plugin-firebase-config.svg