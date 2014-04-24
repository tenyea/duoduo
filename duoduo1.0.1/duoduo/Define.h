//
//  Define.h
//  duoduo
//
//  Created by tenyea on 14-3-25.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#ifndef duoduo_Define_h
#define duoduo_Define_h

#pragma mark -
#pragma mark URL
#define Host @"www.baidu.com"
#define BASE_URL @"http://192.168.1.145:8090/duoduo/"
//#define BASE_URL @"http://app.nen.com.cn/"

#pragma mark Servlet
//首页home数据
#define URL_home_main @"homeServlet"
//获取课程列表
#define URL_getCourseList @"shake"
// 登录
#define URL_Login @"LoginServlet"
// 注册
#define URL_RegisterServlet @"RegisterServlet"

#pragma mark -
#pragma mark 百度
//百度统计信息
//#define BaiduMobStat_APPID @"3aec05f5e8"
//百度推送信息
#define BPushchannelid @"BPushchannelid"
#define BPushappid @"BPushappid"
#define BPushuserid @"BPushuserid"

#pragma mark -
#pragma mark 通知
#pragma mark NSNotificationCenter

#pragma mark - 
#pragma mark userdefault
//存放是否显示子菜单
#define kisshowSecondView @"kisshowSecondView"
//版本号
#define kbundleVersion @"kbundleVersion"
//摇一摇
#define kshakeCount @"kshakeCount"
//分类
#define kcategoryArray @"kcategoryArray"
// 用户字典
#define kuserDIC @"userDIC"

#pragma mark -
#pragma mark color
#define TextColor COLOR(247, 247, 247)
#define BackgroundColor COLOR(247, 247, 247)


#pragma mark - 
#pragma mark Message_info
#define INFO_NONETWORK @"test"


#pragma mark -
#pragma mark String

#define String_userMemberId @"userMemberId"
#define String_userName @"userName"
#define String_scores @"scores"
#define String_head @"scores"
#define String_coin @"coin"
#define String_collectCourseId @"collectCourseId"
#define String_selectCourseId @"selectCourseId"
#define String_collectCourseTotal @"collectCourseTotal"
#define String_selectCourseTotal @"selectCourseTotal"
#define String_signTotal @"signTotal"
#define String_memberTypeId @"memberTypeId"

#define String_navi_home_searchBar @"搜索课程"
#define String_shake_nochance @"今天的机会用完了~"
#define String_shake_tomorrow @"明天再来玩吧"
#pragma mark button
#define button_close @"关闭"
#define button_cancel @"取消"
#define button_loadMoreData @"上拉加载更多..."
#define button_loading @"正在加载"
#define button_loadEnd @"到底啦"
#define button_logout @"退出登录"

#pragma mark color 
#define home_title_textcolor COLOR(165, 165, 165)
#define home_cell_tile_textcolor COLOR(243, 176, 40)
#endif
