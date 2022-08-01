#import <Cordova/CDV.h>
@import FirebaseRemoteConfig;

@interface FirebaseConfigPlugin : CDVPlugin

    - (void)fetch:(CDVInvokedUrlCommand*)command;
    - (void)activate:(CDVInvokedUrlCommand*)command;
    - (void)fetchAndActivate:(CDVInvokedUrlCommand*)command;
    - (void)getString:(CDVInvokedUrlCommand*)command;
    - (void)getNumber:(CDVInvokedUrlCommand*)command;
    - (void)getBoolean:(CDVInvokedUrlCommand*)command;
    - (void)getBytes:(CDVInvokedUrlCommand*)command;
    - (void)getValueSource:(CDVInvokedUrlCommand*)command;

    @property (nonatomic, strong) FIRRemoteConfig *remoteConfig;
@end
