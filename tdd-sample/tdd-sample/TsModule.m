//
//  TsModule.m
//  tdd-sample
//

#import "TsModule.h"
#import "DataService.h"


@implementation TsModule

- (void)configure:(id<BSBinder>)binder {
    /*
     This is where our bindings live.  Notice that we have decided to make DataService a singleton.
     */
    
    [binder bind:DataService.class withScope:BSSingleton.scope];
    
    /*
     Blindside is able to naturally infer class keys for automatic instantiation.  The key in the line above is DataService.class.  An object is automatically instantiated when you supply a BSInitializer or BSPropertySet, otherwise vanilla init is used.
     
     When picking keys, you could choose to use a protocol or string as well,
     
     e.g.  using a protocol key and binding to class & leaving scope blank (this means a new instance is created everytime it is injected)
     [binder bind:@protocol(DataServicing) toClass:DataService.class];
    
     e.g.  using a string key
     [binder bind:@"aSpecificDataService" toClass:DataService.class];
     */
}

@end
