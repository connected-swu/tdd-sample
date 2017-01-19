//
//  UIViewController+SpecInstantiation.m
//  tdd-sample
//

#import <BlindsidedStoryboard/BlindsidedStoryboard.h>
#import "UIViewController+SpecInstantiation.h"
#import "TsSpecModule.h"


@implementation UIViewController (SpecInstantiation)
+ (instancetype)ts_withCustomWiring:(void (^)(id<BSBinder>))wiring {
    id<BSInjector> injector = [TsSpecModule injectorWithCustomWiring:wiring];
    return [self ts_withInjector:injector];
}
+ (instancetype)ts_withInjector:(id<BSInjector>)injector {
    BlindsidedStoryboard *storyboard = [BlindsidedStoryboard storyboardWithName:@"Main" bundle:nil injector:injector];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass(self.class)];
}
@end
