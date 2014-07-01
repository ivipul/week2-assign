//
//  LoginViewController.m
//  week2-assign
//
//  Created by Vipul Thakur on 6/29/14.
//  Copyright (c) 2014 ivipul. All rights reserved.
//

#import "LoginViewController.h"
#import "NewsViewController.h"
#import "RequestsViewController.h"
#import "MessagesViewController.h"
#import "NotificationViewController.h"
#import "MenuViewController.h"

@interface LoginViewController ()
- (IBAction)onTapEmailTextField:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *logo;
@property (weak, nonatomic) IBOutlet UIView *viewTextinputs;
@property (weak, nonatomic) IBOutlet UIView *viewTopElements;
@property (weak, nonatomic) IBOutlet UILabel *signupLink;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loginActivityLoader;

@property (assign) int topElementsInitialHeight;
- (IBAction)onEmailChange:(id)sender;
- (IBAction)onPasswordChange:(id)sender;
- (IBAction)onTapLoginButton:(id)sender;

- (void)willShowKeyboard:(NSNotification *)notification;
- (void)willHideKeyboard:(NSNotification *)notification;
- (void)checkPassword;

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willShowKeyboard:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willHideKeyboard:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.passwordField.secureTextEntry = YES;
    self.passwordField.autocorrectionType = NO;
    [self.loginButton setEnabled:NO];
    self.loginButton.alpha = 0.6;
    self.loginActivityLoader.hidden = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    NewsViewController *newsViewController = [[NewsViewController alloc] init];
    UINavigationController *firstNavigationController = [[UINavigationController alloc] initWithRootViewController:newsViewController];
    firstNavigationController.tabBarItem.title = @"News Feed";
    firstNavigationController.tabBarItem.image = [UIImage imageNamed:@"feed"];
    
    RequestsViewController *requestsViewController = [[RequestsViewController alloc] init];
    UINavigationController *secondNavigationController = [[UINavigationController alloc] initWithRootViewController:requestsViewController];
    secondNavigationController.tabBarItem.title = @"Requests";
    secondNavigationController.tabBarItem.image = [UIImage imageNamed:@"requests"];
    
    MessagesViewController *messagesViewController = [[MessagesViewController alloc] init];
    UINavigationController *thirdNavigationController = [[UINavigationController alloc] initWithRootViewController:messagesViewController];
    thirdNavigationController.tabBarItem.title = @"Messages";
    thirdNavigationController.tabBarItem.image = [UIImage imageNamed:@"messages"];
    
    NotificationViewController *notificationViewController = [[NotificationViewController alloc] init];
    UINavigationController *fourthNavigationController = [[UINavigationController alloc] initWithRootViewController:notificationViewController];
    fourthNavigationController.tabBarItem.title = @"Notifications";
    fourthNavigationController.tabBarItem.image = [UIImage imageNamed:@"notif"];
    
    MenuViewController *menuViewController = [[MenuViewController alloc] init];
    UINavigationController *fifthNavigationController = [[UINavigationController alloc] initWithRootViewController:menuViewController];
    fifthNavigationController.tabBarItem.title = @"Menu";
    fifthNavigationController.tabBarItem.image = [UIImage imageNamed:@"menu"];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = @[firstNavigationController, secondNavigationController, thirdNavigationController, fourthNavigationController, fifthNavigationController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTapEmailTextField:(id)sender {
    
}

- (IBAction)onEmailChange:(id)sender {
    if((![self.emailField.text  isEqual: @""] && ![self.passwordField.text  isEqual: @""])){
        [self.loginButton setEnabled:YES];
        self.loginButton.alpha = 1;
    }
    else{
        [self.loginButton setEnabled:NO];
        self.loginButton.selected = NO;
        self.loginButton.alpha = 0.6;
        self.loginActivityLoader.hidden = YES;
    }

}

- (IBAction)onPasswordChange:(id)sender {
    if((![self.emailField.text  isEqual: @""] && ![self.passwordField.text  isEqual: @""])){
        [self.loginButton setEnabled:YES];
        self.loginButton.alpha = 1;
    }
    else{
        [self.loginButton setEnabled:NO];
        self.loginButton.selected = NO;
        self.loginButton.alpha = 0.6;
        self.loginActivityLoader.hidden = YES;
    }
}


- (IBAction)onTapLoginButton:(id)sender {
    self.loginButton.selected = YES;
    self.loginActivityLoader.hidden = NO;
    [self.loginActivityLoader startAnimating];

    [self performSelector:@selector(checkPassword) withObject:nil afterDelay:2];

}

- (void)willShowKeyboard:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    CGSize kbSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    // Get the animation duration and curve from the notification
    NSNumber *durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration = durationValue.doubleValue;
    NSNumber *curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey];
    UIViewAnimationCurve animationCurve = curveValue.intValue;
    
    // Move the view with the same duration and animation curve so that it will match with the keyboard animation
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:(animationCurve << 16)
                     animations:^{
                         self.topElementsInitialHeight = self.viewTopElements.frame.origin.y;

                         self.viewTopElements.frame = CGRectMake(0, self.viewTopElements.frame.origin.y - 100, self.viewTopElements.frame.size.width, self.viewTopElements.frame.size.height);
                         NSLog(@"Height: %f", self.signupLink.frame.origin.y);
                         self.signupLink.frame = CGRectMake(0, self.view.frame.size.height - kbSize.height - self.signupLink.frame.size.height -10, self.signupLink.frame.size.width, self.signupLink.frame.size.height);
                     }
                     completion:nil];
}

