//
//  ViewController.m
//  BasicAppKit
//
//  Created by xujun on 2019/10/9.
//  Copyright © 2019 xujun. All rights reserved.
//

#import "FirstViewController.h"
#import "NextViewController.h"
#import "ShareSDKHelper.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    self.view.backgroundColor = [UIColor systemGreenColor];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 80, 40);
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"NEXT" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *sharebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sharebtn.frame = CGRectMake(100, 200, 80, 40);
    sharebtn.backgroundColor = [UIColor redColor];
    [sharebtn setTitle:@"SHARE" forState:UIControlStateNormal];
    [sharebtn addTarget:self action:@selector(shareData) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sharebtn];
    
    UIButton *authbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    authbtn.frame = CGRectMake(100, 300, 80, 40);
    authbtn.backgroundColor = [UIColor redColor];
    [authbtn setTitle:@"AUTH" forState:UIControlStateNormal];
    [authbtn addTarget:self action:@selector(authuser) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:authbtn];
}

- (void)btnClick {
    NextViewController *vc = [[NextViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)shareData {
    [ShareSDKHelper share:@"https://www.baidu.com" text:@"1212121" image:@"icon_category" title:@"1212121" tag:1];
}

- (void)authuser {
    [ShareSDKHelper authorize:SSDKPlatformSubTypeWechatSession success:^(SSDKUser *user) {
        NSLog(@"");
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
