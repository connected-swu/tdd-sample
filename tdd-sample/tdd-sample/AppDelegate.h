//
//  AppDelegate.h
//  tdd-sample
//

#import <UIKit/UIKit.h>
#import <Blindside/Blindside.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, readonly) id<BSInjector> injector;
@property (nonatomic, readonly) id<BSModule> module;

@end

