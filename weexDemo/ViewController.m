//
//  ViewController.m
//  weexDemo
//
//  Created by xindong on 17/7/4.
//  Copyright © 2017年 xindong. All rights reserved.
//

#import "ViewController.h"
#import <WeexSDK/WXSDKInstance.h>

@interface ViewController ()

// 一个`WXSDKInstance`就对应一个`UIViewController`, 对应一个weex页面.
@property (nonatomic, strong) WXSDKInstance *instance;
@property (nonatomic, strong) UIView *weexView;
@property (nonatomic, strong) NSURL *url;

@end

@implementation ViewController

- (NSURL *)url {
    if (!_url) {
        _url = [[NSBundle mainBundle] URLForResource:@"app"   withExtension:@"js"];
    }
    return _url;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _instance = [[WXSDKInstance alloc] init];
    _instance.viewController = self;
    _instance.frame = (CGRect){self.view.center.x - 100, self.view.center.y - 150, 200, 300};

    __weak typeof(self) weakSelf = self;
    _instance.onCreate = ^(UIView *view) {
        view.backgroundColor = [UIColor greenColor];
        [weakSelf.weexView removeFromSuperview];
        weakSelf.weexView = view;
        [weakSelf.view addSubview:weakSelf.weexView];
    };
    
    _instance.onFailed = ^(NSError *error) {
        //process failure
        NSLog(@"render error");
    };
    
    _instance.renderFinish = ^ (UIView *view) {
        //process renderFinish
        NSLog(@"render finish");
    };
    
    [_instance renderWithURL:self.url options:@{@"--":[self.url absoluteString]} data:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_instance destroyInstance];
}



@end
