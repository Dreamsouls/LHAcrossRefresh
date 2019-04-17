//
//  LHARefreshComponents.h
 
//
//  Created by Dreamsoul on 2018/3/28.
//  Copyright © 2018年 Dreamsoul. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

/**
 刷新控件的状态

 - LHARefreshStateNormal: 正常闲置状态
 - LHARefreshStateDragging: 释放可以刷新状态
 - LHARefreshStateRefreshing: 正在刷新状态
 - LHARefreshStateWillRefresh: 即将刷新的状态
 - LHARefreshStateNoMoreData: 没有更多数据状态
 */
typedef NS_ENUM(NSUInteger, LHARefreshState) {
    LHARefreshStateNormal = 1,
    LHARefreshStateReleaseToRefresh = 2,
    LHARefreshStateRefreshing = 3,
    LHARefreshStateWillRefresh = 4,
    LHARefreshStateNoMoreData = 5,
};

typedef void(^LHARefreshComponentsBeginRefreshHandler)(void);/**< 开始加载的回调*/
typedef void(^LHARefreshComponentsRefreshingHandler)(void);/**< 正在加载的回调*/
typedef void(^LHARefreshComponentsEndRefreshHandler)(void);/**< 结束加载的回调*/

@interface LHARefreshComponents : UIView

#pragma mark - 父视图相关
@property (nonatomic, weak, readonly) UIScrollView *scrollView;/**< 父视图scrollView*/
@property (nonatomic, assign) UIEdgeInsets scrollViewOriginalInset;/**< 父视图scrollView原始的original*/

#pragma mark - 子控件相关
@property (nonatomic, assign) CGFloat pullPercent;/**< 下拉百分比*/
@property (nonatomic, assign, getter=isAutomaticallyChangeAlpha) BOOL automaticallyChangeAlpha;/**< 自动改变alpha*/

#pragma mark - 刷新相关
@property (nonatomic, assign) LHARefreshState state;/**< 状态*/

/** 开始刷新Handler*/
@property (nonatomic, copy) LHARefreshComponentsBeginRefreshHandler beginRefreshHandler;
- (void)beginRefresh;
- (void)beginRefreshWithHandler:(LHARefreshComponentsBeginRefreshHandler)handler;

/** 正在刷新的Handler*/
@property (nonatomic, copy) LHARefreshComponentsRefreshingHandler refreshingHandler;
@property (nonatomic, assign, readonly, getter=isRefreshing) BOOL refreshing;/**< 是否正在刷新*/

/** 结束刷新Handler*/
@property (nonatomic, copy) LHARefreshComponentsEndRefreshHandler endRefreshHandler;
- (void)endRefresh;
- (void)endRefreshWithHandler:(LHARefreshComponentsEndRefreshHandler)handler;

#pragma mark - 需要子类自己实现的方法
- (void)setupComponents NS_REQUIRES_SUPER;
- (void)setupComponentsFrame NS_REQUIRES_SUPER;
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change NS_REQUIRES_SUPER;
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change NS_REQUIRES_SUPER;

@end
