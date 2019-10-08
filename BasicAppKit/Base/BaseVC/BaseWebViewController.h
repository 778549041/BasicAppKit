//
//  BaseWebViewController.h
//  BasicAppKit
//
//  Created by xujun on 2019/8/9.
//  Copyright © 2019 xujun. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseWebViewController : BaseViewController
@property(nonatomic,strong) NSString *webUrl;
@property(nonatomic,strong) NSString *titleStr;
@end

NS_ASSUME_NONNULL_END
