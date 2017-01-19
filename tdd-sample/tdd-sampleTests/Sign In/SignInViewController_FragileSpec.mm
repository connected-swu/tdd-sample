#import <Cedar/Cedar.h>
#import <BlindsidedStoryboard/BlindsidedStoryboard.h>
#import "TsSpecModule.h"
#import "UIViewController+SpecInstantiation.h"

#import "SignInViewController2.h"
#import "SignInViewController3.h"
#import "DataService.h"


using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(SignInViewController_FragileSpec)

fdescribe(@"SignInViewController_Fragile", ^{
    __block SignInViewController2 *subject;
    __block DataService *dataServiceFake;

    beforeEach(^{
        dataServiceFake = nice_fake_for(DataService.class);
        
        // A lot of wiring here
        id<BSInjector> injector = [TsSpecModule injectorWithCustomWiring:^(id<BSBinder> binder) {
            [binder bind:DataService.class toInstance:dataServiceFake];
        }];
        BlindsidedStoryboard *storyboard =
        [BlindsidedStoryboard storyboardWithName:@"Main"
                                          bundle:nil
                                        injector:injector];
        subject = [storyboard instantiateViewControllerWithIdentifier:@"SignInViewController2"];
        
        // A lot of lifecycle boilerplate here
        UIWindow *window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
        window.rootViewController = subject;
        [window makeKeyAndVisible];
        [subject view];
        [subject viewWillAppear:NO];
        
        /*
         Overall, it looks like just getting started on testing ANYTHING requres a ton of boiler plate setup.  Is this really worth it?
         */
    });
    
    describe(@"displaying content", ^{
        it(@"should show a 'email' field", ^{
            [subject.emailTextField.placeholder isEqual:@"email"] should be_truthy;
            /*
             `be_truthy` is not an informative matcher.  When this test fails, it will show `Expected <NO> to evaluate to true`
             */
        });
        it(@"should show a 'password' field", ^{
            subject.passwordTextField.placeholder should equal(@"password");
            /*
             `equal` is a better matcher.  When this test fails, it will show `Expected <_p> to equal <password>`
             */
        });
        it(@"should show a 'sign-in' button", ^{
            // subject.signInButton should_not be_nil;
            // The above line is actually tested in the following line as well.
            [subject.signInButton titleForState:UIControlStateNormal] should equal(@"SIGN IN");
            
        });
        it(@"should show the connected-lab logo", ^{
            NSData *expectedData = UIImagePNGRepresentation([UIImage imageNamed:@"connected_logo"]);
            NSData *actualData = UIImagePNGRepresentation(subject.logoImageView.image);
            expectedData should equal(actualData);
            /* 
             Both this assertion and the above 'sign-in'-button assertion seem a bit unncessary or contrived.  We seem to be duplicating production code in the test!  Does this mean,
             (1) We don't test these things?
             (2) We try to eliminate all the boilerplate with helpers?
             */
        });
    });
    
    describe(@"signing in", ^{
        __block KSDeferred *authRequest;
        
        beforeEach(^{
            authRequest = [KSDeferred defer];
            dataServiceFake stub_method(@selector(authWithEmail:password:))
            .and_return(authRequest.promise);
            
            subject.emailTextField.text = @"swu@connectedlab.com";
            subject.passwordTextField.text = @"password";
            [subject.signInButton sendActionsForControlEvents:UIControlEventTouchUpInside];
        });
        it(@"should make an authentication request", ^{
            dataServiceFake should have_received(@selector(authWithEmail:password:))
            .with(@"swu@connectedlab.com", @"password");
        });
        
        context(@"successful", ^{
            __block KSDeferred *userProfileRequest;
            
            beforeEach(^{
                userProfileRequest = [KSDeferred defer];
                dataServiceFake stub_method(@selector(fetchUserProfile))
                .and_return(userProfileRequest.promise);
                
                [authRequest resolveWithValue:nil];
            });
            it(@"should make fetch user profile", ^{
                dataServiceFake should have_received(@selector(fetchUserProfile));
            });
            
            context(@"fetch user profile successful", ^{
                __block KSDeferred *userHistoryRequest;
                
                beforeEach(^{
                    /*
                     We are proliferating a lot of KSDeferred objects here to simulate our chained network requests.  This is quite a bit of verbose boiler plate code that reduces readability.  When interacting on a fine-grain level with another object, this often happens, we can consider,
                     (1) Using a mock object as opposed to fake
                     (2) Using a real object and stub out items
                     (3) Subclassing the real object and supply fake implementations
                     
                     I personally don't recomment (2) and (3), but (1) can often improve test readability.
                     What is the difference between 'mock', 'fake', and 'real'
                     */
                    userHistoryRequest = [KSDeferred defer];
                    dataServiceFake stub_method(@selector(fetchUserSignInHistory))
                    .and_return(userHistoryRequest.promise);
                    
                    [userProfileRequest resolveWithValue:nil];
                });
                it(@"should fetch user sign-in history", ^{
                    dataServiceFake should have_received(@selector(fetchUserSignInHistory));
                });
                
                /*
                 This is 3 levels of nesting in.  Reading this is getting a bit confusing, how do we simplify this?
                 */
                context(@"fetch user sign-in history successful", ^{
                    beforeEach(^{
                        [userHistoryRequest resolveWithValue:nil];
                    });
                    it(@"should say hello to the user", ^{
                        
                    });
                    it(@"should update last signed-in time", ^{
                        
                    });
                });
                
                context(@"fetch user sign-in history failed", ^{
                    beforeEach(^{
                        [userHistoryRequest rejectWithError:nil];
                    });
                    it(@"should show a failed to sign-in error dialog", ^{
                        UIAlertController *alert = (id)subject.presentedViewController;
                        alert.message should equal(@"user error happened");
                    });
                });
            });
            
            context(@"fetch user profile failed", ^{
                beforeEach(^{
                    [userProfileRequest rejectWithError:nil];
                });
                it(@"should show a failed to sign-in error dialog", ^{
                    UIAlertController *alert = (id)subject.presentedViewController;
                    alert.message should equal(@"user error happened");
                });
            });
        });
        
        context(@"failed", ^{
            beforeEach(^{
                [authRequest rejectWithError:nil];
            });
            it(@"should show an authentication failure error dialog", ^{
                // subject.presentedViewController should be_instance_of(UIAlertController.class);
                // again, this is implicitly tested by a outcome focused assertion
                UIAlertController *alert = (id)subject.presentedViewController;
                alert.message should equal(@"auth error happened");
            });
        });
    });
});

SPEC_END
