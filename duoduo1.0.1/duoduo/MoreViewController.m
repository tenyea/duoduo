//
//  MoreViewController.m
//  duoduo
//
//  Created by tenyea on 14-4-28.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "MoreViewController.h"
#import "AboutViewController.h"
#import "DataCenter.h"
#define itunesappid 802739994
#define INFO_ISNEWVersion @"当前版本为最新版本!"

@interface MoreViewController ()

@end
#define tablecellHeigh 50
@implementation MoreViewController
{
    NSArray *detailTextLabel;
    NSArray *textLabel;
    UIImageView *igv;
    BOOL b;
    UIAlertView *_alert;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title=@"设置";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    b=YES;
    // Do any additional setup after loading the view from its nib.
    detailTextLabel=[[NSArray alloc]init];
    detailTextLabel=@[@"不启动客户端仍然自动通知",@"清理朵朵圈储存空间",@"购买课程流程等",@"朵朵圈介绍",@"朵朵圈5.0" ];
    textLabel=@[@"即时接收",@"清除缓存",@"帮助",@"关于",@"检查更新"];
    UIView *view = [[UIView alloc]init];
    view.frame=CGRectMake(0, 0, 320, 64);
    view.backgroundColor=[UIColor colorWithRed:0.71f green:0.71f blue:0.71f alpha:1.00f];
    UILabel *label = [[UILabel alloc]init];
    label.frame=CGRectMake(120, 27, 80, 30);
    label.textColor=[UIColor whiteColor];
    label.text=@"设置";
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
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, 320, 368) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    self.view.backgroundColor=[UIColor colorWithRed:1.00f green:0.99f blue:0.98f alpha:1.00f];
    tableView.scrollEnabled=NO;
    // 取消tableview的row的横线
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
}
-(void)btcClick
{
[self dismissViewControllerAnimated:YES completion:^{
    
}];

}
// 设置一个表单中有多少分组(非正式协议如果不实现该方法则默认只有一个分组)
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

// 设置一个分组中有多少行(必须实现的正式协议)
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0)
    {
        return 1;
    }
    else if(section==1)
    {
        return 1;
    }else
    {
        return 3;
    }
}

// 设置分组的头标高度(默认为20px)
- (float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor=[UIColor colorWithRed:1.00f green:0.99f blue:0.98f alpha:1.00f];
    UILabel *label = [[UILabel alloc]init];
    label.frame=CGRectMake(20, 5, 300, 30);
    label.font=[UIFont boldSystemFontOfSize:13];
    
    label.textColor=[UIColor orangeColor];
    [view addSubview:label];
    if (section==0) {
       label.text=@"新课程提醒";
    }else if(section==1)
    {
        label.text=@"清除缓存";
    }else
    {
        label.text=@"通用设置";
    }
    
    return view;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"cell";
    // 声明cell并去复用池中找是否有对应标签的闲置cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    // 如果没找到可复用的cell
    if(cell == nil)
    {
        // 实例化新的cell并且加上标签
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellName] ;
          if(indexPath.section==0)
            {
                
                cell.textLabel.text=[textLabel objectAtIndex:indexPath.row];
                cell.textLabel.font=[UIFont boldSystemFontOfSize:14];
                cell.textLabel.textColor=[UIColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:1.00f];
                cell.detailTextLabel.text=[detailTextLabel objectAtIndex:indexPath.row];
                cell.detailTextLabel.font=[UIFont boldSystemFontOfSize:11];
                cell.detailTextLabel.textColor=[UIColor colorWithRed:0.67f green:0.67f blue:0.67f alpha:1.00f];;
                igv=[[UIImageView alloc]init];
                igv.frame=CGRectMake(280, 15, 20, 20);
                if (b) {
                    igv.image=[UIImage imageNamed:@"set.png"];
                }else
                {
                igv.image=[UIImage imageNamed:@"set_select.png"];
                }
                [cell addSubview:igv];
            }else if(indexPath.section==1)
            {
                cell.textLabel.text=[textLabel objectAtIndex:indexPath.row+1];
                cell.textLabel.font=[UIFont boldSystemFontOfSize:14];
                cell.textLabel.textColor=[UIColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:1.00f];
                NSUInteger cacheSize = [[DataCenter sharedCenter] cacheSize];
                if (cacheSize < 1024)
                {
                    cell.detailTextLabel.text = [NSString stringWithFormat: @"%u B", cacheSize];
                }
                else if (cacheSize < 1024 * 1024)
                {
                    cell.detailTextLabel.text = [NSString stringWithFormat: @"%.2f KB", (cacheSize * 1.0f) / 1024];
                }
                else if (cacheSize < 1024 * 1024 * 1024)
                {
                    cell.detailTextLabel.text = [NSString stringWithFormat: @"%.2f MB", (cacheSize * 1.0f) / (1024 * 1024)];
                }
                else
                {
                   cell.detailTextLabel.text = [NSString stringWithFormat: @"%.2f GB", (cacheSize * 1.0f) / (1024 * 1024 * 1024)];
                }

             //   cell.detailTextLabel.text=[detailTextLabel objectAtIndex:indexPath.row+1];
                cell.detailTextLabel.font=[UIFont boldSystemFontOfSize:11];
                cell.detailTextLabel.textColor=[UIColor colorWithRed:0.67f green:0.67f blue:0.67f alpha:1.00f];;
            }else
            {
                
                
                cell.textLabel.text=[textLabel objectAtIndex:indexPath.row+2];
                cell.textLabel.font=[UIFont boldSystemFontOfSize:14];
                cell.textLabel.textColor=[UIColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:1.00f];
                cell.detailTextLabel.text=[detailTextLabel objectAtIndex:indexPath.row+2];
                cell.detailTextLabel.font=[UIFont boldSystemFontOfSize:11];
                cell.detailTextLabel.textColor=[UIColor colorWithRed:0.67f green:0.67f blue:0.67f alpha:1.00f];
                if (indexPath.row==0||indexPath.row==1) {
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                }
            }
            
        


    }
   
    
    
    // 设置cell被选中样式
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    //}
    // 显示
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//推送设置
    if(indexPath.section==0)
    {
        if (b) {
            igv.image=[UIImage imageNamed:@"set_select.png"];
            b=!b;
        }else
        {
            igv.image=[UIImage imageNamed:@"set.png"];
            b=!b;
        }
        
    }
