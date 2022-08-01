# Cordova plugin for [Firebase Remote Config](https://firebase.google.com/docs/remote-config/)

[![NPM version][npm-version]][npm-url] [![NPM downloads][npm-downloads]][npm-url] [![NPM total downloads][npm-total-downloads]][npm-url] [![PayPal donate](https://img.shields.io/badge/paypal-donate-ff69b4?logo=paypal)][donate-url] [![Twitter][twitter-follow]][twitter-url]

| [![Donate](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)][donate-url] | Your help is appreciated. Create a PR, submit a bug or just grab me :beer: |
|-|-|

[npm-url]: https://www.npmjs.com/package/cordova-plugin-firebase-config
[npm-version]: https://img.shields.io/npm/v/cordova-plugin-firebase-config.svg
[npm-downloads]: https://img.shields.io/npm/dm/cordova-plugin-firebase-config.svg
[npm-total-downloads]: https://img.shields.io/npm/dt/cordova-plugin-firebase-config.svg?label=total+downloads
[twitter-url]: https://twitter.com/chemerisuk
[twitter-follow]: https://img.shields.io/twitter/follow/chemerisuk.svg?style=social&label=Follow%20me
[donate-url]: https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=YYRKVZJSHLTNC&source=url

## Index

<!-- MarkdownTOC levels="2,3" autolink="true" -->

- [Supported Platforms](#supported-platforms)
- [Installation](#installation)
    - [Adding required configuration files](#adding-required-configuration-files)
- [Preferences](#preferences)
- [Variables](#variables)
    - [VALUE\_SOURCE\_DEFAULT](#value_source_default)
    - [VALUE\_SOURCE\_REMOTE](#value_source_remote)
    - [VALUE\_SOURCE\_STATIC](#value_source_static)
- [Functions](#functions)
    - [activate](#activate)
    - [fetch](#fetch)
    - [fetchAndActivate](#fetchandactivate)
    - [getBoolean](#getboolean)
    - [getBytes](#getbytes)
    - [getNumber](#getnumber)
    - [getString](#getstring)
    - [getValueSource](#getvaluesource)

<!-- /MarkdownTOC -->

## Supported Platforms

- iOS
- Android

## Installation

    $ cordova plugin add cordova-plugin-firebase-config

Use variables `IOS_FIREBASE_POD_VERSION` and `ANDROID_FIREBASE_BOM_VERSION` to override dependency versions for Firebase SDKs:

    $ cordova plugin add cordova-plugin-firebase-config \
    --variable IOS_FIREBASE_POD_VERSION="9.3.0" \
    --variable ANDROID_FIREBASE_BOM_VERSION="30.3.1"

### Adding required configuration files

Cordova supports `resource-file` tag for easy copying resources files. Firebase SDK requires `google-services.json` on Android and `GoogleService-Info.plist` on iOS platforms.

1. Put `google-services.json` and/or `GoogleService-Info.plist` into the root directory of your Cordova project
2. Add new tag for Android platform

```xml
<platform name="android">
    ...
    <resource-file src="google-services.json" target="app/google-services.json" />
</platform>
...
<platform name="ios">
    ...
    <resource-file src="GoogleService-Info.plist" />
</platform>
```

## Preferences
You can specify `FirebaseRemoteConfigDefaults` in `config.xml` to define filename of a file with default values. Keep in mind that android and ios have different naming convensions there it's useful to specify different file names.

```xml
<platform name="android">
    ...
    <preference name="FirebaseRemoteConfigDefaults" value="remote_config_defaults" />
    <resource-file src="resources/android/remote_config_defaults.xml" target="app/src/main/res/xml/remote_config_defaults.xml" />
</platform>

<platform name="ios">
    ...
    <preference name="FirebaseRemoteConfigDefaults" value="RemoteConfigDefaults" />
    <resource-file src="resources/ios/RemoteConfigDefaults.plist" />
</platform>
```

On Android platform file `remote_config_defaults.xml` has a structure like below:
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

On iOS platform file `RemoteConfigDefaults.plist` has a structure like below:
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

<!-- TypedocGenerated -->

## Variables

### VALUE\_SOURCE\_DEFAULT

 **VALUE\_SOURCE\_DEFAULT**: `number`

Indicates that the value returned was retrieved from the defaults set by the client.

**`Constant`**

___

### VALUE\_SOURCE\_REMOTE

 **VALUE\_SOURCE\_REMOTE**: `number`

Indicates that the value returned was retrieved from the Firebase Remote Config Server.

**`Constant`**

___

### VALUE\_SOURCE\_STATIC

 **VALUE\_SOURCE\_STATIC**: `number`

Indicates that the value returned is the static default value.

**`Constant`**

## Functions

### activate

**activate**(): `Promise`<`boolean`\>

Asynchronously activates the most recently fetched configs, so that the fetched key value pairs take effect.

**`Example`**

```ts
cordova.plugins.firebase.config.activate();
```

#### Returns

`Promise`<`boolean`\>

Fulfills promise with flag if current config was activated

___

### fetch

**fetch**(`expirationDuration`): `Promise`<`void`\>

Starts fetching configs, adhering to the specified minimum fetch interval.

**`Example`**

```ts
cordova.plugins.firebase.config.fetch(8 * 3600);
```

#### Parameters

| Name | Type | Description |
| :------ | :------ | :------ |
| `expirationDuration` | `number` | Minimum fetch interval in seconds |

#### Returns

`Promise`<`void`\>

Callback when operation is completed

___

### fetchAndActivate

**fetchAndActivate**(): `Promise`<`boolean`\>

Asynchronously fetches and then activates the fetched configs.

**`Example`**

```ts
cordova.plugins.firebase.config.fetchAndActivate();
```

#### Returns

`Promise`<`boolean`\>

Fulfills promise with flag if current config was activated

___

### getBoolean

**getBoolean**(`key`): `Promise`<`boolean`\>

Returns the boolean parameter value for the given key

**`Example`**

```ts
cordova.plugins.firebase.config.getBoolean("myBool").then(function(value) {
    // use value from remote config
});
```

#### Parameters

| Name | Type | Description |
| :------ | :------ | :------ |
| `key` | `string` | Parameter key |

#### Returns

`Promise`<`boolean`\>

Fulfills promise with parameter value

___

### getBytes

**getBytes**(`key`): `Promise`<`ArrayBuffer`\>

Returns the bytes parameter value for the given key

**`Example`**

```ts
cordova.plugins.firebase.config.getBytes("myByteArray").then(function(value) {
    // use value from remote config
});
```

#### Parameters

| Name | Type | Description |
| :------ | :------ | :------ |
| `key` | `string` | Parameter key |

#### Returns

`Promise`<`ArrayBuffer`\>

Fulfills promise with parameter value

___

### getNumber

**getNumber**(`key`): `Promise`<`number`\>

Returns the number parameter value for the given key

**`Example`**

```ts
cordova.plugins.firebase.config.getNumber("myNumber").then(function(value) {
    // use value from remote config
});
```

#### Parameters

| Name | Type | Description |
| :------ | :------ | :------ |
| `key` | `string` | Parameter key |

#### Returns

`Promise`<`number`\>

Fulfills promise with parameter value

___

### getString

**getString**(`key`): `Promise`<`string`\>

Returns the string parameter value for the given key

**`Example`**

```ts
cordova.plugins.firebase.config.getString("myStr").then(function(value) {
    // use value from remote config
});
```

#### Parameters

| Name | Type | Description |
| :------ | :------ | :------ |
| `key` | `string` | Parameter key |

#### Returns

`Promise`<`string`\>

Fulfills promise with parameter value

___

### getValueSource

**getValueSource**(`key`): `Promise`<`number`\>

Returns source of the value for the specified key.

**`Example`**

```ts
cordova.plugins.firebase.config.getValueSource("myArbitraryValue").then(function(source) {
    if (source === cordova.plugins.firebase.config.VALUE_SOURCE_DEFAULT) {
        // ...
    }
});
```

#### Parameters

| Name | Type | Description |
| :------ | :------ | :------ |
| `key` | `string` | Parameter key |

#### Returns

`Promise`<`number`\>

Fulfills promise with parameter value
