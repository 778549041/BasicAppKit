//
//  BaseTableViewCell.m
//  BasicAppKit
//
//  Created by xujun on 2019/8/9.
//  Copyright © 2019 xujun. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setLineType:(SeperatorLineType)lineType {
    if (lineType == SeperatorLineTypeUp) {
        
    } else if (lineType == SeperatorLineTypeDown) {
        
    } else if (lineType == SeperatorLineTypeBothUpAndDown) {
        
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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

@end