//清空缓存
    if(indexPath.section==1)
    {
        [[DataCenter sharedCenter] cleanCache];
        [tableView reloadRowsAtIndexPaths: [NSArray arrayWithObject: indexPath] withRowAnimation: UITableViewRowAnimationAutomatic];
        
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.detailTextLabel.text = @"0 B";
        _pn( [[DataCenter sharedCenter] cacheSize]);
    }
    if (indexPath.section==2&&indexPath.row==1) {
        [self presentViewController:[[AboutViewController alloc]init] animated:YES completion:^{
            
        }];
    }
//检查更新
    if (indexPath.section==2&&indexPath.row==2) {
        //弹出提示
        
        if (_alert ==nil) {
            _alert = [[UIAlertView alloc]initWithTitle:@"正在检查更新"
                                               message:nil
                                              delegate:nil
                                     cancelButtonTitle:nil
                                     otherButtonTitles:nil];
            _alert.tag = 100;
            if (WXHLOSVersion()<7.0) {
                UIActivityIndicatorView *activeView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
                activeView.center = CGPointMake(_alert.bounds.size.width/2.0f, _alert.bounds.size.height-40.0f);
                [activeView startAnimating];
                [_alert addSubview:activeView];
                
            }
        }
        [_alert show];
        //            访问网络
        NSString *str = [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%d",itunesappid];
        [self getDate:[NSURL URLWithString:str] andParams:nil andcachePolicy:1 success:^(AFHTTPRequestOperation *operation, id responseObject) {
            BOOL  isnew = NO;
            //                取消提示框
            [_alert dismissWithClickedButtonIndex:0 animated:YES];
            if (operation.response.statusCode == 200)
            {
                NSDictionary *infoDict   = [[NSBundle mainBundle]infoDictionary];
                NSString *currentVersion = [infoDict objectForKey:@"CFBundleVersion"];
                NSDictionary *jsonData   = [NSJSONSerialization JSONObjectWithData:operation.responseData  options:NSJSONReadingMutableContainers error:nil];
                NSArray      *infoArray  = [jsonData objectForKey:@"results"];
                
                if (infoArray.count >= 1)
                {
                    NSDictionary *releaseInfo   = [infoArray objectAtIndex:0];
                    NSString     *latestVersion = [releaseInfo objectForKey:@"version"];
                    NSString     *releaseNotes  = [releaseInfo objectForKey:@"releaseNotes"];
                    NSString     *title         = [NSString stringWithFormat:@"%@%@版本", @"朵朵童世界", latestVersion];
                    self.updateURL = [releaseInfo objectForKey:@"trackViewUrl"];
                    if ([latestVersion compare:currentVersion] == NSOrderedDescending){
                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:releaseNotes delegate:self cancelButtonTitle:@"忽略" otherButtonTitles:@"去App Store下载", nil];
                        [alertView show];
                        
                    }else
                    {
                        isnew = YES;
                    }
                    
                }else
                {
                    isnew = YES;
                }
                
            }else
            {
                isnew = YES;
            }
            
            if (isnew) {
                alertContent(INFO_ISNEWVersion);
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error %@",error);
        }];
    }
   
}

// 设置行高(默认为44px)
- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return tablecellHeigh;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
