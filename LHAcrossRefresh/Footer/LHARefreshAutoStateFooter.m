//
//  LHARefreshAutoStateFooter.m
 
//
//  Created by Dreamsoul on 2018/4/4.
//  Copyright © 2018年 Dreamsoul. All rights reserved.
//

#import "LHARefreshAutoStateFooter.h"
#import "UIView+LHAExtension.h"
#import "LHARefreshConst.h"

@interface LHARefreshAutoStateFooter ()

@property (nonatomic, weak) UILabel *stateLabel;/**< 状态Label*/
@property (nonatomic, strong) NSMutableDictionary <NSNumber *, NSString *> *stateTitleDic;

@end

@implementation LHARefreshAutoStateFooter

#pragma mark - override

- (void)setupComponents {
    [super setupComponents];
    self.lha_w = LHARefreshFooterAutoStateWidth;
    self.labelInsetTop = LHARefreshLabelInsetTop;
    [self setTitle:YZHKAutoFooterNormalText forState:LHARefreshStateNormal];
    [self setTitle:YZHKAutoFooterRefreshingText forState:LHARefreshStateRefreshing];
    [self setTitle:YZHKAutoFooterNoMoreDataText forState:LHARefreshStateNoMoreData];
}

- (void)setupComponentsFrame {
    [super setupComponentsFrame];
    self.stateLabel.frame = CGRectMake(0, 0, self.bounds.size.width, 20);
    // 圈圈
    CGFloat activityCenterX = self.lha_w * 0.5;
    CGFloat activityCenterY = self.lha_h * 0.5;
    if (!self.isRefreshTitleHidden) {
        CGFloat textH = [self.stateLabel.text boundingRectWithSize:CGSizeMake(self.frame.size.width, MAXFLOAT)
                                                           options:NSStringDrawingUsesLineFragmentOrigin
                                                        attributes:@{NSFontAttributeName:self.stateLabel.font}
                                                           context:nil].size.height;
        CGFloat totalH = self.activityView.lha_h + LHARefreshLabelInsetTop + textH;
        activityCenterY = (self.lha_h - totalH + self.activityView.lha_h) * 0.5;
        CGFloat stateLabelCenterY = activityCenterY + (self.activityView.lha_h + self.stateLabel.lha_h) * 0.5 + self.labelInsetTop;
        self.stateLabel.center = CGPointMake(activityCenterX, stateLabelCenterY);
    }
    self.activityView.center = CGPointMake(activityCenterX, activityCenterY);
}

- (void)setState:(LHARefreshState)state {
    LHARefreshState preState = self.state;
    if (preState == state) return;
    [super setState:state];
    
    if (self.isRefreshTitleHidden && state == LHARefreshStateRefreshing) {
        self.stateLabel.text = nil;
    } else {
        self.stateLabel.text = self.stateTitleDic[@(state)];
    }
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change {
    [super scrollViewContentOffsetDidChange:change];
    //避免autoLayout引起的frame问题
    if (self.lha_w == LHARefreshFooterAutoStateWidth && self.lha_h == self.scrollView.lha_h) return;
    self.lha_w = LHARefreshFooterAutoStateWidth;
    self.lha_h = self.scrollView.lha_h;
}

#pragma mark - public

- (void)setTitle:(NSString *)title forState:(LHARefreshState)state {
    if (title == nil) return;
    [self.stateTitleDic setObject:title forKey:@(state)];
    self.stateLabel.text = title;
}

#pragma mark - lazy

- (UILabel *)stateLabel {
    if (nil == _stateLabel) {
        UILabel  *stateLabel = [[UILabel alloc] init];
        stateLabel.font = LHARefreshLabelFont;
        stateLabel.textColor = LHARefreshLabelTextColor;
        stateLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        stateLabel.textAlignment = NSTextAlignmentCenter;
        stateLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_stateLabel = stateLabel];
    }
    return _stateLabel;
}

- (NSMutableDictionary<NSNumber *,NSString *> *)stateTitleDic {
    if (nil == _stateTitleDic) {
        _stateTitleDic = @{}.mutableCopy;
    }
    return _stateTitleDic;
}

@end
