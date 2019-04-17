//
//  UIScrollView+LHARefresh.m
 
//
//  Created by Dreamsoul on 2018/4/2.
//  Copyright © 2018年 Dreamsoul. All rights reserved.
//

#import "UIScrollView+LHARefresh.h"
#import "LHARefreshHeader.h"
#import "LHARefreshFooter.h"
#import "LHARefreshConst.h"

#import <objc/runtime.h>

static const char LHARefreshHeaderKey = '\0';
static const char LHARefreshFooterKey = '\0';
static const char LHARefreshReloadDataHandlerKey = '\0';

@implementation UIScrollView (LHARefresh)

#pragma mark - getter and setter

- (void)setLha_header:(LHARefreshHeader *)lha_header {
    if (![self.lha_header isEqual:lha_header]) {
        [self.lha_header removeFromSuperview];
        [self insertSubview:lha_header atIndex:0];
        [self willChangeValueForKey:@"lha_header"];
        objc_setAssociatedObject(self, &LHARefreshHeaderKey,
                                 lha_header, OBJC_ASSOCIATION_ASSIGN);
        [self didChangeValueForKey:@"lha_header"];
    }
}

- (LHARefreshHeader *)lha_header {
    return objc_getAssociatedObject(self, &LHARefreshHeaderKey);
}

- (void)setLha_footer:(LHARefreshFooter *)lha_footer {
    if (![self.lha_footer isEqual:lha_footer]) {
        [self.lha_footer removeFromSuperview];
        [self insertSubview:lha_footer atIndex:0];
        [self willChangeValueForKey:@"lha_footer"];
        objc_setAssociatedObject(self, &LHARefreshFooterKey,
                                 lha_footer, OBJC_ASSOCIATION_ASSIGN);
        [self didChangeValueForKey:@"lha_footer"];
    }
}

- (LHARefreshFooter *)lha_footer {
    return objc_getAssociatedObject(self, &LHARefreshFooterKey);
}

- (void)setLha_reloadDataHandler:(void (^)(NSInteger))lha_reloadDataHandler {
    [self willChangeValueForKey:@"lha_reloadDataHandler"];
    objc_setAssociatedObject(self, &LHARefreshReloadDataHandlerKey,
                             lha_reloadDataHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self didChangeValueForKey:@"lha_reloadDataHandler"];
}

- (void (^)(NSInteger))lha_reloadDataHandler {
    return objc_getAssociatedObject(self, &LHARefreshReloadDataHandlerKey);
}

- (NSInteger)lha_totalDataCount {
    NSInteger totalCount = 0;
    if ([self isKindOfClass:[UITableView class]]) {
        UITableView *tableView = (UITableView *)self;
        for (NSInteger section = 0; section<tableView.numberOfSections; section++) {
            totalCount += [tableView numberOfRowsInSection:section];
        }
    } else if ([self isKindOfClass:[UICollectionView class]]) {
        UICollectionView *collectionView = (UICollectionView *)self;
        for (NSInteger section = 0; section<collectionView.numberOfSections; section++) {
            totalCount += [collectionView numberOfItemsInSection:section];
        }
    }
    return totalCount;
}

- (void)executeReloadDataHandler {
    !self.lha_reloadDataHandler ?: self.lha_reloadDataHandler(self.lha_totalDataCount);
}

@end

@implementation NSObject (LHARefresh)

+ (void)exchangeWithOriginalInstanceMethod:(SEL)originalMethod replaceMethod:(SEL)replaceMethod {
    method_exchangeImplementations(class_getInstanceMethod(self, originalMethod), class_getInstanceMethod(self, replaceMethod));
}

+ (void)exchangeWithOriginalClassMethod:(SEL)originalMethod replaceMethod:(SEL)replaceMethod {
    method_exchangeImplementations(class_getClassMethod(self, originalMethod), class_getClassMethod(self, replaceMethod));
}

@end

@implementation UITableView (LHARefresh)

+ (void)load {
    [self exchangeWithOriginalInstanceMethod:@selector(reloadData) replaceMethod:@selector(lha_reloadData)];
}

- (void)lha_reloadData {
    [self lha_reloadData];
    [self executeReloadDataHandler];
}
@end

@implementation UICollectionView (LHARefresh)

+ (void)load {
    [self exchangeWithOriginalInstanceMethod:@selector(reloadData) replaceMethod:@selector(lha_reloadData)];
}

- (void)lha_reloadData {
    [self lha_reloadData];
    [self executeReloadDataHandler];
}

@end
