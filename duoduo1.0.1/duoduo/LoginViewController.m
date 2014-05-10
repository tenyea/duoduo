//
//  LoginViewController.m
//  duoduo
//
//  Created by pc on 14-4-17.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisteredViewController.h"
#define parametersLost @"请输入完整信息"
#define wrongInformation @"用户名或密码错误"
@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize btnForget;
@synthesize btnLogin;
@synthesize btnRegistered;
@synthesize loginView;
@synthesize txtUser;
@synthesize passwordTF,userNameTF;
@synthesize loginBackgroundView;
@synthesize loginViewLine;
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
  //  [txtUser becomeFirstResponder];
   NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
   NSString *username = [userDefaultes objectForKey:@"userName"];
    if(username!=nil)
    {
    userNameTF.text = [NSString stringWithFormat:@"%@",username];
    }
    
}
-(void)awakeFromNib{
    [super awakeFromNib];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
// 登录框
    loginView.layer.cornerRadius = 5;
    loginView.layer.borderWidth=1;
    loginView.layer.borderColor=[[UIColor colorWithRed:0.78f green:0.78f blue:0.80f alpha:1.00f] CGColor];
    
    btnLogin.layer.cornerRadius=5;
    btnRegistered.layer.cornerRadius=5;
     self.navigationItem.title=@"登录";

    passwordTF.delegate=self;
    userNameTF.delegate=self;
    userNameTF.clearButtonMode=UITextFieldViewModeWhileEditing;
    passwordTF.clearButtonMode=UITextFieldViewModeWhileEditing;
    passwordTF.secureTextEntry=YES;
    
// 订阅一个通知(订阅键盘弹起和落下的通知)
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow) name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide) name:UIKeyboardWillHideNotification object:nil];
//
//    
}

// 键盘下一步，返回事件
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField.tag==123)
    {
   
    [userNameTF resignFirstResponder];
    [passwordTF becomeFirstResponder];
       
    return YES;
  
    }else if(textField.tag==124)
    {
    [userNameTF resignFirstResponder];
    [passwordTF resignFirstResponder];
        [UIView animateWithDuration:0.1 animations:^{
            loginBackgroundView.frame = CGRectMake(0,0,320,416);
        } completion:^(BOOL finished) {
            
        }];
    return YES;
    }else
    {
        return NO;
    }
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnForget:(id)sender {
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    loginBackgroundView.frame = CGRectMake(0,-40,320,416);

    return YES;
}

// 登录按钮 点击事件
- (IBAction)btnLogin:(id)sender {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:userNameTF.text forKey:@"username"];
    [dic setValue:passwordTF.text forKey:@"password"];
    [self getDate:URL_Login andParams:dic andcachePolicy:1 success:^(AFHTTPRequestOperation *operation, id responseObject) {
         NSString *code =[responseObject objectForKey:@"code"];
         NSLog(@"%@",code);
        NSString *loginMessage;
        int a = [code intValue];
        if(a==0)
        {
            [self showResult:responseObject];
            NSLog(@"登录成功");
        }else if(a==1001)
        {
            loginMessage = parametersLost;
            [self showHUDinView:loginMessage];
            NSLog(@"请输入完整信息");
            NSTimer *connectionTimer;  //timer对象
            connectionTimer=[NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(timerFiredFailure:) userInfo:nil repeats:NO];
        }else if (a==1002)
        {
            loginMessage=wrongInformation;
             [self showHUDinView:loginMessage];
            NSLog(@"用户名或密码错误");
            NSTimer *connectionTimer;  //timer对象
            connectionTimer=[NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(timerFiredFailure:) userInfo:nil repeats:NO];
        }
            
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          NSLog(@"Error: %@", error);
    }];
    [userNameTF resignFirstResponder];
    [passwordTF resignFirstResponder];
   
}
// 登录失败取消HUD
-(void)timerFiredFailure:(NSTimer *)timer{
    [hudLabel removeFromSuperview];
    hudLabel = nil;
}

-(void)showHUDinView:(NSString *)title{
    if (!hudLabel) {
        hudLabel = [[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth - 120)/2, (ScreenHeight - 100)/2 -100, 120, 20)];
        hudLabel.backgroundColor = [UIColor grayColor];
        hudLabel.textAlignment = NSTextAlignmentCenter;
        hudLabel.textColor = [UIColor whiteColor];
        hudLabel.font = [UIFont boldSystemFontOfSize:14];
        hudLabel.hidden = YES;
        [self.view addSubview:hudLabel];
    }
    hudLabel.text = title;
    hudLabel.hidden = NO;
}


// 解析数据存储在 NSUserDefaults
-(void)showResult:(NSDictionary *)resultobject
{
    //解析数据
    NSDictionary *result =[resultobject objectForKey:@"user"];
    NSString *coin = [result objectForKey:kuserDIC_coin];
    NSString *collectCourseId =[result objectForKey:kuserDIC_collectCourseId];
    NSString *collectCourseTotal = [result objectForKey:kuserDIC_collectCourseTotal];
    NSString *head = [result objectForKey:kuserDIC_head];
    NSString *memberTypeId = [result objectForKey:kuserDIC_memberTypeId];
    NSString *scores = [result objectForKey:kuserDIC_scores];
    NSString *selectCourseId = [result objectForKey:kuserDIC_selectCourseId];
    NSString *selectCourseTotal = [result objectForKey:kuserDIC_selectCourseTotal];
    NSString *userMemberId = [result objectForKey:kuserDIC_userMemberId];
    NSString *userName = [result objectForKey:kuserDIC_userName];
    NSString *signTotal = [result objectForKey:kuserDIC_signTotal];
    
    //存入 NSUserDefaults
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *userDIC= [[NSMutableDictionary alloc]init];
    [userDIC setObject:userMemberId forKey:kuserDIC_userMemberId];
//    [userDIC setObject:passwordTF.text forKey:@"password"];
    [userDIC setObject:userName forKey:kuserDIC_userName];
    [userDIC setObject:scores forKey:kuserDIC_scores];
    [userDIC setObject:head forKey:kuserDIC_head];
    [userDIC setObject:coin forKey:kuserDIC_coin];
    [userDIC setObject:collectCourseId forKey:kuserDIC_collectCourseId];
    [userDIC setObject:selectCourseId forKey:kuserDIC_selectCourseId];
    [userDIC setObject:signTotal forKey:kuserDIC_signTotal];
    [userDIC setObject:memberTypeId forKey:kuserDIC_memberTypeId];
    [userDIC setObject:collectCourseTotal forKey:kuserDIC_collectCourseTotal];
    [userDIC setObject:selectCourseTotal forKey:kuserDIC_selectCourseTotal];
    [userDefaults setObject:userName forKey:kuserDIC_userName];
    [userDefaults setObject:userDIC forKey:kuserDIC];
    [userDefaults synchronize];
}


- (IBAction)btnRegistered:(id)sender {
    RegisteredViewController *registered = [[RegisteredViewController alloc]init];
   [self.navigationController pushViewController:registered animated:YES];

}
@end
