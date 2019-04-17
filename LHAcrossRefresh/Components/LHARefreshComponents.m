//
//  LHARefreshComponents.m
 
//
//  Created by Dreamsoul on 2018/3/28.
//  Copyright © 2018年 Dreamsoul. All rights reserved.
//

#import "LHARefreshComponents.h"
#import "UIScrollView+LHAExtension.h"
#import "UIView+LHAExtension.h"
#import "LHARefreshConst.h"

@interface LHARefreshComponents()

@property (nonatomic, weak) UIScrollView *scrollView;

@end

@implementation LHARefreshComponents

#pragma mark - initialization

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupComponents];
        self.state = LHARefreshStateNormal;
    }
    return self;
}

- (void)setupComponents {
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.backgroundColor = [UIColor clearColor];
}

#pragma mark - private

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    if (newSuperview && ![newSuperview isKindOfClass:[UIScrollView class]]) return;
    [self removeObservers];
    if (newSuperview) {
        self.scrollView = (UIScrollView *)newSuperview;
        //设置高度
        self.lha_h = self.scrollView.lha_h;
        //设置y
        self.lha_y = - self.scrollView.lha_insetTop;
        self.scrollView.alwaysBounceHorizontal = YES;
        self.scrollViewOriginalInset = self.scrollView.lha_contentInset;
        [self addObservers];
    }
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if (self.state == LHARefreshStateWillRefresh) {
        // 预防view还没显示出来就调用了beginRefreshing
        self.state = LHARefreshStateRefreshing;
    }
}

- (void)layoutSubviews {
    [self setupComponentsFrame];
    [super layoutSubviews];
}

- (void)removeObservers {
    [self.superview removeObserver:self forKeyPath:YZHKContentOffset];
    [self.superview removeObserver:self forKeyPath:YZHKContentSize];
}

- (void)addObservers {
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [self.scrollView addObserver:self forKeyPath:YZHKContentOffset options:options context:nil];
    [self.scrollView addObserver:self forKeyPath:YZHKContentSize options:options context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (!self.userInteractionEnabled) return;
    if ([keyPath isEqualToString:YZHKContentSize]) [self scrollViewContentSizeDidChange:change];
    if (self.hidden) return;
    if ([keyPath isEqualToString:YZHKContentOffset]) [self scrollViewContentOffsetDidChange:change];
}

#pragma mark - public

- (void)setupComponentsFrame {}
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change{}
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change{}

- (void)beginRefresh {
    [UIView animateWithDuration:LHARefreshAnimationDuration animations:^{
        self.alpha = 1.0;
    }];
    self.pullPercent = 1.0;
    
    if (self.window) {
        self.state = LHARefreshStateRefreshing;
    } else {
        if (self.state != LHARefreshStateRefreshing) {
            self.state = LHARefreshStateWillRefresh;
            [self setNeedsDisplay];
        }
    }
}

- (void)beginRefreshWithHandler:(LHARefreshComponentsBeginRefreshHandler)handler {
    self.beginRefreshHandler = handler;
    [self beginRefresh];
}

- (void)endRefresh {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.state = LHARefreshStateNormal;
    });
}

- (void)endRefreshWithHandler:(LHARefreshComponentsEndRefreshHandler)handler {
    self.endRefreshHandler = handler;
    [self endRefresh];
}

#pragma mark - setter

- (void)setState:(LHARefreshState)state {
    _state = state;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setNeedsLayout];
    });
}

- (void)setPullPercent:(CGFloat)pullPercent {
    _pullPercent = pullPercent;
    if (self.isRefreshing) return;
    self.alpha = !self.isAutomaticallyChangeAlpha ?: pullPercent;
}

- (void)setAutomaticallyChangeAlpha:(BOOL)automaticallyChangeAlpha {
    _automaticallyChangeAlpha = automaticallyChangeAlpha;
    if (self.isRefreshing) return;
    self.alpha = automaticallyChangeAlpha ? self.pullPercent : 1.0f;
}

#pragma mark - getter

- (BOOL)isRefreshing {
    return self.state == LHARefreshStateRefreshing || self.state == LHARefreshStateWillRefresh;
}

@end
