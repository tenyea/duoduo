//
//  LoginViewController.m
//  duoduo
//
//  Created by pc on 14-4-17.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize btnForget;
@synthesize btnLogin;
@synthesize btnRegistered;
@synthesize loginView;
@synthesize txtUser;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
       
        [[UINavigationBar appearance] setBarTintColor:[UIColor orangeColor]];

    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    [txtUser becomeFirstResponder];
    
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    loginView.layer.cornerRadius = 10;
    loginView.layer.borderWidth=1;
    loginView.layer.borderColor=[[UIColor grayColor] CGColor];
    btnLogin.layer.cornerRadius=5;
    btnRegistered.layer.cornerRadius=5;
     self.navigationItem.title=@"登录";
    UIBarButtonItem *editBBI = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(bbiClick)];
    self.navigationItem.leftBarButtonItem = editBBI;

}
-(void)bbiClick
{
    [self dismissViewControllerAnimated:YES completion:^{
    }];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnForget:(id)sender {
}

- (IBAction)btnLogin:(id)sender {
}

- (IBAction)btnRegistered:(id)sender {
    RegisteredViewController *registered = [[RegisteredViewController alloc]init];
   [self.navigationController pushViewController:registered animated:YES];
    
}
@end
