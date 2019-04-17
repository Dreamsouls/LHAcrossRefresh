//
//  LHARefreshConst.h
 
//
//  Created by Dreamsoul on 2018/3/28.
//  Copyright © 2018年 Dreamsoul. All rights reserved.
//

#import <UIKit/UIKit.h>

#define LHARefreshColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define LHARefreshLabelTextColor LHARefreshColor(90, 90, 90)
#define LHARefreshLabelFont [UIFont boldSystemFontOfSize:12.0]

UIKIT_EXTERN const CGFloat LHARefreshAnimationDuration;
UIKIT_EXTERN const CGFloat LHARefreshLabelInsetTop;
UIKIT_EXTERN const CGFloat LHARefreshHeaderWidth;
UIKIT_EXTERN const CGFloat LHARefreshFooterAutoStateWidth;
UIKIT_EXTERN const CGFloat LHARefreshFooterWidth;


UIKIT_EXTERN NSString *const YZHKContentOffset;
UIKIT_EXTERN NSString *const YZHKContentSize;
UIKIT_EXTERN NSString *const YZHKContentInset;

UIKIT_EXTERN NSString *const YZHKAutoFooterNormalText;
UIKIT_EXTERN NSString *const YZHKAutoFooterRefreshingText;
UIKIT_EXTERN NSString *const YZHKAutoFooterNoMoreDataText;
