#import "FirebaseRemoteConfigPlugin.h"
@import Firebase;


@implementation FirebaseRemoteConfigPlugin

- (void)pluginInitialize {
    if(![FIRApp defaultApp]) {
        [FIRApp configure];
    }
}

@end
