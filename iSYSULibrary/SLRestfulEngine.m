//
//  SLRestfulEngine.m
//  iSYSULibrary
//
//  Created by Alaysh on 14-9-18.
//  Copyright (c) 2014年 Alaysh. All rights reserved.
//

#import "SLRestfulEngine.h"
#import <SystemConfiguration/SCNetworkReachability.h>

NSString * const HOST_URL = @"";

@implementation SLRestfulEngine

+ (BOOL)isConnectedToNetwork
{
    //创建零地址，0.0.0.0的地址表示查询本机的网络连接状态
    
    struct sockaddr_storage zeroAddress;
    
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.ss_len = sizeof(zeroAddress);
    zeroAddress.ss_family = AF_INET;
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    //获得连接的标志
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    //如果不能获取连接标志，则不能连接网络，直接返回
    if (!didRetrieveFlags)
    {
        return NO;
    }
    //根据获得的连接标志进行判断
    
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable&&!needsConnection) ? YES : NO;
}

+ (void)httpRequestWithMethod: (NSString *)method action: (NSString *)action param: (NSString *)param onSucceed:(SucceedBlock)succeedBlock onError:(ErrorBlock)errorBlock
{
    NSURL *url = nil;
    NSMutableURLRequest *urlRequest = nil;
    if ([method isEqualToString: @"POST"]) {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", HOST_URL, action]];
        urlRequest = [NSMutableURLRequest requestWithURL:url];
        [urlRequest setHTTPMethod:@"POST"];
        [urlRequest setHTTPBody:[param dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:true]];
    }
    else if ([method isEqualToString:@"GET"]) {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@?%@", HOST_URL, action, param]];
        urlRequest = [NSMutableURLRequest requestWithURL:url];
        [urlRequest setHTTPMethod:@"GET"];
    }
    else {
        
    }
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *urlSession = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    NSURLSessionDataTask *dataTask =  [urlSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error) {
            NSHTTPURLResponse *httpResp = (NSHTTPURLResponse*) response;
            if (httpResp.statusCode == 200) {
                NSError *jsonError;
                NSDictionary *jsonDic =
                [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
                if (!jsonError) {
                    succeedBlock(jsonDic);
                }
            }
            else {
                errorBlock(error);
            }
        }
        else {
            errorBlock(error);
        }
    }];
    [dataTask resume];
}

+ (void)loginWithName: (NSString *)username password: (NSString *)password onSucceed:(SucceedBlock)succeedBlock onError:(ErrorBlock)errorBlock
{
    
}

+ (void)loadNewBookWithPage: (int)page onSucceed:(SucceedBlock)succeedBlock onError:(ErrorBlock)errorBlock
{
    
}
+ (void)loadHotBookWithPage: (int)page onSucceed:(SucceedBlock)succeedBlock onError:(ErrorBlock)errorBlock
{

}

+ (void)searchBookWithKeyword: (NSString *)keyword type:(int)type page:(int)page onSucceed:(SucceedBlock)succeedBlock onError:(ErrorBlock)errorBlock
{
    
}

+ (void)loadMyLoanOnSucceed:(SucceedBlock)succeedBlock onError:(ErrorBlock)errorBlock
{
    
}

+ (void)loadBorHoldOnSucceed:(SucceedBlock)succeedBlock onError:(ErrorBlock)errorBlock
{
    
}

+ (void)loadBorRecommendOnSucceed:(SucceedBlock)succeedBlock onError:(ErrorBlock)errorBlock
{
    
}

+ (void)loadLoanhistoryOnSucceed:(SucceedBlock)succeedBlock onError:(ErrorBlock)errorBlock
{
    
}

@end