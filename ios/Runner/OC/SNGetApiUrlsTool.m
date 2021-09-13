//
//  SNGetApiUrlsTool.m
//  SportNews
//
//  Created by K哥 on 2021/7/20.
//

#import "SNGetApiUrlsTool.h"
#import "KKRSATool.h"
#import "AFNetworking.h"
#import "KYApiHttpTool.h"
#import "MacroKeys.h"
#import "MacroApi.h"
#import "SNGlobalShare.h"
#import "CommonTools.h"

#define privatekey @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAKl5rVhhZ3FWV8S1+XfqHM4nhq3bCxeqN4wNMy8yB/3yZa98rGTMG3sE+2b/IJoxiIIOb373FLFhziulJxY5eaKnSuSb+LvQk/LaW7K6I+qCkuL9T3JorEZmJotzf/mJhA/plIvyvvwzTnB/pgeNkMi8hGaWJAuVZm1ichqFNOmpAgMBAAECgYAWTm+kfF2TK1wuBg2p3OShtc4iP/x7xum8w1gDVEB9ClSb/nrqYXsUfBli+x2dbfubsq62NWtB1a+/SuOUJ0h9Cxkz7NW7bIYPs7vpKXG3MMMT/JjJSHeMGLCD7OlkX3pwmwT2Gc36ZJNCk9I6byOa+fCG+Msu0mjixgNorJuzaQJBAOTF5RJyj/RB5X+CD6vpt7uPeepksl3kxek9yQ/xrwifViwR7V7B1mR26S+0j7aclCbuiYihXpcVB2FblmgFHMcCQQC9pSNyNSS6+mCi+n5GO5qintcRtPpKvWUPBi5uy1Rj2DL1ysMteswbAVcGMyrBd1Fxzw4Zu6sbLGKI8neHt/YPAkB8WdEtGNaEt3juuRyZnn2/Vrq3HKsTfHHTWUE8CGvS7QEjDU+QTR6jFzujMatYYH3rN4fMm6JVzxlm4yi7O+QrAkAboQ+E+BEd3JRvqibzfIOO5a1XuxIsCWPLyI7DPYRR95GVFbFR0u4hkRRoptO30/ZdqljXjuvizZidcxXPBBIpAkEAmnWunXFYnc9+3RTrlEtk0/YHYm6xy44/ztqrB1uWI8gbpCh+MzpzYlWnXARzDaeRyBRb/IWPWWuruP/dvmSDuw=="

@interface SNGetApiUrlsTool()

//是否正在获取中
@property (nonatomic , assign) BOOL isGettingApi;

//获取 Api_urls的次数
@property (nonatomic, assign) NSInteger backCount;

@property (nonatomic, strong) NSArray *thirdArray;

//thirdArray的下标
@property (nonatomic, assign) NSInteger third_index;

//当前Api下标
@property (nonatomic, assign) NSInteger Api_index;

@end

@implementation SNGetApiUrlsTool


+ (instancetype)sharedInstance {
    static SNGetApiUrlsTool *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[SNGetApiUrlsTool alloc] init];
    });
    return instance;
}

//获取Api
- (void)getApiUrls {
    if (SNGetApiUrlsTool.sharedInstance.isGettingApi) {
        self.baseURL();
        return;
    }
    [self setupSNGlobal];
    SNGetApiUrlsTool.sharedInstance.isGettingApi = YES;
    [KYApiHttpTool GETCheckApi:[NSString stringWithFormat:@"%@/%@",[SNGlobalShare sharedInstance].baseUrl,URL_CATEGORY_LIST] withParams:nil success:^(NSDictionary * _Nonnull response) {
        if ([response[@"code"] integerValue] == 0) {
            SNGetApiUrlsTool.sharedInstance.isGettingApi = NO;
            self.baseURL();
        }else {
            [self currentApiUseable];
        }
    } failure:^(NSError * _Nonnull error) {
        [self currentApiUseable];
    }]; 
}

- (void)setupSNGlobal {
    NSString *baseUrl = [[NSUserDefaults standardUserDefaults] objectForKey:Local_BaseUrl];
    if (baseUrl) {
        [SNGlobalShare sharedInstance].baseUrl = baseUrl;
    }else {
        [SNGlobalShare sharedInstance].baseUrl = @"https://shuoqiudi9/prod-api";
    }
    NSString *socketUrl = [[NSUserDefaults standardUserDefaults] objectForKey:Local_SocketUrl];
    if (socketUrl) {
        [SNGlobalShare sharedInstance].socketUrl = socketUrl;
    }else {
        [SNGlobalShare sharedInstance].socketUrl = @"wss://shuoqiudi9/prod-api/ws";
    }
}
 
