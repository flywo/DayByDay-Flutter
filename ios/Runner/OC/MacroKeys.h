//
//  MacroKeys.h
//  ScenicNav
//
//  Created by laoK on 2019/1/14.
//  Copyright © 2019 xhkj. All rights reserved.
//

#ifndef MacroKeys_h
#define MacroKeys_h


//是否关闭小窗口播放
#define CloseSmallWindow @"CloseSmallWindow"
 
//友盟
#define K_UMENG_APPKEY @"5ffa199af1eb4f3f9b57a14e"

//极光 
#define JPushRegistrationID   @"JPushRegistrationID"

#define JPushAppKey [CommonTools getJPushAppKey]
#define JPushChannel @"www.baidu.com"


#define K_TouristsNickName   @"TouristsNickNameKey"

//网易
#define K_WANGYI_APPKEY @"c5333ccb8841d4c935bd9943b9724e86"
#define K_WANGYI_SECRET @"b5b9c0d9784b"
#define K_WANGYI_ACCID @"KWANGYIACCID" //账号
#define K_WANGYI_TOKEN @"KWANGYITOKEN" //token



/***********所有的key 包括通知、偏好设置等*************/
//我的头像存储地址
#define headImageFilePath @"headImageFilePath.png"

//头像修改成功
#define changeHeaderImageSuccessPath @"changeHeaderImageSuccess"
//昵称修改成功
#define changeNickNameSuccessPath @"changeNickNameSuccess"

//倒计时
#define KCountDownNotification @"KCountDownNotification"

//是否关闭小窗口播放
#define CloseSmallWindow @"CloseSmallWindow"

//首页ws接收到了完成的比赛数据
#define RecieveFinishListData @"RecieveFinishListData"

//api 域名
#define Local_BaseUrl @"Local_BaseUrl"
//socket 域名
#define Local_SocketUrl @"Local_SocketUrl"

//备用域名数组
#define Local_Back_Urls @"Local_Back_Urls"
//当前获取备用地址
#define Local_Current_Back_Url @"Local_Current_Back_Url"

//最后挣扎的api
#define Local_zhengzha_API_Url @"Local_zhengzha_API_Url"

/// 通知，LiveListViewController收到该通知，就需要切换当前列表是以比分表现还是以指数表现。
#define ChangeShowType @"ChangeShowType"

#define ListRefreshBtnAction @"ListRefreshBtnAction"

#define ListRefreshComplete @"ListRefreshComplete"
    

//保存当前是哪个App
#define SaveCurrentAppType @"SaveCurrentAppType"

//保存当前是显示testflight的样式还是正常的
#define SaveCurrentAppStyle @"SaveCurrentAppStyle"

#endif /* MacroKeys_h */
 