- (void)willHideKeyboard:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    
    // Get the animation duration and curve from the notification
    NSNumber *durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration = durationValue.doubleValue;
    NSNumber *curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey];
    UIViewAnimationCurve animationCurve = curveValue.intValue;
    
    // Move the view with the same duration and animation curve so that it will match with the keyboard animation
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:(animationCurve << 16)
                     animations:^{
                         self.viewTopElements.frame = CGRectMake(0, self.topElementsInitialHeight, self.viewTopElements.frame.size.width, self.viewTopElements.frame.size.height);
                         self.signupLink.frame = CGRectMake(0, 466, self.signupLink.frame.size.width, self.signupLink.frame.size.height);
                     }
                     completion:nil];

}

-(void)dismissKeyboard {
    [self.emailField resignFirstResponder];
    [self.passwordField resignFirstResponder];
}

- (void)checkPassword {
    if ([self.passwordField.text  isEqual: @"password"]){
        NSLog(@"Loggin in");
        
        NewsViewController *newsViewController = [[NewsViewController alloc] init];
        UINavigationController *firstNavigationController = [[UINavigationController alloc] initWithRootViewController:newsViewController];
        firstNavigationController.tabBarItem.title = @"News Feed";
        firstNavigationController.tabBarItem.image = [UIImage imageNamed:@"feed"];
        
        RequestsViewController *requestsViewController = [[RequestsViewController alloc] init];
        UINavigationController *secondNavigationController = [[UINavigationController alloc] initWithRootViewController:requestsViewController];
        secondNavigationController.tabBarItem.title = @"Requests";
        secondNavigationController.tabBarItem.image = [UIImage imageNamed:@"requests"];
        
        MessagesViewController *messagesViewController = [[MessagesViewController alloc] init];
        UINavigationController *thirdNavigationController = [[UINavigationController alloc] initWithRootViewController:messagesViewController];
        thirdNavigationController.tabBarItem.title = @"Messages";
        thirdNavigationController.tabBarItem.image = [UIImage imageNamed:@"messages"];
        
        NotificationViewController *notificationViewController = [[NotificationViewController alloc] init];
        UINavigationController *fourthNavigationController = [[UINavigationController alloc] initWithRootViewController:notificationViewController];
        fourthNavigationController.tabBarItem.title = @"Notifications";
        fourthNavigationController.tabBarItem.image = [UIImage imageNamed:@"notif"];
        
        MenuViewController *menuViewController = [[MenuViewController alloc] init];
        UINavigationController *fifthNavigationController = [[UINavigationController alloc] initWithRootViewController:menuViewController];
        fifthNavigationController.tabBarItem.title = @"Menu";
        fifthNavigationController.tabBarItem.image = [UIImage imageNamed:@"menu"];
        
        UITabBarController *tabBarController = [[UITabBarController alloc] init];
        tabBarController.viewControllers = @[firstNavigationController, secondNavigationController, thirdNavigationController, fourthNavigationController, fifthNavigationController];
        
        tabBarController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        
        [self presentViewController:tabBarController animated:YES completion:nil];
    
        
    }
    else{
        NSLog(@"Wrong password");
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Login Failed" message:@"The username or password was wrong." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
        [self.loginButton setEnabled:NO];
        self.loginButton.selected = NO;
        self.loginButton.alpha = 0.6;
        self.loginActivityLoader.hidden = YES;
    }
}

@end
