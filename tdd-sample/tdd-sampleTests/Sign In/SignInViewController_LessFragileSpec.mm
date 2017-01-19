#import <Cedar/Cedar.h>

#import "SignInViewController2.h"
#import "SignInViewController3.h"


using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(SignInViewController_LessFragileSpec)

describe(@"SignInViewController_LessFragile", ^{
    __block SignInViewController2 *subject;
    
    beforeEach(^{
        
    });
    
    describe(@"displaying content", ^{
        beforeEach(^{
            
        });
        it(@"should show a 'email' field", ^{
            
        });
        it(@"should show a 'password' field", ^{
            
        });
        it(@"should show a 'sign-in' button", ^{
            
        });
        it(@"should show the connected-lab logo", ^{
            
        });
    });
    
    describe(@"signing in", ^{
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
});

SPEC_END
