//
//  LoginView.m
//  duoduo
//
//  Created by tenyea on 14-5-4.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "LoginView.h"
#import "RegisteredViewController.h"
#define parametersLost @"请输入完整信息"
#define wrongInformation @"用户名或密码错误"
#define loginSuccess_Info @"登陆成功"
#import "AFNetworking.h"
@implementation LoginView
@synthesize btnForget;
@synthesize btnLogin;
@synthesize btnRegistered;
@synthesize loginView;
@synthesize passwordTF,userNameTF;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initView];
    }
    return self;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    [self _initView];
}
-(void)_initView{
    // 登录框
    loginView.layer.cornerRadius = 10;
    loginView.layer.borderWidth=1;
    loginView.layer.borderColor=[[UIColor grayColor] CGColor];
    btnLogin.layer.cornerRadius=5;
    btnRegistered.layer.cornerRadius=5;
    self.viewController.navigationItem.title=@"登录";
    
    passwordTF.delegate=self;
    userNameTF.delegate=self;
    userNameTF.clearsOnBeginEditing = YES;
    userNameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordTF.clearsOnBeginEditing = YES;
    passwordTF.secureTextEntry=YES;
    
    // 订阅一个通知(订阅键盘弹起和落下的通知)
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide) name:UIKeyboardWillHideNotification object:nil];
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    NSString *username = [userDefaultes objectForKey:@"userName"];
    if(username!=nil)
    {
        userNameTF.text = [NSString stringWithFormat:@"%@",username];
    }
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
// 键盘通知
- (void)keyboardWillShow
{
    self.frame = CGRectMake(0,-40,320,416);
}
- (void)keyboardWillHide
{
    [UIView animateWithDuration:0.1 animations:^{
        self.frame = CGRectMake(0,0,320,416);
    } completion:^(BOOL finished) {
        
    }];
}

- (IBAction)btnForget:(id)sender {
}
// 登录按钮 点击事件
- (IBAction)btnLogin:(id)sender {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:userNameTF.text forKey:@"username"];
    [dic setValue:passwordTF.text forKey:@"password"];
    
    
    
    NSString *baseurl = [BASE_URL stringByAppendingPathComponent:URL_Login];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [manager GET:baseurl parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *code =[responseObject objectForKey:@"code"];
        NSLog(@"%@",code);
        NSString *loginMessage;
        int a = [code intValue];
        if(a==0)
        {
            NSLog(@"登录成功");
            if ([self.loginDelegate respondsToSelector:@selector(loginSuccess:)]) {
                loginMessage = loginSuccess_Info;
                [self showHUDinView:loginMessage];
                [self.loginDelegate loginSuccess:[self showResult:responseObject]];
                [self performSelector:@selector(timerFiredFailure:) withObject:nil afterDelay:1.5];
            }
        }else if(a==1001)
        {
            loginMessage = parametersLost;
            [self showHUDinView:loginMessage];
            NSLog(@"请输入完整信息");
            [self performSelector:@selector(timerFiredFailure:) withObject:nil afterDelay:1.5];
        }else if (a==1002)
        {
            loginMessage=wrongInformation;
            [self showHUDinView:loginMessage];
            NSLog(@"用户名或密码错误");
            [self performSelector:@selector(timerFiredFailure:) withObject:nil afterDelay:1.5];
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}
// 解析数据存储在 NSUserDefaults
-(NSDictionary *)showResult:(NSDictionary *)resultobject
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
    return userDIC;
}

// 登录失败取消HUD

-(void)timerFiredFailure:(NSTimer *)timer{
    [hudLabel removeFromSuperview];
    hudLabel = nil;
}
-(void)showHUDinView:(NSString *)title{
    if (!hudLabel) {
        hudLabel = [[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth - 110)/2, (ScreenHeight - 100)/2 -100, 110, 20)];
        hudLabel.backgroundColor = [UIColor grayColor];
        hudLabel.textAlignment = NSTextAlignmentCenter;
        hudLabel.textColor = [UIColor whiteColor];
        hudLabel.font = [UIFont boldSystemFontOfSize:14];
        hudLabel.hidden = YES;
        [self addSubview:hudLabel];
    }
    hudLabel.text = title;
    hudLabel.hidden = NO;
}
- (IBAction)btnRegistered:(id)sender {
    RegisteredViewController *registered = [[RegisteredViewController alloc]init];
    [self.viewController.navigationController pushViewController:registered animated:YES];
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
