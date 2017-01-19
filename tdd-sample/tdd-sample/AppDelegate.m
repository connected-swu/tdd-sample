//
//  AppDelegate.m
//  tdd-sample
//

#import "AppDelegate.h"
#import "TsModule.h"


@interface AppDelegate ()
@property (strong, nonatomic, readwrite) id<BSInjector> injector;
@property (strong, nonatomic, readwrite) id<BSModule> module;
@end


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    return YES;
}

#pragma mark - Blindside DI Setup

- (id<BSModule>)module {
    if (!_module) {
        _module = [[TsModule alloc] init];
    }
    return _module;
}

- (id<BSInjector>)injector {
    if (!_injector) {
        _injector = [Blindside injectorWithModule:self.module];
    }
    return _injector;
}

@end
