#import <Cordova/CDV.h>
@import FirebaseRemoteConfig;

@interface FirebaseConfigPlugin : CDVPlugin

    - (void)update:(CDVInvokedUrlCommand*)command;
    - (void)getString:(CDVInvokedUrlCommand*)command;
    - (void)getNumber:(CDVInvokedUrlCommand*)command;
    - (void)getBoolean:(CDVInvokedUrlCommand*)command;
    - (void)getBytes:(CDVInvokedUrlCommand*)command;

    @property (nonatomic, strong) FIRRemoteConfig *remoteConfig;
@end
