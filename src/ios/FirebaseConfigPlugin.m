#import "FirebaseConfigPlugin.h"
@import FirebaseCore;

@implementation FirebaseConfigPlugin

static const int VALUE_SOURCE_STATIC = 0;
static const int VALUE_SOURCE_DEFAULT = 1;
static const int VALUE_SOURCE_REMOTE = 2;

- (void)pluginInitialize {
    NSLog(@"Starting Firebase Remote Config plugin");

    if (![FIRApp defaultApp]) {
        [FIRApp configure];
    }

    self.remoteConfig = [FIRRemoteConfig remoteConfig];
    NSString* plistFilename = [self.commandDelegate.settings objectForKey:[@"FirebaseRemoteConfigDefaults" lowercaseString]];
    if (plistFilename) {
        [self.remoteConfig setDefaultsFromPlistFileName:plistFilename];
    }
}

- (void)fetch:(CDVInvokedUrlCommand *)command {
    long expirationDuration = [[command argumentAtIndex:0] longValue];

    [self.remoteConfig fetchWithExpirationDuration:expirationDuration completionHandler:^(FIRRemoteConfigFetchStatus status, NSError *err) {
        CDVPluginResult *pluginResult = nil;
        if (err) {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:err.localizedDescription];
        } else {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        }
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}

- (void)activate:(CDVInvokedUrlCommand *)command {
    [self.remoteConfig activateWithCompletion:^(BOOL changed, NSError * _Nullable err) {
        CDVPluginResult *pluginResult = nil;
        if (err) {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:err.localizedDescription];
        } else {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:changed];
        }
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}

- (void)fetchAndActivate:(CDVInvokedUrlCommand *)command {
    [self.remoteConfig fetchAndActivateWithCompletionHandler:^(FIRRemoteConfigFetchAndActivateStatus status, NSError * _Nullable err) {
        CDVPluginResult *pluginResult = nil;
        if (err) {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:err.localizedDescription];
        } else {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:
                            (status == FIRRemoteConfigFetchAndActivateStatusSuccessFetchedFromRemote)];
        }
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}

- (void)getString:(CDVInvokedUrlCommand *)command {
    FIRRemoteConfigValue *configValue = [self getConfigValue:command];
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK
                                                      messageAsString:configValue.stringValue];

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)getNumber:(CDVInvokedUrlCommand *)command {
    FIRRemoteConfigValue *configValue = [self getConfigValue:command];
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK
                                                      messageAsDouble:[configValue.numberValue doubleValue]];

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)getBoolean:(CDVInvokedUrlCommand *)command {
    FIRRemoteConfigValue *configValue = [self getConfigValue:command];
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK
                                                        messageAsBool:configValue.boolValue];

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)getBytes:(CDVInvokedUrlCommand *)command {
    FIRRemoteConfigValue *configValue = [self getConfigValue:command];
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK
                                                 messageAsArrayBuffer:configValue.dataValue];

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)getValueSource:(CDVInvokedUrlCommand*)command {
    FIRRemoteConfigValue *configValue = [self getConfigValue:command];
    
    CDVPluginResult *pluginResult = [CDVPluginResult
        resultWithStatus:CDVCommandStatus_OK
        messageAsInt:convertFIRRemoteConfigSourceToPluginResult(configValue.source)];

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

int convertFIRRemoteConfigSourceToPluginResult(FIRRemoteConfigSource value) {
  switch (value) {
    case FIRRemoteConfigSourceDefault:
      return VALUE_SOURCE_DEFAULT;
    case FIRRemoteConfigSourceRemote:
      return VALUE_SOURCE_REMOTE;
    case FIRRemoteConfigSourceStatic:
      return VALUE_SOURCE_STATIC;
    default:
      return VALUE_SOURCE_STATIC;
  }
}

- (FIRRemoteConfigValue*)getConfigValue:(CDVInvokedUrlCommand *)command {
    NSString* key = [command argumentAtIndex:0];

    return [self.remoteConfig configValueForKey:key];
}


@end
