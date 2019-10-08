//
//  UICopyLabel.m
//  EPOS_2.0
//
//  Created by 秦辉 on 2018/3/8.
//  Copyright © 2018年 LCSW. All rights reserved.
//

#import "UICopyLabel.h"

@implementation UICopyLabel

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addTouch];
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self addTouch];
}


- (void)addTouch{
    self.userInteractionEnabled = YES;  //用户交互的总开关
    UILongPressGestureRecognizer *touch = [[UILongPressGestureRecognizer alloc] initWithTarget:self                action:@selector(addgesture:)];
    
    [self addGestureRecognizer:touch];
}

-(void)addgesture:(UILongPressGestureRecognizer*) recognizer{
    
    [self becomeFirstResponder];
    
    UIMenuController *menu = [UIMenuController sharedMenuController];
    
    [menu setTargetRect:self.frame inView:self.superview];
    
    [menu setMenuVisible:YES animated:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuwillHide) name:UIMenuControllerWillHideMenuNotification object:nil];
    self.backgroundColor = HEXCOLOR(0xE6E6E6);
    
}

- (void)menuwillHide{
    self.backgroundColor = [UIColor clearColor];
}

- (BOOL)canBecomeFirstResponder{
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    return (action == @selector(copy:));
}

- (void)copy:(id)sender{
    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
    pboard.string = self.text;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
