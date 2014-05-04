//
//  SearchViewController.m
//  duoduo
//
//  Created by tenyea on 14-4-26.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "SearchViewController.h"
#import "CourseModel.h"
#import "NSString+URLEncoding.h"
#import "UIImageView+WebCache.h"
#import "SearchResultCell.h"
#import "CourseViewController.h"
@interface SearchViewController ()

@end

@implementation SearchViewController
#define params_key @"key"
#define params_type @"sort"
#define params_lastId @"lastId"
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    sliderView.left = 5 + 80 *(type>0?type - 1:0);
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    isloading = NO;
    type = 0;
    desc.highlighted = YES;
    asc.highlighted = NO;
    // Do any additional setup after loading the view from its nib.
    [self _initNavigationBar];
    [self loadDatabyType:0 andContent:nil andTableView:nil];
}
-(void)_initNavigationBar {
    //设置textfield
    searchBar = [[TYTextField alloc]initWithFrame:CGRectMake(15, 5, 180, 30) andclass: [self class]];
    searchBar.borderStyle = UITextBorderStyleRoundedRect;
    searchBar.clearsOnBeginEditing = YES;
    searchBar.returnKeyType = UIReturnKeyDone;
    searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    searchBar.leftViewMode = UITextFieldViewModeAlways;
    searchBar.dateDelegate = self;
    self.navigationItem.titleView = searchBar;
}

#pragma mark TYTextFieldDelegate
//加载更多数据
-(void)loadMoreDate:(UITableView *)tableView{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    if (_content != nil) {
        [params setValue:[_content URLEncodedString] forKey:params_key];
    }
    [params setValue:[NSNumber numberWithInt:type] forKey:params_type];
    CourseModel *model = [searchBar.resultArray lastObject];
    [params setValue:model.course_id forKey:params_lastId];
    if (!isloading) {
        isloading = YES;
    }else{
        return;
    }
    [self showHUDinView:nil];
    [self getDate:URL_getCourseList andParams:params andcachePolicy:1 success:^(AFHTTPRequestOperation *operation, id responseObject) {
        int statecode =[[responseObject objectForKey:@"code"] intValue];
        if (statecode == 0 ) {
            NSArray *arr = [responseObject objectForKey:@"course" ];
            NSMutableArray *dataArr = [[NSMutableArray alloc]initWithArray:searchBar.resultArray];
            for (int i = 0 ; i < arr.count ; i++) {
                NSDictionary *dic = arr[i];
                CourseModel *model = [[CourseModel alloc]initWithDataDic:dic];
                [dataArr addObject:model];
            }
            
            searchBar.resultArray = dataArr;
            [searchBar.resultTableView donerefreshData];
            [searchBar.resultTableView reloadData];
        }
        [self removeHUD];
        isloading = NO;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self removeHUD];
        _po([error localizedDescription]);
        isloading = NO;
    }];

}
-(void)selectInSearchTableViewBy:(NSString *)content andTableView:(UITableView *)tableView{
    [self loadDatabyType:type andContent:content andTableView:tableView];
}
-(void)selectInResultTableVIew:(TYTextField *)textField andIndexPath:(NSIndexPath *)indexPath{
    CourseModel *model = textField.resultArray[indexPath.row];
    CourseViewController *VC = [[CourseViewController alloc]initWithCourseID:model.course_id];
    [self.navigationController pushViewController:VC animated:YES];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath andTextfield:(TYTextField *)textField{
    static NSString *resultIdentifier = @"resultIdentifier";
    SearchResultCell *cell = [tableView dequeueReusableCellWithIdentifier:resultIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SearchResultCell" owner:self options:nil] lastObject];
    }
    CourseModel *model = textField.resultArray[indexPath.row];
    [cell.imageView setImageWithURL:[NSURL URLWithString:model.course_images] placeholderImage:[UIImage imageNamed:@"logo_60X50.png"]];
    

    cell.titleLabel.text = model.courseName;
    cell.contentLabel.text = model.Description;
    cell.priceLabel.text = [NSString stringWithFormat:@"￥%@",model.course_price];
    if ([model.course_price intValue]  == [model.course_sell_price intValue]) {
        cell.currentPriceLabel.hidden = YES;
        cell.discountLabel.hidden = YES;
    }else{
        cell.currentPriceLabel.hidden = NO;
        cell.discountLabel.hidden = NO;
        cell.currentPriceLabel.text = [NSString stringWithFormat:@"￥%@",model.course_sell_price];
        cell.discountLabel.text = [NSString stringWithFormat:@"%d折",[model.course_price_discount intValue]];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath andTextfield:(TYTextField *)textField{
    return 70;
}
- (IBAction)orderAction:(UIButton *)sender {
    [UIView animateWithDuration:.2 animations:^{
        sliderView.left = 5+80 *(sender.tag-100);
    }];
    switch (sender.tag) {
        case 100://价格
        {
            if (type >= 2) {
                if (desc.highlighted) {
                    type = 0;
                }else{
                    type = 1;
                }
            }else{
                if (desc.highlighted) {
                    desc.highlighted = NO;
                    asc.highlighted = YES;
                    type = 1;
                    
                }else{
                    asc.highlighted = NO;
                    desc.highlighted = YES;
                    type = 0;
                    
                }
            }
        }
            break;
        case 101:{//人气
            if (type!=2) {
                type = 2;
            }
        }
            break;
        case 102:{//推荐
            if (type != 3) {
                type = 3;
            }
        }
            break;
        case 103:{//相关度
            if (type !=4) {
                type = 4;
            }
        }
            break;
        default:
            break;
    }
    if ([searchBar bgViewIsShow]) {
        [self loadDatabyType:type andContent:_content andTableView:nil];

    }

}

-(void)loadDatabyType:(int)Stype andContent:(NSString *)content andTableView:(UITableView *)tableView{
    if (![content isEqualToString:_content]) {
        _content = content;
    }
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    if (_content != nil) {
        [params setValue:[_content URLEncodedString] forKey:params_key];
    }
    [params setValue:[NSNumber numberWithInt:Stype] forKey:params_type];
    if (!isloading) {
        isloading = YES;
    }else{
        return;
    }
    [self showHUDinView:nil];
    [self getDate:URL_getCourseList andParams:params andcachePolicy:1 success:^(AFHTTPRequestOperation *operation, id responseObject) {
        int statecode =[[responseObject objectForKey:@"code"] intValue];
        if (statecode == 0 ) {
            NSArray *arr = [responseObject objectForKey:@"course" ];
            NSMutableArray *dataArr = [[NSMutableArray alloc]init];
            for (int i = 0 ; i < arr.count ; i++) {
                NSDictionary *dic = arr[i];
                CourseModel *model = [[CourseModel alloc]initWithDataDic:dic];
                [dataArr addObject:model];
            }
            
            searchBar.resultArray = dataArr;
            [searchBar.resultTableView reloadData];
        }
        [self removeHUD];
        isloading = NO;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self removeHUD];
        _po([error localizedDescription]);
        isloading = NO;
        
    }];

}
@end
