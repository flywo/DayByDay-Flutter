//
//  KYApiHttpTool.m
//  ScenicNav
//
//  Created by laoK on 2019/1/18.
//  Copyright © 2019 xhkj. All rights reserved.
//

#import "KYApiHttpTool.h" 
#import "AFNetworking.h"
#import "MSNetwork.h"
#import "MacroApi.h"
#import "SNGlobalShare.h"
#import "MJExtension.h"


@implementation KYApiHttpTool

/** GET请求 */
+ (void)GET:(NSString *)urlStr withParams:(NSDictionary  * _Nullable)params success:(void (^)(NSDictionary *response))success failure:(void (^)(NSError * _Nullable error))failure {
 
    @try {
        //路径
        NSString *url = [NSString stringWithFormat:@"%@%@",[SNGlobalShare sharedInstance].baseUrl,urlStr];
        NSLog(@"请求:%@ 参数:%@", url, [params mj_JSONString]);
        [MSNetwork closeLog];
        [MSNetwork setRequestTimeoutInterval:20.0f];
        [MSNetwork GET:url parameters:params headers:nil cachePolicy:MSCachePolicyOnlyNetNoCache success:^(id  _Nonnull responseObject) {
            if (responseObject) {
                if ([responseObject[@"code"] integerValue] != 0) {
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    });
                    if (failure) {
                        failure(nil);
                    }
                }else {
                    if (success) {
                        success(responseObject);
                    }
                }
            }else {
                if (failure) {
                    failure(nil);
                }
            }
        } failure:^(NSError * _Nonnull error) {
            if (failure) {
                failure(error);
            }
        }];
        
    } @catch (NSException *exception) {
        
    } @finally {
            
    }
    
}

/** GET请求 */
+ (void)GETNoHud:(NSString *)urlStr withParams:(NSDictionary  * _Nullable)params success:(void (^)(NSDictionary *response))success failure:(void (^)(NSError * _Nullable error))failure {
    
       @try {
           //路径 
           NSString *url = [NSString stringWithFormat:@"%@%@",[SNGlobalShare sharedInstance].baseUrl,urlStr];
           if ([urlStr containsString:@"http"]) {
               url = urlStr;
           }
           NSLog(@"%@", url);
           [MSNetwork closeLog];
           [MSNetwork setRequestTimeoutInterval:20.0f];
           [MSNetwork GET:url parameters:params headers:nil cachePolicy:MSCachePolicyOnlyNetNoCache success:^(id  _Nonnull responseObject) {
               if (responseObject) {
                   if ([responseObject[@"code"] integerValue] != 0) {
                       if (failure) {
                           failure(nil);
                       }
                   }else {
                       if (success) {
                           success(responseObject);
                       }
                   }
               }else {
                   if (failure) {
                       failure(nil);
                   }
               }
           } failure:^(NSError * _Nonnull error) {
               if (failure) {
                   failure(error);
               }
           }];
           
       } @catch (NSException *exception) {
           
       } @finally {
               
       }
}

/** GET请求 */
+ (void)GETNoHud1:(NSString *)urlStr withParams:(NSDictionary  * _Nullable)params success:(void (^)(NSDictionary *response))success failure:(void (^)(NSError * _Nullable error))failure {
    
       @try {
           //路径
           NSString *url = [NSString stringWithFormat:@"%@%@",[SNGlobalShare sharedInstance].baseUrl,urlStr];
           if ([urlStr containsString:@"http"]) {
               url = urlStr;
           }
           NSLog(@"%@", url);
           [MSNetwork closeLog];
           [MSNetwork setRequestTimeoutInterval:20.0f];
           [MSNetwork GET:url parameters:params headers:nil cachePolicy:MSCachePolicyOnlyNetNoCache success:^(id  _Nonnull responseObject) {
               if ([responseObject[@"code"] integerValue] == 0) {
                   if (success) {
                       success(responseObject);
                   }
               }else {
                   if (failure) {
                       failure(nil);
                   }
               }
           } failure:^(NSError * _Nonnull error) {
               if (failure) {
                   failure(error);
               }
           }];
           
       } @catch (NSException *exception) {
           
       } @finally {
               
       }
}

/** GET请求 */
+ (void)GETNoHud2:(NSString *)urlStr withParams:(NSDictionary  * _Nullable)params success:(void (^)(NSDictionary *response))success failure:(void (^)(NSError * _Nullable error))failure {
    
       @try {
           [MSNetwork setRequestTimeoutInterval:20.0f];
           [MSNetwork closeLog];
           [MSNetwork GET:urlStr parameters:params headers:nil cachePolicy:MSCachePolicyOnlyNetNoCache success:^(id  _Nonnull responseObject) {
               if (responseObject) {
                   if (success) {
                       success(responseObject);
                   }
               }else {
                   if (failure) {
                       failure(nil);
                   }
               }
           } failure:^(NSError * _Nonnull error) {
               if (failure) {
                   failure(error);
               }
           }];
           
       } @catch (NSException *exception) {
           
       } @finally {
               
       }
}

/** GET请求 */
+ (void)GETCheckApi:(NSString *)urlStr withParams:(NSDictionary  * _Nullable)params success:(void (^)(NSDictionary *response))success failure:(void (^)(NSError * _Nullable error))failure {
    
       @try {
           [MSNetwork setRequestTimeoutInterval:10.0f];
           [MSNetwork closeLog];
           [MSNetwork GET:urlStr parameters:params headers:nil cachePolicy:MSCachePolicyOnlyNetNoCache success:^(id  _Nonnull responseObject) {
               if (responseObject && [responseObject[@"code"] integerValue] == 0) {
                   if (success) {
                       success(responseObject);
                   }
               }else {
                   if (failure) {
                       failure(nil);
                   }
               }
           } failure:^(NSError * _Nonnull error) {
               if (failure) {
                   failure(error);
               }
           }];
           
       } @catch (NSException *exception) {
           
       } @finally {
               
       }
}
 
 
/** POST请求 */
+ (void)POST:(NSString *)urlStr withParams:(NSDictionary  * _Nullable)params success:(void (^)(NSDictionary *response))success failure:(void (^)(NSError * _Nullable error))failure {
 
    @try {
        //路径
        NSString *url = [NSString stringWithFormat:@"%@%@",[SNGlobalShare sharedInstance].baseUrl,urlStr];
        NSLog(@"%@", url);
        [MSNetwork closeLog];
        [MSNetwork setRequestTimeoutInterval:20.0f];
        [MSNetwork POST:url parameters:params headers:nil cachePolicy:MSCachePolicyOnlyNetNoCache success:^(id  _Nonnull responseObject) {
            if (responseObject) {
                if ([responseObject[@"code"] integerValue] != 0) {
                    if (failure) {
                        failure(nil);
                    }
                }else {
                    if (success) {
                        success(responseObject);
                    }
                }
            }else {
                if (failure) {
                    failure(nil);
                }
            }
        } failure:^(NSError * _Nonnull error) {
            if (failure) {
                failure(error);
            }
        }];
        
    } @catch (NSException *exception) {
        
    } @finally {
            
    }
    
}

@end
