//
//  UIViewController+SpecInstantiation.h
//  tdd-sample
//

#import <UIKit/UIKit.h>
#import <Blindside/Blindside.h>


@interface UIViewController (SpecInstantiation)

+ (instancetype)ts_withCustomWiring:(void (^)(id<BSBinder>))wiring;
+ (instancetype)ts_withInjector:(id<BSInjector>)injector;
@end
