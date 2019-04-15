//
//  LHARefreshFooter.h
 
//
//  Created by Dreamsoul on 2018/4/2.
//  Copyright © 2018年 Youzan. All rights reserved.
//

#import "LHARefreshComponents.h"

@interface LHARefreshFooter : LHARefreshComponents

@property (nonatomic, assign, getter=isAutomaticallyHidden) BOOL automaticallyHidden;/**< 根据是否有数据进行隐藏，默认是NO*/

+ (instancetype)footerWithRefreshingHandler:(LHARefreshComponentsRefreshingHandler)refreshingHandler;

- (void)endRefreshingWithNoMoreData;/**< 结束刷新并显示没有数据*/
- (void)resetNoMoreData;/**< 重置没有更多的数据*/

@end
