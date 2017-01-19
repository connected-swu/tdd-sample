//
//  TsSpecModule.m
//  tdd-sample
//

#import "TsSpecModule.h"
#import "DataService.h"


@implementation TsSpecModule

+ (id<BSInjector>)injectorWithCustomWiring:(void (^)(id<BSBinder>))wiring {
    TsSpecModule *specModule = [[TsSpecModule alloc] init];
    id binderInjector = [Blindside injectorWithModule:specModule];
    if (wiring) {
        wiring(binderInjector);
    }
    return binderInjector;
}

- (void)configure:(id<BSBinder>)binder {
    /*
     This is where our default test bindings live.  Since DataService makes network calls, we bind it to BS_NULL so that no real network calls are ever fired during testing.
     */
    [binder bind:DataService.class toInstance:BS_NULL];
}

@end
