//
//  AppDelegate.m
//  集成支付宝
//
//  Created by xiaomage on 15/8/20.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "AppDelegate.h"
#import <AlipaySDK/AlipaySDK.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    //跳转支付宝钱包进行支付，处理支付结果
    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
        // NSLog(@"result = %@",resultDic); 支付结果
    }];
    
    return YES;
}

@end
