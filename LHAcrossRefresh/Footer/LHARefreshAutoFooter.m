//
//  LHARefreshAutoFooter.m
 
//
//  Created by Dreamsoul on 2018/4/3.
//  Copyright © 2018年 Youzan. All rights reserved.
//

#import "LHARefreshAutoFooter.h"
#import "UIScrollView+LHAExtension.h"
#import "UIView+LHAExtension.h"
#import "LHARefreshConst.h"

@interface LHARefreshAutoFooter ()

@property (nonatomic, weak) UIActivityIndicatorView *activityView;/**< 小菊花*/

@end

@implementation LHARefreshAutoFooter

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    if (newSuperview) { // 新的父控件
        if (self.hidden == NO) {
            self.scrollView.lha_insetRight += self.lha_w;
        }
        // 设置位置
        self.lha_x = self.scrollView.lha_contentW;
    } else { // 被移除了
        if (self.hidden == NO) {
            self.scrollView.lha_insetRight -= self.lha_w;
        }
    }
}

- (void)setupComponents {
    [super setupComponents];
    self.automaticallyRefresh = YES;
    self.activityViewStyle = UIActivityIndicatorViewStyleGray;
}

- (void)setupComponentsFrame {
    [super setupComponentsFrame];
    if (self.activityView.constraints.count) return;
    // 圈圈
    CGFloat centerX = self.lha_w * 0.5;
    CGFloat centerY = self.lha_h * 0.5;
    self.activityView.center = CGPointMake(centerX, centerY);
}

- (void)scrollViewContentSizeDidChange:(NSDictionary *)change {
    [super scrollViewContentSizeDidChange:change];
    // 设置位置(避免footer出现在首屏)
    self.lha_x = (self.scrollView.lha_contentW < self.scrollView.lha_w) ? self.scrollView.lha_w : self.scrollView.lha_contentW;
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change {
    [super scrollViewContentOffsetDidChange:change];
    
    if (self.state != LHARefreshStateNormal || !self.automaticallyRefresh || self.lha_x == 0) return;
    
    if (self.scrollView.lha_insetRight + self.scrollView.lha_contentW > self.scrollView.lha_w) { // 内容超过一个屏幕
        if (self.scrollView.lha_offsetX >= self.scrollView.lha_contentW - self.scrollView.lha_w + self.lha_w  + self.scrollView.lha_insetRight - self.lha_w) {
            // 防止手松开时连续调用
            CGPoint old = [change[@"old"] CGPointValue];
            CGPoint new = [change[@"new"] CGPointValue];
            if (new.x <= old.x) return;
            // 当底部刷新控件完全出现时，才刷新
            [self beginRefresh];
        }
    }
    //避免autoLayout引起的frame问题
    if (self.lha_w == LHARefreshFooterWidth && self.lha_h == self.scrollView.lha_h) return;
    self.lha_w = LHARefreshFooterWidth;
    self.lha_h = self.scrollView.lha_h;
}

- (void)setState:(LHARefreshState)state {
    LHARefreshState preState = self.state;
    if (preState == state) return;
    [super setState:state];
    
    if (state == LHARefreshStateRefreshing) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            !self.refreshingHandler ?: self.refreshingHandler();
            !self.beginRefreshHandler ?: self.beginRefreshHandler();
        });
        [self.activityView startAnimating];
    } else if (state == LHARefreshStateNoMoreData || state == LHARefreshStateNormal) {
        [self.activityView stopAnimating];
        if (preState == LHARefreshStateRefreshing) {
            if (self.endRefreshHandler) {
                self.endRefreshHandler();
            }
        }
    }
}

#pragma mark - lazy

- (void)setActivityViewStyle:(UIActivityIndicatorViewStyle)activityViewStyle {
    _activityViewStyle = activityViewStyle;
    self.activityView = nil;
    [self setNeedsLayout];
}

- (void)setHidden:(BOOL)hidden {
    BOOL lastHidden = self.isHidden;
    [super setHidden:hidden];
    if (!lastHidden && hidden) {
        self.state = LHARefreshStateNormal;
        self.scrollView.lha_insetRight -= self.lha_w;
    } else if (lastHidden && !hidden) {
        self.scrollView.lha_insetRight += self.lha_w;
        // 设置位置
        self.lha_x = self.scrollView.lha_contentW;
    }
}

#pragma mark - lazy

- (UIActivityIndicatorView *)activityView {
    if (nil == _activityView) {
        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activityView.hidesWhenStopped = YES;
        [self addSubview:_activityView = activityView];
    }
    return _activityView;
}

@end
