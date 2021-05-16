# Cordova plugin for [Firebase Remote Config](https://firebase.google.com/docs/remote-config/)

[![NPM version][npm-version]][npm-url] [![NPM downloads][npm-downloads]][npm-url] [![NPM total downloads][npm-total-downloads]][npm-url] [![PayPal donate](https://img.shields.io/badge/paypal-donate-ff69b4?logo=paypal)][donate-url] [![Twitter][twitter-follow]][twitter-url]

| [![Donate](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)][donate-url] | Your help is appreciated. Create a PR, submit a bug or just grab me :beer: |
|-|-|

## Index

<!-- MarkdownTOC levels="2" autolink="true" -->

- [Supported Platforms](#supported-platforms)
- [Installation](#installation)
- [Preferences](#preferences)
- [Methods](#methods)

<!-- /MarkdownTOC -->

## Supported Platforms

- iOS
- Android

## Installation

    $ cordova plugin add cordova-plugin-firebase-config

Use variables `IOS_FIREBASE_CONFIG_VERSION` and `ANDROID_FIREBASE_CONFIG_VERSION` to override dependency versions for Firebase SDKs.

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
    <entry>
        <key>param2</key>
        <value>value2</value>
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
    <key>param2</key>
    <string>value2</string>
</dict>
</plist>
```

## Methods
Every method call returns a promise which is optionally fulfilled with an appropriate value.

### fetch(_expirationDuration_)
Starts fetching configs, adhering to the specified minimum fetch interval.
```js
cordova.plugins.firebase.config.fetch(8 * 3600).then(function() {
    // your config was fetched
});
```

### activate()
Asynchronously activates the most recently fetched configs, so that the fetched key value pairs take effect.
```js
cordova.plugins.firebase.config.activate().then(function() {
    // your config was activated
});
```

### fetchAndActivate()
Asynchronously fetches and then activates the fetched configs.
```js
cordova.plugins.firebase.config.fetchAndActivate().then(function() {
    // your config was fetched and activated
});
```

### getBoolean(_key_)
```js
cordova.plugins.firebase.config.getBoolean("myBool").then(function(value) {
    // use value from remote config
});
```

### getString(_key_)
```js
cordova.plugins.firebase.config.getString("myStr").then(function(value) {
    // use value from remote config
});
```

### getNumber(_key_)
```js
cordova.plugins.firebase.config.getNumber("myNumber").then(function(value) {
    // use value from remote config
});
```

### getBytes(_key_)
```js
cordova.plugins.firebase.config.getBytes("myByteArray").then(function(value) {
    // use value from remote config
});
```

### getValueSource(_key_)
Returns source of the value for the specified key. Possible values:
- `"default"` - if the value was set as a default
- `"remote"` - if the value was retrieved from the server
- `"static"` - if no value was found and a static default value was returned instead

```js
cordova.plugins.firebase.config.getValueSource("myArbitraryValue").then(function(source) {
    // use source
});
```

[npm-url]: https://www.npmjs.com/package/cordova-plugin-firebase-config
[npm-version]: https://img.shields.io/npm/v/cordova-plugin-firebase-config.svg
[npm-downloads]: https://img.shields.io/npm/dm/cordova-plugin-firebase-config.svg
[npm-total-downloads]: https://img.shields.io/npm/dt/cordova-plugin-firebase-config.svg?label=total+downloads
[twitter-url]: https://twitter.com/chemerisuk
[twitter-follow]: https://img.shields.io/twitter/follow/chemerisuk.svg?style=social&label=Follow%20me
[donate-url]: https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=YYRKVZJSHLTNC&source=url

