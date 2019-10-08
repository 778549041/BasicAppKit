//
//  UIViewController+Action.m
//  EPOS_2.0
//
//  Created by 秦辉 on 2017/12/27.
//  Copyright © 2017年 LCSW. All rights reserved.
//

#import "UIViewController+Action.h"
#import "UIView+BlockGesture.h"

@implementation UIViewController (Action)

- (void)addNavigationViewWithTitle:(NSString *)title andBgColor:(UIColor *)color clickBtnWithClickBackBlock:(void (^)())block{
    UIView *navigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, TopBarHeight)];
    navigationView.backgroundColor = color;
    [self.view addSubview:navigationView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, TopBarHeight)];
    imageView.image = GetImage(@"blue_bg_2");
    [navigationView addSubview:imageView];
    
    UILabel *navTitleLbl = [[UILabel alloc] init];
    navTitleLbl.text = title;
    navTitleLbl.textColor = [UIColor whiteColor];
    [navigationView addSubview:navTitleLbl];
    [navTitleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(navigationView).offset(ISIPHONEX ? 22 : 10);
        make.centerX.equalTo(navigationView);
    }];
    [self setBackViewWithView:navigationView clickBtnWithClickBackBlock:block];
    
}

- (void)setBackViewWithView:(UIView *)navigationView clickBtnWithClickBackBlock:(void (^)())block {
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backButton addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        if (block) {
            block();
        }
    }];
    [backButton sizeToFit];
    // 注意:一定要在按钮内容有尺寸的时候,设置才有效果
    backButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
   // backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [navigationView addSubview:backButton];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(navigationView).offset(ISIPHONEX ? 22 : 10);
        make.left.equalTo(navigationView).offset(0);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
}

+(UIViewController *) findBestViewController:(UIViewController *)vc {
    if (vc.presentedViewController) {
        // Return presented view controller
        return [UIViewController findBestViewController:vc.presentedViewController];
    } else if ([vc isKindOfClass:[UISplitViewController class]]) {
        // Return right hand side
        UISplitViewController *svc = (UISplitViewController *) vc;
        if (svc.viewControllers.count > 0)
            return [UIViewController findBestViewController:svc.viewControllers.lastObject];
        else
            return vc;
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        // Return top view
        UINavigationController *svc = (UINavigationController *) vc;
        if (svc.viewControllers.count > 0)
            return [UIViewController findBestViewController:svc.topViewController];
        else
            return vc;
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        // Return visible view
        UITabBarController *svc = (UITabBarController *) vc;
        if (svc.viewControllers.count > 0)
            return [UIViewController findBestViewController:svc.selectedViewController];
        else
            return vc;
    } else {
        // Unknown view controller type, return last child view controller
        return vc;
    }
}
+(UIViewController *) currentViewController {
    // Find best view controller
    UIViewController *viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [UIViewController findBestViewController:viewController];
}


@end
