//
//  MessageTopicsViewController.m
//  duoduo
//
//  Created by tenyea on 14-4-22.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "MessageTopicsViewController.h"

@interface MessageTopicsViewController ()

@end

@implementation MessageTopicsViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(id) initWithTopicsId:(NSString *)topicsId template :(int )Template{
    self = [super init];
    if (self) {
        self.topicsId = topicsId;
        self.Template = Template;
    }
    return self;
}
@end
