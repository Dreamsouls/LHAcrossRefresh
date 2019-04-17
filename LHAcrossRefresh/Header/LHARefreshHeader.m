//
//  LHARefreshHeader.m
 
//
//  Created by Dreamsoul on 2018/4/2.
//  Copyright © 2018年 Dreamsoul. All rights reserved.
//

#import "LHARefreshHeader.h"
#import "UIScrollView+LHAExtension.h"
#import "UIView+LHAExtension.h"
#import "LHARefreshConst.h"

@interface LHARefreshHeader ()

@property (nonatomic, assign) CGFloat insetLDelta;

@end

@implementation LHARefreshHeader

+ (instancetype)headerWithRefreshingHandler:(LHARefreshComponentsRefreshingHandler)refreshingHandler {
    LHARefreshHeader *header = [[self alloc] init];
    header.refreshingHandler = refreshingHandler;
    return header;
}

#pragma mark - private

#pragma mark - override

- (void)setupComponents {
    [super setupComponents];
    self.lha_w = LHARefreshHeaderWidth;
}

- (void)setupComponentsFrame {
    [super setupComponentsFrame];
    self.lha_x = - self.lha_w - self.ignoredScrollViewContentInsetLeft;
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change {
    [super scrollViewContentOffsetDidChange:change];
    if (self.state == LHARefreshStateRefreshing) {
        if (self.window == nil) return;
        CGFloat insetLeft = - self.scrollView.lha_offsetX > self.scrollViewOriginalInset.left ? - self.scrollView.lha_offsetX : self.scrollViewOriginalInset.left;
        insetLeft = insetLeft > self.lha_w + self.scrollViewOriginalInset.left ? self.lha_w + self.scrollViewOriginalInset.left : insetLeft;
        self.scrollView.lha_insetLeft = insetLeft;
        self.insetLDelta = self.scrollViewOriginalInset.left - insetLeft;
        return;
    }
    // 跳转到下一个控制器时，contentInset可能会变
    self.scrollViewOriginalInset = self.scrollView.lha_contentInset;
    // 当前的contentOffset
    CGFloat offsetX = self.scrollView.lha_offsetX;
    // 左边控件刚好出现的offsetX
    CGFloat happenOffsetX = - self.scrollViewOriginalInset.left;
    // 如果是向左滚动到看不见header控件，直接返回
    if (offsetX > happenOffsetX) return;
    // 普通 和 即将刷新 的临界点
    CGFloat normal2pullingOffsetX = happenOffsetX - self.lha_w;
    CGFloat pullPercent = (happenOffsetX - offsetX) / self.lha_w;
    //正在拖拽
    if (self.scrollView.isDragging) {
        self.pullPercent = pullPercent;
        if (self.state == LHARefreshStateNormal && offsetX < normal2pullingOffsetX) {
            // 转为即将刷新状态
            self.state = LHARefreshStateReleaseToRefresh;
        } else if (self.state == LHARefreshStateReleaseToRefresh && offsetX >= normal2pullingOffsetX) {
            // 转为普通状态
            self.state = LHARefreshStateNormal;
        }
    } else if (self.state == LHARefreshStateReleaseToRefresh) {// 即将刷新 && 手松开
        // 开始刷新
        [self beginRefresh];
    } else if (pullPercent < 1) {
        self.pullPercent = pullPercent;
    }
}

#pragma mark - setter

- (void)setState:(LHARefreshState)state {
    LHARefreshState preState = self.state;
    if (preState == state) return;
    [super setState:state];
    
    // 根据状态做事情
    if (state == LHARefreshStateNormal) {
        if (preState != LHARefreshStateRefreshing) return;
        // 恢复inset和offset
        [UIView animateWithDuration:LHARefreshAnimationDuration animations:^{
            self.scrollView.lha_insetLeft += self.insetLDelta;
            self.alpha = !self.isAutomaticallyChangeAlpha ?: 0.0;
        } completion:^(BOOL finished) {
            self.pullPercent = 0.0;
            !self.endRefreshHandler ?: self.endRefreshHandler();
        }];
    } else if (state == LHARefreshStateRefreshing) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:LHARefreshAnimationDuration animations:^{
                CGFloat left = self.scrollViewOriginalInset.left + self.lha_w;
                // 增加滚动区域left
                self.scrollView.lha_insetLeft = left;
                // 设置滚动位置
                CGPoint offset = self.scrollView.contentOffset;
                offset.x = -left;
                [self.scrollView setContentOffset:offset animated:NO];
            } completion:^(BOOL finished) {
                !self.refreshingHandler ?: self.refreshingHandler();
                !self.beginRefreshHandler ?: self.beginRefreshHandler();
            }];
        });
    }
}

@end
