//
//  DataService.h
//  tdd-sample
//

#import <Foundation/Foundation.h>
#import <KSDeferred/KSDeferred.h>


@class TsUser;
@class TsSignInEvent;

@interface DataService : NSObject

- (KSPromise <NSString *> *)authWithEmail:(NSString *)email
                                 password:(NSString *)password;
- (KSPromise <TsUser *> *)fetchUserProfile;
- (KSPromise <NSArray <TsSignInEvent *> *> *)fetchUserSignInHistory;

@end
