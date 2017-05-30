#import <Cordova/CDV.h>
@import Firebase;

@interface FirebaseRemoteConfigPlugin : CDVPlugin

    - (void)update:(CDVInvokedUrlCommand*)command;
    - (void)getString:(CDVInvokedUrlCommand*)command;
    - (void)getNumber:(CDVInvokedUrlCommand*)command;
    - (void)getBoolean:(CDVInvokedUrlCommand*)command;
    - (void)getByteArray:(CDVInvokedUrlCommand*)command;

    @property (nonatomic, strong) FIRRemoteConfig *remoteConfig;
@end
