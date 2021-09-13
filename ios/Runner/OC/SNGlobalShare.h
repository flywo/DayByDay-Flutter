//
//  SNGlobalShare.h
//  SportNews
//
//  Created by kkk on 2021/3/17.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN
 
@interface SNGlobalShare : NSObject

/// 单例
+ (instancetype)sharedInstance;
   

@property (nonatomic , assign) BOOL isAppOpened;

@property(nonatomic, copy) NSString *baseUrl;

@property(nonatomic, copy) NSString *socketUrl;

@property(nonatomic, copy) NSString *backUrl;

@property (nonatomic, strong) NSArray *back_urls;

@property (nonatomic, strong) NSArray *Api_urls;

@property (nonatomic , assign) NSInteger contentBottomHeight;

//是否打开了网络权限
@property (nonatomic, assign) BOOL isRestricted;

- (NSArray *)initialImageArray;
 

@end

NS_ASSUME_NONNULL_END
