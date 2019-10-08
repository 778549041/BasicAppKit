//
//  BaseSearchViewController.m
//  VEC_customer
//
//  Created by xujun on 2019/8/28.
//  Copyright © 2019 VMCSHOP. All rights reserved.
//

#import "BaseSearchViewController.h"

@interface BaseSearchViewController ()<UISearchBarDelegate>

@end

@implementation BaseSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (instancetype)initWithSearchResultsController:(UIViewController *)searchResultsController WithSearchBarDelegate:(BOOL)isDelegate{
    if (self = [super initWithSearchResultsController:searchResultsController]) {
        [self configSearchBar];
        if (isDelegate) {
            self.searchBar.delegate = self;
        }
    }
    return self;
}

- (void)configSearchBar{
    self.dimsBackgroundDuringPresentation = NO;
    self.hidesNavigationBarDuringPresentation = NO;
    self.definesPresentationContext = YES;
    self.extendedLayoutIncludesOpaqueBars  = YES;
    self.searchBar.tintColor = [UIColor whiteColor];
    self.searchBar.backgroundColor = [UIColor whiteColor];
    if (isLessIOS9) self.searchBar.frame = CGRectMake(0, 0, Main_Screen_Width, 50);
    [self.searchBar setValue:@"取消" forKey:@"_cancelButtonText"];
    UITextField *searchField = [self.searchBar valueForKey:@"_searchField"]; // 先取出textfield
    searchField.backgroundColor = HEXCOLOR(0xEEEEEE);
    [[[self.searchBar.subviews.firstObject subviews] firstObject] removeFromSuperview];
}

- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    return ![text isEqualToString:@" "];
}

@end
