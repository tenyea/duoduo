//
//  AboutViewController.m
//  duoduo
//
//  Created by tenyea on 14-5-5.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "AboutViewController.h"
#import "DataCenter.h"
@interface AboutViewController ()

@end

@implementation AboutViewController

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
    UIView *view = [[UIView alloc]init];
    view.frame=CGRectMake(0, 0, 320, 64);
    view.backgroundColor=[UIColor colorWithRed:0.71f green:0.71f blue:0.71f alpha:1.00f];
    UILabel *label = [[UILabel alloc]init];
    label.frame=CGRectMake(120, 27, 80, 30);
    label.textColor=[UIColor whiteColor];
    label.text=@"关于";
    label.textAlignment=NSTextAlignmentCenter;
    [view addSubview:label];
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(265, 32, 40, 20);
    [backBtn setTitle:@"关闭" forState:UIControlStateNormal];
    backBtn.titleLabel.font = [UIFont systemFontOfSize: 14.0];
    backBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
    backBtn.titleLabel.textColor=[UIColor colorWithRed:0.67f green:0.67f blue:0.67f alpha:1.00f];
    
    backBtn.layer.cornerRadius=4;
    backBtn.backgroundColor=[UIColor colorWithRed:0.83f green:0.83f blue:0.83f alpha:1.00f];
    [backBtn addTarget:self action:@selector(btcClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:backBtn];
    [self.view addSubview:view];

    NSString *aboutPath = [[NSBundle mainBundle] pathForResource: @"about" ofType: @"html"];
    NSError *error = nil;
    NSStringEncoding encoding;
    NSString *htmlString = [NSString stringWithContentsOfFile: aboutPath usedEncoding: &encoding error: &error];
    //    添加版本号
    NSArray *array = [htmlString componentsSeparatedByString:@"</BODY>"];
    NSString *curversion = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
    NSString *centerString = [NSString stringWithFormat:@"<center>Version %@</center>",curversion];
    NSString *newhtmlString = [array componentsJoinedByString:centerString];
     NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    webView.dataDetectorTypes = UIDataDetectorTypeNone;
   
    [webView loadHTMLString: newhtmlString baseURL: baseURL];

}
-(void)btcClick
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
