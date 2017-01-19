//
//  TsSpecModule.h
//  tdd-sample
//

#import <Foundation/Foundation.h>
#import <Blindside/Blindside.h>


@interface TsSpecModule : NSObject <BSModule>
/** This returns an injector with default test bindings, as well as the custom bindings you make with the wiring block */
+ (id<BSInjector>)injectorWithCustomWiring:(void (^)(id<BSBinder>))wiring;
@end



