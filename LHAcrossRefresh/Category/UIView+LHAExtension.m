//
//  UIView+YZHExtension.m
 
//
//  Created by Dreamsoul on 2018/3/29.
//  Copyright © 2018年 Youzan. All rights reserved.
//

#import "UIView+LHAExtension.h"

@implementation UIView (LHAExtension)

- (CGFloat)lha_x {
    return self.frame.origin.x;
}

- (void)setLha_x:(CGFloat)lha_x {
    CGRect frame = self.frame;
    frame.origin.x = lha_x;
    self.frame = frame;
}

- (CGFloat)lha_y {
    return self.frame.origin.y;
}

- (void)setLha_y:(CGFloat)lha_y {
    CGRect frame = self.frame;
    frame.origin.y = lha_y;
    self.frame = frame;
}

- (CGFloat)lha_w {
    return self.frame.size.width;
}

- (void)setLha_w:(CGFloat)lha_w {
    CGRect frame = self.frame;
    frame.size.width = lha_w;
    self.frame = frame;
}

- (CGFloat)lha_h {
    return self.frame.size.height;
}

- (void)setLha_h:(CGFloat)lha_h {
    CGRect frame = self.frame;
    frame.size.height = lha_h;
    self.frame = frame;
}

- (CGSize)lha_size {
    return self.frame.size;
}

- (void)setLha_size:(CGSize)lha_size {
    CGRect frame = self.frame;
    frame.size = lha_size;
    self.frame = frame;
}

- (CGPoint)lha_origin {
    return self.frame.origin;
}

- (void)setLha_origin:(CGPoint)lha_origin {
    CGRect frame = self.frame;
    frame.origin = lha_origin;
    self.frame = frame;
}

@end
