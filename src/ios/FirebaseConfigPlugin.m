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

- (void)update:(CDVInvokedUrlCommand *)command {
    NSNumber* ttlSeconds = [command argumentAtIndex:0];
    long expirationDuration = [ttlSeconds longValue];

    if (expirationDuration == 0) {
        FIRRemoteConfigSettings *remoteConfigSettings = [[FIRRemoteConfigSettings alloc] initWithDeveloperModeEnabled:YES];
        self.remoteConfig.configSettings = remoteConfigSettings;
    }

    [self.commandDelegate runInBackground: ^{
        [self.remoteConfig fetchWithExpirationDuration:expirationDuration completionHandler:^(FIRRemoteConfigFetchStatus status, NSError *error) {
            CDVPluginResult *pluginResult = nil;

            if (status == FIRRemoteConfigFetchStatusSuccess) {
                [self.remoteConfig activateFetched];

                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
            } else {
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:error.localizedDescription];
            }

            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }];
    }];
}

- (void)getString:(CDVInvokedUrlCommand *)command {
    NSString* key = [command argumentAtIndex:0];
    NSString* namespace = [command argumentAtIndex:1];

    [self.commandDelegate runInBackground: ^{
        CDVPluginResult *pluginResult = nil;
        FIRRemoteConfigValue *configValue = nil;

        if ([namespace length] == 0) {
            configValue = [self.remoteConfig configValueForKey:key];
        } else {
            configValue = [self.remoteConfig configValueForKey:key namespace:namespace];
        }

        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:configValue.stringValue];

        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}

- (void)getNumber:(CDVInvokedUrlCommand *)command {
    NSString* key = [command argumentAtIndex:0];
    NSString* namespace = [command argumentAtIndex:1];

    [self.commandDelegate runInBackground: ^{
        CDVPluginResult *pluginResult = nil;
        FIRRemoteConfigValue *configValue = nil;

        if ([namespace length] == 0) {
            configValue = [self.remoteConfig configValueForKey:key];
        } else {
            configValue = [self.remoteConfig configValueForKey:key namespace:namespace];
        }

        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDouble:[configValue.numberValue doubleValue]];

        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}

- (void)getBoolean:(CDVInvokedUrlCommand *)command {
    NSString* key = [command argumentAtIndex:0];
    NSString* namespace = [command argumentAtIndex:1];

    [self.commandDelegate runInBackground: ^{
        CDVPluginResult *pluginResult = nil;
        FIRRemoteConfigValue *configValue = nil;

        if ([namespace length] == 0) {
            configValue = [self.remoteConfig configValueForKey:key];
        } else {
            configValue = [self.remoteConfig configValueForKey:key namespace:namespace];
        }

        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:configValue.boolValue];

        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}

- (void)getBytes:(CDVInvokedUrlCommand *)command {
    NSString* key = [command argumentAtIndex:0];
    NSString* namespace = [command argumentAtIndex:1];

    [self.commandDelegate runInBackground: ^{
        CDVPluginResult *pluginResult = nil;
        FIRRemoteConfigValue *configValue = nil;

        if ([namespace length] == 0) {
            configValue = [self.remoteConfig configValueForKey:key];
        } else {
            configValue = [self.remoteConfig configValueForKey:key namespace:namespace];
        }

        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsArrayBuffer:configValue.dataValue];

        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}


@end
