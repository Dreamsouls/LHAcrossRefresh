//
//  LHARefreshHeader.h
 
//
//  Created by Dreamsoul on 2018/4/2.
//  Copyright © 2018年 Youzan. All rights reserved.
//

#import "LHARefreshComponents.h"

@interface LHARefreshHeader : LHARefreshComponents

@property (nonatomic, assign) CGFloat ignoredScrollViewContentInsetLeft;/**< 忽略contentInset-left的值*/

+ (instancetype)headerWithRefreshingHandler:(LHARefreshComponentsRefreshingHandler)refreshingHandler;

@end
