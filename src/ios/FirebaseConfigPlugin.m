#import "FirebaseConfigPlugin.h"
@import Firebase;

@implementation FirebaseConfigPlugin

- (void)pluginInitialize {
    NSLog(@"Starting Firebase Remote Config plugin");

    if(![FIRApp defaultApp]) {
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
    BOOL wasActivated = self.remoteConfig.lastFetchStatus == FIRRemoteConfigFetchAndActivateStatusSuccessFetchedFromRemote;
    [self.remoteConfig activateWithCompletionHandler:^(NSError * _Nullable err) {
        CDVPluginResult *pluginResult = nil;
        if (err) {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:err.localizedDescription];
        } else {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:
                            (!wasActivated && self.remoteConfig.lastFetchStatus == FIRRemoteConfigFetchAndActivateStatusSuccessFetchedFromRemote)];
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

- (FIRRemoteConfigValue*)getConfigValue:(CDVInvokedUrlCommand *)command {
    NSString* key = [command argumentAtIndex:0];

    return [self.remoteConfig configValueForKey:key];
}


@end
