//
//  BaseTableViewCell.m
//  BasicAppKit
//
//  Created by xujun on 2019/8/9.
//  Copyright © 2019 xujun. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface BaseTableViewCell ()

@property (nonatomic, strong) UILabel *lineLblUp;
@property (nonatomic, strong) UILabel *lineLblDown;

@end

@implementation BaseTableViewCell

#pragma mark - lazyinit
- (UILabel *)lineLblUp {
    if (!_lineLblUp) {
        _lineLblUp = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width - 20, 0.5)];
        _lineLblUp.backgroundColor = [UIColor lightGrayColor];
    }
    return _lineLblUp;
}

- (UILabel *)lineLblDown {
    if (!_lineLblDown) {
        _lineLblDown = [[UILabel alloc] initWithFrame:CGRectMake(10, self.frame.size.height - 0.5, self.frame.size.width - 20, 0.5)];
        _lineLblDown.backgroundColor = [UIColor lightGrayColor];
    }
    return _lineLblDown;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
//画分割线
- (void)setLineType:(SeperatorLineType)lineType {
    if (lineType == SeperatorLineTypeUp) {
        [self addSubview:self.lineLblUp];
    } else if (lineType == SeperatorLineTypeDown) {
        [self addSubview:self.lineLblDown];
    } else if (lineType == SeperatorLineTypeBothUpAndDown) {
        [self addSubview:self.lineLblUp];
        [self addSubview:self.lineLblDown];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//获取cell的唯一标识符
+ (NSString *)cellReuseIdentifier {
    return NSStringFromClass([self class]);
}

//获取cell的nib
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
