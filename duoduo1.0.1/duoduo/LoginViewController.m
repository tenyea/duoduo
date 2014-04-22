//
//  LoginViewController.m
//  duoduo
//
//  Created by pc on 14-4-17.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisteredViewController.h"

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
    loginView.layer.cornerRadius = 10;
    loginView.layer.borderWidth=1;
    loginView.layer.borderColor=[[UIColor grayColor] CGColor];
    btnLogin.layer.cornerRadius=5;
    btnRegistered.layer.cornerRadius=5;
     self.navigationItem.title=@"登录";
// 导航条 返回按钮图片
    UIBarButtonItem *editBBI = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"shake_exit1.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(bbiClick)];
    editBBI.tintColor=[UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = editBBI;
    
    passwordTF.delegate=self;
    userNameTF.delegate=self;
    passwordTF.secureTextEntry=YES;
    
// 订阅一个通知(订阅键盘弹起和落下的通知)
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide) name:UIKeyboardWillHideNotification object:nil];

    
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
// 键盘通知
- (void)keyboardWillShow
{
        loginBackgroundView.frame = CGRectMake(0,-40,320,416);
}
- (void)keyboardWillHide
{
    [UIView animateWithDuration:0.1 animations:^{
        loginBackgroundView.frame = CGRectMake(0,0,320,416);
    } completion:^(BOOL finished) {
        
    }];
}
// 导航条 返回按钮
-(void)bbiClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnForget:(id)sender {
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
            loginMessage = @"请输入完整信息";
            [self showHUDwithLabel:loginMessage];
            NSLog(@"请输入完整信息");
            NSTimer *connectionTimer;  //timer对象
            connectionTimer=[NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(timerFiredFailure:) userInfo:nil repeats:NO];
        }else if (a==1002)
        {
            loginMessage=@"用户名或密码错误";
             [self showHUDwithLabel:loginMessage];
            NSLog(@"用户名或密码错误");
            NSTimer *connectionTimer;  //timer对象
            connectionTimer=[NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(timerFiredFailure:) userInfo:nil repeats:NO];
        }
            
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          NSLog(@"Error: %@", error);
    }];
   
}
// 解析数据存储在 NSUserDefaults
-(void)showResult:(NSDictionary *)resultobject
{
    //解析数据
    NSDictionary *result =[resultobject objectForKey:@"user"];
    NSString *userMemberId = [result objectForKey:String_userMemberId];
    NSString *userName = [result objectForKey:String_userName];
    NSString *scores = [result objectForKey:String_scores];
    NSString *head = [result objectForKey:String_head];
    NSString *coin = [result objectForKey:String_coin];
    NSString *collectCourseId =[result objectForKey:String_collectCourseId];
    NSString *selectCourseId = [result objectForKey:String_selectCourseId];
    NSString *signTotal = [result objectForKey:String_signTotal];
    NSString *memberTypeId = [result objectForKey:String_memberTypeId];
    NSLog(@"userMemberId = %@",userMemberId);
    NSLog(@"userName = %@",userName);
    NSLog(@"scores = %@",scores);
    NSLog(@"head = %@",head);
    NSLog(@"coin = %@",coin);
    NSLog(@"collectCourseId = %@",collectCourseId);
    NSLog(@"selectCourseId = %@",selectCourseId);
    NSLog(@"signTotal = %@",signTotal);
    NSLog(@"memberTypeId = %@",memberTypeId);
    
    //存入 NSUserDefaults
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *userDIC= [[NSMutableDictionary alloc]init];
    [userDIC setObject:userMemberId forKey:String_userMemberId];
    [userDIC setObject:passwordTF.text forKey:@"password"];
    [userDIC setObject:userName forKey:String_userName];
    [userDIC setObject:scores forKey:String_scores];
    [userDIC setObject:head forKey:String_head];
    [userDIC setObject:coin forKey:String_coin];
    [userDIC setObject:collectCourseId forKey:String_collectCourseId];
    [userDIC setObject:selectCourseId forKey:String_selectCourseId];
    [userDIC setObject:signTotal forKey:String_signTotal];
    [userDIC setObject:memberTypeId forKey:String_memberTypeId];
    [userDefaults setObject:userName forKey:String_userName];
    [userDefaults setObject:userDIC forKey:kuserDIC];
    [userDefaults synchronize];
}

// 登录失败取消HUD
-(void)timerFiredFailure:(NSTimer *)timer{
    
    [self removeHUD];
}

// 注册按钮点击事件
- (IBAction)btnRegistered:(id)sender {
    RegisteredViewController *registered = [[RegisteredViewController alloc]initWithNibName:@"RegisteredViewController" bundle:nil];
    [self.navigationController pushViewController:registered animated:YES];
}
@end
