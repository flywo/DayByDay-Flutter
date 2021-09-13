//
//  MacroApi.h
//  ScenicNav
//
//  Created by laoK on 2019/1/18.
//  Copyright © 2019 xhkj. All rights reserved.
//

#ifndef MacroApi_h
#define MacroApi_h
   

//1测试
//#define BaseUrl @"http://www.sportlive8.com/"
//#define SocketUrl @"ws://sportlive8.com/ws/live/detail/online/"
//#define ListSocketUrl @"ws://sportlive8.com/ws/live/home/list"
 
//2获取线上
#define BaseUrl [NSString stringWithFormat:@"%@/", SNGlobalShared.baseUrl]
//详情长连接
#define SocketUrl [NSString stringWithFormat:@"%@/live/detail/online/", SNGlobalShared.socketUrl]
//列表长连接
#define ListSocketUrl [NSString stringWithFormat:@"%@/live/home/list", SNGlobalShared.socketUrl]
    

// 获取域名
#define URL_GetBaseUrl @"http://app-api.7pr7udfdmo4p.com/get_new"

//这两个暂时留着
// 获取域名主要
#define URL_GetBaseUrlFirst @"https://app-api.sqd01.com/get_new"
// 获取域名备用
#define URL_GetBaseUrlSecond @"https://app-api.sqd02.com/get_new"

//直播播放的开关
#define URL_On_Off @"sys/live/on-off"

//分类列表
#define URL_CATEGORY_LIST @"category/list"

//其他分类列表
#define URL_OTHER_CATEGORY_LIST @"other/category/list"

//比赛列表
#define URL_MATCH_LIST @"match/list/new"

//其他比赛列表
#define URL_OTHER_MATCH_LIST @"other/match/list"

//日历数据
#define URL_CALENDAR_DATA @"match/date/count"

//意见反馈
#define URL_Comment @"au/user/comment"

//获取用户信息
#define URL_GetUserInfo @"au/getuserinfo"

//退出登录
#define URL_LoginOut @"au/logout"

//手机号验证码登陆
#define URL_LoginMobile @"login/mobile"

//注册
#define URL_Register @"register"

//忘记密码
#define URL_ForgetPassword @""

//上传头像
#define URL_UploadImage @""

//修改个人信息
#define URL_ChangeInfo @"au/user/edit"

//用户发送验证码
#define URL_CodePath @"sendsms"

//账号密码登陆
#define URL_LoginAccount @"login"

//版本更新
#define URL_Version @"public/version/check"

//新闻列表
#define URL_News_List @"news/list"

//新闻详情
#define URL_News_Detail @"news/detail"
  
//比赛详情
#define URL_MATCH_DETAIL @"match/detail"

//比赛详情
#define URL_OTHER_MATCH_DETAIL @"other/match/detail"

//上传极光的id
#define URL_Deivce_RegID @"user/add/deivce"

//获取直播等长链接的token
#define URL_Detail_Tabs @"match/detail/tabs"

//获取篮球统计
#define URL_Detail_Count @"match/detail/count"
 
//获取聊天室 账户
#define URL_JPushAccountID @"user/jpush/account"

// 云信房间
#define URL_YXRoomID @"words/wangyi/match/chatroom"

// 云信账号
#define URL_YXUserID @"words/wangyi/user/add"

//获取渠道
#define URL_GetChannel @"sys/app/getchannel"

//获取分享
#define URL_ShareText @"sys/share/txt"

//获取日历球赛数据
#define URL_DataCount @"match/date/count"

//获取足球球员比赛信息
#define URL_PlayerInfo @"match/detail/player"

//获取篮球榜单数据
#define URL_BasketRankList @"data/lanqiu/ranklist"

//获取游客昵称
#define URL_TouristsNickName @"sys/get/nickname"

//获取推广的QQ
#define URL_GetQQNumber @"sys/contact/txt"
 
//观看时长
#define URL_WatchTime @"au/user/mission/watch"

//网易聊天发消息
#define URL_CheckTxt @"words/wangyi/check"
 
//api域名 防封检查接口
#define URL_CheckApiUrl @"/prod-api/sys/getnew/apiurl"

//获取邀请数量
#define URL_GetInviteCountUrl @"app/share/count"

//获取App类型
#define URL_GetAppType @"ios/app/souce"

//获取web地址
#define URL_GetWebUrl @"sys/ios/getweburl"
 
#endif /* MacroApi_h */ 
