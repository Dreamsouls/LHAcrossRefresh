//
//  LHARefreshAutoStateFooter.h
 
//
//  Created by Dreamsoul on 2018/4/4.
//  Copyright © 2018年 Dreamsoul. All rights reserved.
//

#import "LHARefreshAutoFooter.h"

@interface LHARefreshAutoStateFooter : LHARefreshAutoFooter

@property (nonatomic, assign) CGFloat labelInsetTop;/**< 状态label与菊花的距离*/
@property (nonatomic, weak, readonly) UILabel *stateLabel;/**< 状态Label*/
@property (assign, nonatomic, getter=isRefreshTitleHidden) BOOL refreshTitleHidden;/**< 是否隐藏状态title*/

- (void)setTitle:(NSString *)title forState:(LHARefreshState)state;

@end
