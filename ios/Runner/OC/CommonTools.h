//
//  CommonTools.h
//  ScenicNav
//
//  Created by laoK on 2019/1/10.
//  Copyright © 2019 xhkj. All rights reserved.
//

#import <Foundation/Foundation.h>
 
NS_ASSUME_NONNULL_BEGIN

@interface CommonTools : NSObject

//获取比分结果
+ (NSString *)getScoreResult:(NSString *)score isHome:(BOOL)isHome;

//获取比分结果
+ (NSString *)getBasketScoreResult:(NSString *)score isHome:(BOOL)isHome;

//根据状态获取足球的描述
+ (NSString *)getFootStatus:(NSInteger)status;
//根据状态获取篮球的描述
+ (NSString *)getBasketStatus:(NSInteger)status;

#pragma mark === 播放动画 ======

+ (NSString *)getRandomStringWithNum:(NSInteger)num;

+ (void)AFNReachability;

+ (NSMutableAttributedString *)attributeStringWith:(NSString *)mainTitle withsubTitle:(NSString*)subTitle;

// 判断字符串是否为空 是为空
+ (BOOL)isBlankString:(NSString *)aStr;

//字典转字符串
+ (NSString *)convertToJsonData:(NSDictionary *)dict;

//不去空格 回车
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;

//字符串转字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

//取出小数点后面的零
+ (NSString *)removeFloatAllZero:(NSString *)numberStr;

// 获取缓存文件的大小
+ (float)readCacheSize;

//清除缓存
+ (void)clearFile;
 
//判断是不是iPhonex
+ (BOOL)isNotchScreen;
 
//跳转到设置
+ (void)jumpToSetting;

//检查通知是否打开
+ (void)checkNotificationStatus:(void(^)(BOOL isOpen))handler;


/** 直接传入精度丢失有问题的Double类型*/
+ (NSString *)decimalNumberWithDouble:(double)conversionValue;

+ (NSMutableAttributedString *)setupAttributeString:(NSString *)contentStr;
 


@end

NS_ASSUME_NONNULL_END
