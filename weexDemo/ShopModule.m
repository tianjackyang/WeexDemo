//
//  ShopModule.m
//  weexDemo
//
//  Created by xindong on 17/7/5.
//  Copyright © 2017年 xindong. All rights reserved.
//

#import "ShopModule.h"

#import <WeexSDK/WeexSDK.h>
#import <WeexSDK/WXModuleProtocol.h>

@interface ShopModule ()<WXModuleProtocol>

@end

@implementation ShopModule

WX_EXPORT_METHOD(@selector(toast:))
WX_EXPORT_METHOD(@selector(alert:callback:))
WX_EXPORT_METHOD(@selector(confirm:callback:))

// 等同于@synthesize weexInstance = weexInstance;
@synthesize weexInstance;

- (void)confirm:(NSDictionary *)param callback:(WXModuleCallback)callback
{
    NSString *message = [self stringValue:param[@"message"]];
    NSString *okTitle = [self stringValue:param[@"okTitle"]];
    NSString *cancelTitle = [self stringValue:param[@"cancelTitle"]];
    if (okTitle.length==0) {
        okTitle = @"确认";
    }
    if (cancelTitle.length==0) {
        cancelTitle = @"取消";
    }
    /* 此处为自己的弹框组件或者系统的组件 */
    
    /**/
    callback(okTitle);
}

- (void)toast:(NSDictionary *)param{
    NSString *message = [NSString stringWithFormat:@"%@", param[@"message"]];
    if (!message) return;
    /* 此处为自己的toast 组件 */
    
    /**/
    
}

- (void)alert:(NSDictionary *)param callback:(WXModuleCallback)callback
{
    NSString *message = [self stringValue:param[@"message"]];
    NSString *okTitle = [self stringValue:param[@"okTitle"]];
    /* 此处为自己的弹框组件或者系统的组件 */
    
    /**/
    callback(okTitle);
}

// 获取当前NVC
-(UINavigationController *)currentNVC {
    return [weexInstance.viewController navigationController];
}

// 获取当前VC
-(UIViewController *)currentVC {
    return weexInstance.viewController;
}

- (NSString*)stringValue:(id)value
{
    if ([value isKindOfClass:[NSString class]]) {
        return value;
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value stringValue];
    }
    return nil;
}

@end
