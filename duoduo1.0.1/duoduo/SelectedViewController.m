//
//  SelectedViewController.m
//  duoduo
//
//  Created by tenyea on 14-4-28.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "SelectedViewController.h"

@interface SelectedViewController ()

@end

@implementation SelectedViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"已选课程";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