- (void)currentApiUseable {
    SNGetApiUrlsTool.sharedInstance.backCount = 0;
    SNGetApiUrlsTool.sharedInstance.third_index = 0;
    SNGetApiUrlsTool.sharedInstance.Api_index = 0;
    if (SNGetApiUrlsTool.sharedInstance.thirdArray == 0) {
        SNGetApiUrlsTool.sharedInstance.thirdArray = @[
            @"https://chenlong2.coding.net/p/chenlong2/d/chenlong2/git/raw/master/jquery.js",
            @"https://gitee.com/zhaoqing00/public/raw/main/jquery.js",
            @"https://codechina.csdn.net/chenlong8098/public/-/raw/master/jquery.js",
            @"https://raw.githubusercontent.com/chenlong8098/public/main/jquery.js"
        ];
    }
    [SNGetApiUrlsTool.sharedInstance getAipUrlsArray:SNGetApiUrlsTool.sharedInstance.thirdArray.firstObject];
}

- (void)getAipUrlsArray:(NSString *)url {
    self.Api_index = 0;
    [self GET:url withParams:nil success:^(id _Nonnull response) {
        @try {
            NSString *originString = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
            //解析成功的数据
            NSString *decWithPrivKey = [KKRSATool decryptString:originString privateKey:privatekey];
            NSArray *ApiArray = (NSArray *)[CommonTools dictionaryWithJsonString:decWithPrivKey];
            [SNGlobalShare sharedInstance].Api_urls = ApiArray;
            if (ApiArray.count > 0) {
                [self checkApiUrl:ApiArray.firstObject];
            }else {
                self.third_index += 1;
                if (self.third_index < self.thirdArray.count) {
                    [self getAipUrlsArray:self.thirdArray[self.third_index]];
                }else {
                    self.isGettingApi = NO;
                }
            }
        } @catch (NSException *exception) {
            
        } @finally {
            
        }
    } failure:^(NSError * _Nonnull error) {
        if (self.backCount < 3) {
            //防止网络不好 查询三次
            self.backCount += 1;
            [self getAipUrlsArray:url];
        }else {
            self.backCount = 0;
            self.third_index += 1;
            if (self.third_index < self.thirdArray.count) {
                NSString *thirdUrl = self.thirdArray[self.third_index];
                [self getAipUrlsArray:thirdUrl];
            }else {
                self.isGettingApi = NO;
            }
        }
    }];
}

//验证api
- (void)checkApiUrl:(NSString *)url {
    [KYApiHttpTool GETCheckApi:[NSString stringWithFormat:@"%@/prod-api/%@",url,URL_CATEGORY_LIST] withParams:nil success:^(NSDictionary * _Nonnull response) {
        self.isGettingApi = NO;
        [SNGlobalShare sharedInstance].baseUrl = [NSString stringWithFormat:@"%@/prod-api",url];
        NSString *wsUrl = [url stringByReplacingOccurrencesOfString:@"https" withString:@"wss"];
        [SNGlobalShare sharedInstance].socketUrl = [NSString stringWithFormat:@"%@/prod-api/ws",wsUrl];
        NSString *localBaseUrl = [[NSUserDefaults standardUserDefaults] objectForKey:Local_BaseUrl];
        self.baseURL();
        [[NSUserDefaults standardUserDefaults] setValue:[SNGlobalShare sharedInstance].baseUrl forKey:Local_BaseUrl];
        [[NSUserDefaults standardUserDefaults] setValue:[SNGlobalShare sharedInstance].socketUrl forKey:Local_SocketUrl];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } failure:^(NSError * _Nonnull error) {
        self.Api_index += 1;
        if (self.Api_index < [SNGlobalShare sharedInstance].Api_urls.count) {
            [self checkApiUrl:[SNGlobalShare sharedInstance].Api_urls[self.Api_index]];
        }else {
            self.third_index += 1;
            if (self.third_index < self.thirdArray.count) {
                [self getAipUrlsArray:self.thirdArray[self.third_index]];
            }else {
                self.isGettingApi = NO;
            }
        }
    }];
}


- (void)GET:(NSString *)URL withParams:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    config.timeoutIntervalForRequest = 10.0;
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:config];//这个东西 加上就 好了
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
    [manager GET:URL parameters:params headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}


@end
