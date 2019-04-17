//
//  LHARefreshFooter.m
 
//
//  Created by Dreamsoul on 2018/4/2.
//  Copyright © 2018年 Dreamsoul. All rights reserved.
//

#import "LHARefreshFooter.h"
#import "UIScrollView+LHAExtension.h"
#import "UIScrollView+LHARefresh.h"
#import "UIView+LHAExtension.h"
#import "LHARefreshConst.h"

@implementation LHARefreshFooter

+ (instancetype)footerWithRefreshingHandler:(LHARefreshComponentsRefreshingHandler)refreshingHandler {
    LHARefreshFooter *footer = [[self alloc] init];
    footer.refreshingHandler = refreshingHandler;
    return footer;
}

#pragma mark - private

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    if (newSuperview) {
        // 监听scrollView数据的变化
        if ([self.scrollView isKindOfClass:[UITableView class]] || [self.scrollView isKindOfClass:[UICollectionView class]]) {
            [self.scrollView setLha_reloadDataHandler:^(NSInteger totalDataCount) {
                if (self.isAutomaticallyHidden) {
                    self.hidden = (totalDataCount == 0);
                }
            }];
        }
    }
}

#pragma mark - override


- (void)setupComponents {
    [super setupComponents];
    self.lha_w = LHARefreshFooterWidth;
    self.automaticallyHidden = NO;
}

#pragma mark - public

- (void)endRefreshingWithNoMoreData {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.state = LHARefreshStateNoMoreData;
    });
}

- (void)resetNoMoreData {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.state = LHARefreshStateNormal;
    });
}

#pragma mark - setter

@end
