//
//  BaseTableViewCell.h
//  BasicAppKit
//
//  Created by xujun on 2019/8/9.
//  Copyright © 2019 xujun. All rights reserved.
//

typedef enum {
    SeperatorLineTypeUp,
    SeperatorLineTypeDown,
    SeperatorLineTypeBothUpAndDown
}SeperatorLineType;

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseTableViewCell : UITableViewCell

@property (nonatomic, assign) SeperatorLineType lineType;

/// cell高度，子类需重写，计算根据内容计算出cell高度
/// @param data cell数据
+ (CGFloat)heightForCell:(id)data;

/// 传入数据，渲染cell
/// @param data cell数据
- (void)updateCellWithData:(id)data;

@end

NS_ASSUME_NONNULL_END
