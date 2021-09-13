//
//  KYApiHttpTool.h
//  ScenicNav
//
//  Created by laoK on 2019/1/18.
//  Copyright © 2019 xhkj. All rights reserved.
//

#import <Foundation/Foundation.h>
 
NS_ASSUME_NONNULL_BEGIN

@interface KYApiHttpTool : NSObject

/** GET请求 */
+ (void)GET:(NSString *)urlStr withParams:(NSDictionary  * _Nullable)params success:(void (^)(NSDictionary *response))success failure:(void (^)(NSError * _Nullable error))failure;

/** GET请求 */
+ (void)GETNoHud:(NSString *)urlStr withParams:(NSDictionary  * _Nullable)params success:(void (^)(NSDictionary *response))success failure:(void (^)(NSError * _Nullable error))failure;

+ (void)GETNoHud1:(NSString *)urlStr withParams:(NSDictionary  * _Nullable)params success:(void (^)(NSDictionary *response))success failure:(void (^)(NSError * _Nullable error))failure;

+ (void)GETNoHud2:(NSString *)urlStr withParams:(NSDictionary  * _Nullable)params success:(void (^)(NSDictionary *response))success failure:(void (^)(NSError * _Nullable error))failure;

+ (void)GETCheckApi:(NSString *)urlStr withParams:(NSDictionary  * _Nullable)params success:(void (^)(NSDictionary *response))success failure:(void (^)(NSError * _Nullable error))failure;

/** POST请求 */
+ (void)POST:(NSString *)urlStr withParams:(NSDictionary  * _Nullable)params success:(void (^)(NSDictionary *response))success failure:(void (^)(NSError * _Nullable error))failure;

@end

NS_ASSUME_NONNULL_END
