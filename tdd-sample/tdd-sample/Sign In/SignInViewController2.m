//
//  SignInViewController2.m
//  tdd-sample
//

#import <Blindside/Blindside.h>
#import "SignInViewController2.h"
#import "DataService.h"


@interface SignInViewController2 ()
@property (strong, nonatomic) DataService *dataService;
@end

@implementation SignInViewController2

+ (BSPropertySet *)bsProperties {
    return [BSPropertySet propertySetWithClass:self.class
                                 propertyNames:
            NSStringFromSelector(@selector(dataService)),
            nil];
}

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

#pragma mark - Setup

- (void)setupView {
    self.emailTextField.placeholder = @"email";
    self.passwordTextField.placeholder = @"password";
    [self.signInButton setTitle:@"SIGN IN" forState:UIControlStateNormal];
    self.logoImageView.image = [UIImage imageNamed:@"connected_logo"];
}

#pragma mark - Sign-In

- (IBAction)signInButtonTapped:(id)sender {
    KSPromise *authPromise = [[self.dataService authWithEmail:self.emailTextField.text
                                                     password:self.passwordTextField.text] then:nil error:^id _Nullable(NSError * _Nullable error) {
        [self showErrorMessage:@"auth error happened"];
        return error;
    }];
    
    KSPromise *userPromise = [[authPromise then:^id _Nullable(id  _Nullable value) {
        return [self.dataService fetchUserProfile];
    }] then:nil error:^id _Nullable(NSError * _Nullable error) {
        [self showErrorMessage:@"user error happened"];
        return error;
    }];
    
    [[userPromise then:^id _Nullable(id  _Nullable value) {
        return [self.dataService fetchUserSignInHistory];
    }] then:nil error:^id _Nullable(NSError * _Nullable error) {
        [self showErrorMessage:@"user error happened"];
        return error;
    }];
}

- (void)showErrorMessage:(NSString *)message {
    UIAlertController *alert
    = [UIAlertController alertControllerWithTitle:@"oops"
                                          message:message
                                   preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                              style:UIAlertActionStyleDefault
                                            handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
