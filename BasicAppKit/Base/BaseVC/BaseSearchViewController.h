//
//  BaseSearchViewController.h
//  VEC_customer
//
//  Created by xujun on 2019/8/28.
//  Copyright © 2019 VMCSHOP. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseSearchViewController : UISearchController
- (instancetype)initWithSearchResultsController:(UIViewController *)searchResultsController WithSearchBarDelegate:(BOOL)isDelegate;
@end

NS_ASSUME_NONNULL_END
