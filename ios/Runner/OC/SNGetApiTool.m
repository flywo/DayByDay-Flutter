//
//  SNGetApiTool.m
//  SportNews
//
//  Created by kiss on 2021/7/12.
//

#import "SNGetApiTool.h"
#import "KKRSATool.h"
#import "AFNetworking.h"
#import "KYApiHttpTool.h"
#import "MacroApi.h"
#import "SNGlobalShare.h"
#import "CommonTools.h"
#import "MacroKeys.h"

#define privatekey @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAKl5rVhhZ3FWV8S1+XfqHM4nhq3bCxeqN4wNMy8yB/3yZa98rGTMG3sE+2b/IJoxiIIOb373FLFhziulJxY5eaKnSuSb+LvQk/LaW7K6I+qCkuL9T3JorEZmJotzf/mJhA/plIvyvvwzTnB/pgeNkMi8hGaWJAuVZm1ichqFNOmpAgMBAAECgYAWTm+kfF2TK1wuBg2p3OShtc4iP/x7xum8w1gDVEB9ClSb/nrqYXsUfBli+x2dbfubsq62NWtB1a+/SuOUJ0h9Cxkz7NW7bIYPs7vpKXG3MMMT/JjJSHeMGLCD7OlkX3pwmwT2Gc36ZJNCk9I6byOa+fCG+Msu0mjixgNorJuzaQJBAOTF5RJyj/RB5X+CD6vpt7uPeepksl3kxek9yQ/xrwifViwR7V7B1mR26S+0j7aclCbuiYihXpcVB2FblmgFHMcCQQC9pSNyNSS6+mCi+n5GO5qintcRtPpKvWUPBi5uy1Rj2DL1ysMteswbAVcGMyrBd1Fxzw4Zu6sbLGKI8neHt/YPAkB8WdEtGNaEt3juuRyZnn2/Vrq3HKsTfHHTWUE8CGvS7QEjDU+QTR6jFzujMatYYH3rN4fMm6JVzxlm4yi7O+QrAkAboQ+E+BEd3JRvqibzfIOO5a1XuxIsCWPLyI7DPYRR95GVFbFR0u4hkRRoptO30/ZdqljXjuvizZidcxXPBBIpAkEAmnWunXFYnc9+3RTrlEtk0/YHYm6xy44/ztqrB1uWI8gbpCh+MzpzYlWnXARzDaeRyBRb/IWPWWuruP/dvmSDuw=="

@interface SNGetApiTool ()

//获取 back_urls的次数
@property (nonatomic, assign) NSInteger backCount;

//当前back_url的下标
@property (nonatomic, assign) NSInteger back_Urls_index;

//当前back_url
@property (nonatomic, copy) NSString *currentBackUrl;

//当前txt添加 01 02 的下标
@property (nonatomic, assign) NSInteger txt_index;

@property (nonatomic, strong) NSArray *txtNumArray;

//当前txt
@property (nonatomic, copy) NSString *currentTxt;
 
//最后的挣扎的下标
@property (nonatomic, assign) NSInteger zhengzha_index;

@property (nonatomic, strong) NSArray *zhengzhaArray;

//是否正在获取中
@property (nonatomic , assign) BOOL isGettingApi;

@end

@implementation SNGetApiTool

+ (instancetype)sharedInstance {
    static SNGetApiTool *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[SNGetApiTool alloc] init];
    });
    return instance;
}

- (void)getApiMethod {
    if (SNGetApiTool.sharedInstance.isGettingApi) {
        self.baseURL();
        return;
    }
    SNGetApiTool.sharedInstance.isGettingApi = YES;
    [KYApiHttpTool GETCheckApi:[NSString stringWithFormat:@"%@%@",[SNGlobalShare sharedInstance].baseUrl,URL_CATEGORY_LIST] withParams:nil success:^(NSDictionary * _Nonnull response) {
        if ([response[@"code"] integerValue] != 0) {
            [self currentUrlIsInvalete];
        }else {
            SNGetApiTool.sharedInstance.isGettingApi = NO;
        }
    } failure:^(NSError * _Nonnull error) {
            [self currentUrlIsInvalete];
    }];
    
}

