//
//  main.m
//  tdd-sample
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    
    @autoreleasepool {
        /*
         The AppDelegate often performs start-up tasks such as configuring
         Fabric, Google maps, Google analytics, etc.  To prevent (1) test
         contamination, and (2) contamination of integrations such as the
         ones mentioned above, we choose to use a SpecAppDelegate instead.
         */
        NSString *appDelegateName = NSStringFromClass([AppDelegate class]);
        BOOL isRunningTests = [[NSProcessInfo processInfo] environment][@"XCTestConfigurationFilePath"] != nil;
        if (isRunningTests) {
            appDelegateName = @"SpecAppDelegate";
        }
        return UIApplicationMain(argc, argv, nil, appDelegateName);
    }
}
