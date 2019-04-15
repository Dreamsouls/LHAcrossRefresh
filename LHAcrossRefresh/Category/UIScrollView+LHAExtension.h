//
//  UIScrollView+YZHExtension.h
 
//
//  Created by Dreamsoul on 2018/3/29.
//  Copyright © 2018年 Youzan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (LHAExtension)

@property (nonatomic, readonly) UIEdgeInsets lha_contentInset;

@property (nonatomic, assign) CGFloat lha_insetTop;
@property (nonatomic, assign) CGFloat lha_insetBottom;
@property (nonatomic, assign) CGFloat lha_insetLeft;
@property (nonatomic, assign) CGFloat lha_insetRight;

@property (nonatomic, assign) CGFloat lha_offsetX;
@property (nonatomic, assign) CGFloat lha_offsetY;

@property (nonatomic, assign) CGFloat lha_contentW;
@property (nonatomic, assign) CGFloat lha_contentH;

@end
