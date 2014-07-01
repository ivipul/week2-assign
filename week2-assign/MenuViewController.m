//
//  MenuViewController.m
//  week2-assign
//
//  Created by Vipul Thakur on 6/30/14.
//  Copyright (c) 2014 ivipul. All rights reserved.
//

#import "MenuViewController.h"
#import "LoginViewController.h"

@interface MenuViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;
- (IBAction)onLougoutButton:(id)sender;

@end

@implementation MenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:69.0/255.0 green:99.0/255.0 blue:161.0/255.0 alpha:1.0];
    self.navigationController.navigationBar.topItem.title = @"More";
    NSMutableDictionary *navBarTextAttributes = [NSMutableDictionary dictionaryWithCapacity:1];
    [navBarTextAttributes setObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName ];
    self.navigationController.navigationBar.titleTextAttributes = navBarTextAttributes;
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    UIImage *backImage = [UIImage imageNamed:@"search"];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, backImage.size.width, backImage.size.height);
    [backButton setImage:backImage forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(self)    forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton] ;
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.leftBarButtonItem = backBarButtonItem;
    
    UIImage *rightImage = [UIImage imageNamed:@"settings"];
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, rightImage.size.width, rightImage.size.height);
    [rightButton setImage:rightImage forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(self)    forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    self.scrollView.contentSize = CGSizeMake(320, 1800);
    self.logoutButton.frame = CGRectMake(self.logoutButton.frame.origin.x, self.logoutButton.frame.origin.y + 1225, self.logoutButton.frame.size.width, self.logoutButton.frame.size.height);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onLougoutButton:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Are you sure you want to logout?" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Logout" otherButtonTitles:nil, nil];
    [actionSheet showInView:self.view];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == actionSheet.destructiveButtonIndex)
    {
        NSLog(@"ddfgfg");
        LoginViewController *vc = [[LoginViewController alloc] init];
        vc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self presentViewController:vc animated:YES completion:nil];
    }
}
@end
