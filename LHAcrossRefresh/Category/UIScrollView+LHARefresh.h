//
//  UIScrollView+LHARefresh.h
 
//
//  Created by Dreamsoul on 2018/4/2.
//  Copyright © 2018年 Dreamsoul. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LHARefreshHeader, LHARefreshFooter;

@interface UIScrollView (LHARefresh)

@property (nonatomic, strong) LHARefreshHeader *lha_header;/**< 刷新header*/
@property (nonatomic, strong) LHARefreshFooter *lha_footer;/**< 刷新footer*/

@property (nonatomic, copy) void (^lha_reloadDataHandler)(NSInteger totalDataCount);

- (NSInteger)lha_totalDataCount;

@end