- (void)currentUrlIsInvalete {
    SNGetApiTool.sharedInstance.back_Urls_index = 0;
    SNGetApiTool.sharedInstance.txt_index = 0;
    if (SNGetApiTool.sharedInstance.txtNumArray == 0) {
        SNGetApiTool.sharedInstance.txtNumArray = @[@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10"];
    }
    if (SNGetApiTool.sharedInstance.zhengzhaArray == 0) {
        NSArray *api_urls = [[NSUserDefaults standardUserDefaults] objectForKey:Local_zhengzha_API_Url];
        if (!api_urls) {
            api_urls = @[@"https://shuoqiudisite.com",
                         @"https://shuoqiudicool.com"];
            [[NSUserDefaults standardUserDefaults] setValue:api_urls forKey:Local_zhengzha_API_Url];
        }
        SNGetApiTool.sharedInstance.zhengzhaArray = api_urls;
    }
    NSString *backUrl = [[NSUserDefaults standardUserDefaults] objectForKey:Local_Current_Back_Url];
    if (!backUrl) {
        backUrl = URL_GetBaseUrl;
    }
    [SNGetApiTool.sharedInstance checkBackUrl:backUrl];
}
 
- (void)checkBackUrl:(NSString *)backUrl {
    [self GET:backUrl withParams:nil success:^(id _Nonnull response) {
        @try {
            [[NSUserDefaults standardUserDefaults] setValue:backUrl forKey:Local_Current_Back_Url];
            //RAS私钥
            NSString *originString = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
            //解析成功的数据
            NSString *decWithPrivKey = [KKRSATool decryptString:originString privateKey:privatekey];
            NSDictionary *dic = [CommonTools dictionaryWithJsonString:decWithPrivKey];
            self.currentTxt = dic[@"txt"];
            [SNGlobalShare sharedInstance].back_urls = dic[@"back_urls"];
            [[NSUserDefaults standardUserDefaults] setValue:[SNGlobalShare sharedInstance].back_urls forKey:Local_Back_Urls];
            NSString *apiUrl = [NSString stringWithFormat:@"%@%@.com",self.currentTxt,self.txtNumArray[self.txt_index]];
            [self checkTxtApiUrl:apiUrl];
        } @catch (NSException *exception) {
            
        } @finally {
                
        }
        
    } failure:^(NSError * _Nonnull error) {
        if (self.backCount < 3) {
            //防止网络不好 查询三次
            self.backCount += 1;
            [self checkBackUrl:backUrl];
        }else {
            self.backCount = 0;
            if ([SNGlobalShare sharedInstance].back_urls.count > 0 && self.back_Urls_index < [SNGlobalShare sharedInstance].back_urls.count) {
                NSString *backUrl = [SNGlobalShare sharedInstance].back_urls[self.back_Urls_index];
                [self checkBackUrl:backUrl];
                self.back_Urls_index += 1;
            }else {
                self.zhengzha_index = 0;
                if (self.zhengzhaArray.count > 0) {
                    [self zuiHouDeZhengZha:self.zhengzhaArray[self.zhengzha_index]];
                }
            }
        }
    }];

}

- (void)checkTxtApiUrl:(NSString *)baseUrl {
    NSString *url = [NSString stringWithFormat:@"https://%@/prod-api/%@",baseUrl,URL_CATEGORY_LIST];
    [KYApiHttpTool GETCheckApi:url withParams:nil success:^(NSDictionary * _Nonnull response) {
        [SNGlobalShare sharedInstance].baseUrl = [NSString stringWithFormat:@"https://%@/prod-api",baseUrl];
        [SNGlobalShare sharedInstance].socketUrl = [NSString stringWithFormat:@"wss://%@/prod-api/ws",baseUrl];
        NSString *baseUrl = [[NSUserDefaults standardUserDefaults] objectForKey:Local_BaseUrl];
        if (![baseUrl isEqualToString:[SNGlobalShare sharedInstance].baseUrl]) {
            self.baseURL();
        }
        SNGetApiTool.sharedInstance.isGettingApi = NO;
        [[NSUserDefaults standardUserDefaults] setValue:[SNGlobalShare sharedInstance].baseUrl forKey:Local_BaseUrl];
        [[NSUserDefaults standardUserDefaults] setValue:[SNGlobalShare sharedInstance].socketUrl forKey:Local_SocketUrl];
    } failure:^(NSError * _Nonnull error) {
        self.txt_index += 1;
        if (self.txt_index < self.txtNumArray.count) {
            NSString *apiUrl = [NSString stringWithFormat:@"%@%@.com",self.currentTxt,self.txtNumArray[self.txt_index]];
            [self checkTxtApiUrl:apiUrl];
        }else {
            //一轮寻找都不同 继续第二轮
            self.txt_index = 0;
            if ([SNGlobalShare sharedInstance].back_urls.count > 0 && self.back_Urls_index < [SNGlobalShare sharedInstance].back_urls.count) {
                NSString *backUrl = [SNGlobalShare sharedInstance].back_urls[self.back_Urls_index];
                [self checkBackUrl:backUrl];
                self.back_Urls_index += 1;
            }else {
                if (self.zhengzhaArray.count > 0 && self.zhengzha_index < self.zhengzhaArray.count) {
                    [self zuiHouDeZhengZha:self.zhengzhaArray[self.zhengzha_index]];
                }else {
                    SNGetApiTool.sharedInstance.isGettingApi = NO;
                }
            }
        }
    }];
}

//最后的挣扎
- (void)zuiHouDeZhengZha:(NSString *)baseUrl {
    NSString *url = [NSString stringWithFormat:@"%@/prod-api/%@",baseUrl,URL_CATEGORY_LIST];
    [KYApiHttpTool GETCheckApi:url withParams:nil success:^(NSDictionary * _Nonnull response) {
        [SNGlobalShare sharedInstance].baseUrl = [NSString stringWithFormat:@"%@/prod-api",baseUrl];
        NSString *wsUrl = [url stringByReplacingOccurrencesOfString:@"https" withString:@"wss"];
        [SNGlobalShare sharedInstance].socketUrl = [NSString stringWithFormat:@"%@/prod-api/ws",wsUrl];
        NSString *baseUrl = [[NSUserDefaults standardUserDefaults] objectForKey:Local_BaseUrl];
        if (![baseUrl isEqualToString:[SNGlobalShare sharedInstance].baseUrl]) {
            self.baseURL();
        }
        [[NSUserDefaults standardUserDefaults] setValue:[SNGlobalShare sharedInstance].baseUrl forKey:Local_BaseUrl];
        [[NSUserDefaults standardUserDefaults] setValue:[SNGlobalShare sharedInstance].socketUrl forKey:Local_SocketUrl];
        [self getNewCheckUrl:baseUrl];
    } failure:^(NSError * _Nonnull error) {
        self.zhengzha_index += 1;
        if (self.zhengzha_index < self.zhengzhaArray.count) {
            [self zuiHouDeZhengZha:self.zhengzhaArray[self.zhengzha_index]];
        }else {
            SNGetApiTool.sharedInstance.isGettingApi = NO;
        }
    }];
}


//获取新的 获取前缀的接口
- (void)getNewCheckUrl:(NSString *)baseUrl {
    [self GET:[NSString stringWithFormat:@"%@%@",baseUrl,URL_CheckApiUrl] withParams:nil success:^(id _Nonnull response) {
        @try {
            NSString *responseStr = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
            NSDictionary *responseDic = [CommonTools dictionaryWithJsonString:responseStr];
            if ([responseDic[@"code"] integerValue] == 0) {
                //RAS私钥 解析成功的数据
                NSString *originString = responseDic[@"data"];
                NSString *decWithPrivKey = [KKRSATool decryptString:originString privateKey:privatekey];
                NSDictionary *dic = [CommonTools dictionaryWithJsonString:decWithPrivKey];
                self.currentTxt = dic[@"txt"];
                [SNGlobalShare sharedInstance].back_urls = dic[@"back_urls"];
                if ([SNGlobalShare sharedInstance].back_urls.count > 0) {
                    [[NSUserDefaults standardUserDefaults] setValue:[SNGlobalShare sharedInstance].back_urls.firstObject forKey:Local_Current_Back_Url];
                    [[NSUserDefaults standardUserDefaults] setValue:[SNGlobalShare sharedInstance].back_urls forKey:Local_Back_Urls];
                }
                [[NSUserDefaults standardUserDefaults] setValue:dic[@"back_api_urls"] forKey:Local_zhengzha_API_Url];
                self.txt_index = 0;
                NSString *apiUrl = [NSString stringWithFormat:@"%@%@.com",self.currentTxt,self.txtNumArray[self.txt_index]];
                [self checkTxtApiUrl:apiUrl];
            }
        } @catch (NSException *exception) {
            
        } @finally {
                
        }
        
    } failure:^(NSError * _Nonnull error) {
        
    }];

}

- (void)GET:(NSString *)URL withParams:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    config.timeoutIntervalForRequest = 10.0;
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:config];
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
