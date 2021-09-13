//
//  SNGetApiUrlsTool.h
//  SportNews
//
//  Created by K哥 on 2021/7/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SNGetApiUrlsTool : NSObject

@property (nonatomic, copy) void(^baseURL)(void);

+ (instancetype)sharedInstance;

//获取域名
- (void)getApiUrls;

@end

NS_ASSUME_NONNULL_END
