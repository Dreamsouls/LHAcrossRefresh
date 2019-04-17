//
//  YZHNormalRefreshHeader.m
 
//
//  Created by Dreamsoul on 2018/4/2.
//  Copyright © 2018年 Dreamsoul. All rights reserved.
//

#import "LHANormalRefreshHeader.h"
#import "UIView+LHAExtension.h"
#import "LHARefreshUtils.h"
#import "LHARefreshConst.h"

@interface LHANormalRefreshHeader ()

@property (nonatomic, weak) UIImageView *arrowImageView;/**< 箭头ImageView*/
@property (nonatomic, weak) UIActivityIndicatorView *activityView;/**< 小菊花*/

@end

@implementation LHANormalRefreshHeader

#pragma mark - private

#pragma mark - override

- (void)setupComponents {
    [super setupComponents];
    self.activityViewStyle = UIActivityIndicatorViewStyleGray;
}

- (void)setupComponentsFrame {
    [super setupComponentsFrame];
    CGFloat arrowCenterX = self.lha_w * 0.5;
    CGFloat arrowCenterY = self.lha_h * 0.5;
    CGPoint arrowCenter = CGPointMake(arrowCenterX, arrowCenterY);
    
    if (self.arrowImageView.constraints.count == 0) {
        self.arrowImageView.lha_size = self.arrowImageView.image.size;
        self.arrowImageView.center = arrowCenter;
    }
    if (self.activityView.constraints.count == 0) {
        self.activityView.center = arrowCenter;
    }
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change {
    [super scrollViewContentOffsetDidChange:change];
    //避免autoLayout引起的frame问题
    if (self.lha_w == LHARefreshHeaderWidth && self.lha_h == self.scrollView.lha_h) return;
    self.lha_w = LHARefreshHeaderWidth;
    self.lha_h = self.scrollView.lha_h;
}

#pragma mark - setter
- (void)setState:(LHARefreshState)state {
    LHARefreshState preState = self.state;
    if (preState == state) return;
    [super setState:state];
    
    // 根据状态做事情
    if (state == LHARefreshStateNormal) {
        if (preState == LHARefreshStateRefreshing) {
            self.arrowImageView.transform = CGAffineTransformIdentity;
            
            [UIView animateWithDuration:LHARefreshAnimationDuration animations:^{
                self.activityView.alpha = 0.0;
            } completion:^(BOOL finished) {
                // 如果执行完动画发现不是idle状态，就直接返回，进入其他状态
                if (self.state != LHARefreshStateNormal) return;
                self.activityView.alpha = 1.0;
                [self.activityView stopAnimating];
                self.arrowImageView.hidden = NO;
            }];
        } else {
            [self.activityView stopAnimating];
            self.arrowImageView.hidden = NO;
            [UIView animateWithDuration:LHARefreshAnimationDuration animations:^{
                self.arrowImageView.transform = CGAffineTransformIdentity;
            }];
        }
    } else if (state == LHARefreshStateReleaseToRefresh) {
        [self.activityView stopAnimating];
        self.arrowImageView.hidden = NO;
        [UIView animateWithDuration:LHARefreshAnimationDuration animations:^{
            self.arrowImageView.transform = CGAffineTransformMakeRotation(0.000001 - M_PI);
        }];
    } else if (state == LHARefreshStateRefreshing) {
        self.activityView.alpha = 1.0; // 防止refreshing -> idle的动画完毕动作没有被执行
        [self.activityView startAnimating];
        self.arrowImageView.hidden = YES;
    }
}

- (void)setActivityViewStyle:(UIActivityIndicatorViewStyle)activityViewStyle {
    _activityViewStyle = activityViewStyle;
    self.activityView = nil;
    [self setNeedsLayout];
}

#pragma mark - lazy
- (UIImageView *)arrowImageView {
    if (nil == _arrowImageView) {
        UIImageView *arrowImageView = [[UIImageView alloc] initWithImage:[LHARefreshUtils getImageWithName:@"arrow@2x"]];
        [self addSubview:_arrowImageView = arrowImageView];
    }
    return _arrowImageView;
}

- (UIActivityIndicatorView *)activityView {
    if (nil == _activityView) {
        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activityView.hidesWhenStopped = YES;
        [self addSubview:_activityView = activityView];
    }
    return _activityView;
}

@end
