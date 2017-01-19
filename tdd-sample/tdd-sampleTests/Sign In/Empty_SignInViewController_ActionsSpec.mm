#import <Cedar/Cedar.h>

#import "SignInViewController.h"


using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(Empty_SignInViewController_ActionsSpec)

describe(@"signing in", ^{
    __block SignInViewController *subject;
    
    beforeEach(^{
        
    });
    it(@"should make an authentication request", ^{
        
    });
    
    context(@"successful", ^{
        beforeEach(^{
            
        });
        it(@"should make fetch user profile", ^{
            
        });
        
        context(@"fetch user profile successful", ^{
            beforeEach(^{
                
            });
            it(@"should fetch user sign-in history", ^{
                
            });
            
            context(@"fetch user sign-in history successful", ^{
                beforeEach(^{
                    
                });
                it(@"should update last signed-in time", ^{
                    
                });
            });
            
            context(@"fetch user sign-in history failed", ^{
                beforeEach(^{
                    
                });
                it(@"should show a failed to sign-in error dialog", ^{
                    
                });
            });
        });
        
        context(@"fetch user profile failed", ^{
            beforeEach(^{
                
            });
            it(@"should show a failed to sign-in error dialog", ^{
                
            });
        });
    });
    
    context(@"failed", ^{
        beforeEach(^{
            
        });
        it(@"should show an authentication failure error dialog", ^{
            
        });
    });
});

SPEC_END
