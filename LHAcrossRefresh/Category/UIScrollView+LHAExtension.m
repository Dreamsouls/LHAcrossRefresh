//
//  UIScrollView+YZHExtension.m
 
//
//  Created by Dreamsoul on 2018/3/29.
//  Copyright © 2018年 Dreamsoul. All rights reserved.
//

#import "UIScrollView+LHAExtension.h"
#import <Availability.h>

@implementation UIScrollView (LHAExtension)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunguarded-availability-new"

- (UIEdgeInsets)lha_contentInset {
    if ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 11.0) {
        return self.adjustedContentInset;
    }
    return self.contentInset;
//#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_11_0
//    return self.adjustedContentInset;
//#endif
//    return self.contentInset;
}

- (CGFloat)lha_insetTop {
    return self.lha_contentInset.top;
}

- (void)setLha_insetTop:(CGFloat)lha_insetTop {
    UIEdgeInsets inset = self.contentInset;
    inset.top = lha_insetTop;
    self.contentInset = inset;
}

- (CGFloat)lha_insetBottom {
    return self.lha_contentInset.bottom;
}

- (void)setLha_insetBottom:(CGFloat)lha_insetBottom {
    UIEdgeInsets inset = self.contentInset;
    inset.bottom = lha_insetBottom;
    self.contentInset = inset;
}

- (CGFloat)lha_insetLeft {
    return self.lha_contentInset.left;
}

- (void)setLha_insetLeft:(CGFloat)lha_insetLeft {
    UIEdgeInsets inset = self.contentInset;
    inset.left = lha_insetLeft;
    self.contentInset = inset;
}

- (CGFloat)lha_insetRight {
    return self.lha_contentInset.right;
}

- (void)setLha_insetRight:(CGFloat)lha_insetRight {
    UIEdgeInsets inset = self.contentInset;
    inset.right = lha_insetRight;
    self.contentInset = inset;
}

- (CGFloat)lha_offsetX {
    return self.contentOffset.x;
}

- (void)setLha_offsetX:(CGFloat)lha_offsetX {
    CGPoint offset = self.contentOffset;
    offset.x = lha_offsetX;
    self.contentOffset = offset;
}

- (CGFloat)lha_offsetY {
    return self.contentOffset.y;
}

- (void)setLha_offsetY:(CGFloat)lha_offsetY {
    CGPoint offset = self.contentOffset;
    offset.y = lha_offsetY;
    self.contentOffset = offset;
}

- (CGFloat)lha_contentW {
    return self.contentSize.width;
}

- (void)setLha_contentW:(CGFloat)lha_contentW {
    CGSize contentSize = self.contentSize;
    contentSize.width = lha_contentW;
    self.contentSize = contentSize;
}

- (CGFloat)lha_contentH {
    return self.contentSize.height;
}

- (void)setLha_contentH:(CGFloat)lha_contentH {
    CGSize contentSize = self.contentSize;
    contentSize.height = lha_contentH;
    self.contentSize = contentSize;
}

#pragma clang diagnostic pop

@end
