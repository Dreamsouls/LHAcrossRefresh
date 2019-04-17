//
//  LHARefreshAutoFooter.h

//
//  Created by Dreamsoul on 2018/4/3.
//  Copyright © 2018年 Dreamsoul. All rights reserved.
//

#import "LHARefreshFooter.h"

@interface LHARefreshAutoFooter : LHARefreshFooter

@property (nonatomic, assign, getter=isAutomaticallyRefresh) BOOL automaticallyRefresh;
@property (nonatomic, weak, readonly) UIActivityIndicatorView *activityView;/**< 小菊花*/
@property (nonatomic, assign) UIActivityIndicatorViewStyle activityViewStyle;

@end
