//
//  TenyeaNoneNaviVC.m
//  duoduo
//
//  Created by tenyea on 14-5-9.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "TenyeaNoneNaviVC.h"

@interface TenyeaNoneNaviVC ()

@end

@implementation TenyeaNoneNaviVC

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
	// Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}
-(void)viewWillDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO];
    [super viewWillDisappear:animated];
}
@end
