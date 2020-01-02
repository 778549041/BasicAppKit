//
//  BaseCollectionViewCell.m
//  BasicAppKit
//
//  Created by xujun on 2019/8/9.
//  Copyright © 2019 xujun. All rights reserved.
//

#import "BaseCollectionViewCell.h"

@implementation BaseCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

/**
*  功能:获取cell的唯一标识符
*/
+ (NSString *)cellReuseIdentifier {
    return NSStringFromClass([self class]);
}

/**
*  功能:获取cell对应的xib
*/
+ (UINib *)nib {
    NSString *className = NSStringFromClass([self class]);
    return [UINib nibWithNibName:className bundle:nil];
}

/// cell高度，子类需重写，计算根据内容计算出cell高度
/// @param data cell数据
+ (CGFloat)heightForCell:(id)data {
    return 0;
}

/// 传入数据，渲染cell
/// @param data cell数据
- (void)updateCellWithData:(id)data {
    
}

/**
 *    功能:cell根据数据和位置显示ui
 *
 *    @param data cell数据
 *    @param indexPath cell位置
 */
- (void)updateWithCellData:(id)data atIndexPath:(NSIndexPath *)indexPath {
    
}

/**
 *    功能:cell根据数据和位置显示ui
 *
 *    @param data cell数据
 *    @param extraData 附加数据
 *    @param indexPath cell位置
 */
- (void)updateWithCellData:(id)data extrData:(id)extraData atIndexPath:(NSIndexPath *)indexPath {
    
}

@end
