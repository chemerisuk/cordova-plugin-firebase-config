#import "FirebaseConfigPlugin.h"
@import Firebase;

@implementation FirebaseConfigPlugin

- (void)pluginInitialize {
    NSLog(@"Starting Firebase Remote Config plugin");

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
    NSString* sourceString = convertFIRRemoteConfigSourceToNSString(configValue.source);

    CDVPluginResult *pluginResult = sourceString == nil
        ? [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Unknown source"]
        : [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:sourceString];

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

NSString *convertFIRRemoteConfigSourceToNSString(FIRRemoteConfigSource value) {
  switch (value) {
    case FIRRemoteConfigSourceDefault:
      return @"default";
    case FIRRemoteConfigSourceRemote:
      return @"remote";
    case FIRRemoteConfigSourceStatic:
      return @"static";
    default:
      return nil;
  }
}

- (FIRRemoteConfigValue*)getConfigValue:(CDVInvokedUrlCommand *)command {
    NSString* key = [command argumentAtIndex:0];

    return [self.remoteConfig configValueForKey:key];
}


@end
