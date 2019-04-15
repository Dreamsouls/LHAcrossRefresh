//
//  YZHNormalRefreshHeader.h
 
//
//  Created by Dreamsoul on 2018/4/2.
//  Copyright © 2018年 Youzan. All rights reserved.
//

#import "LHARefreshHeader.h"

@interface LHANormalRefreshHeader : LHARefreshHeader

@property (nonatomic, weak, readonly) UIImageView *arrowImageView;/**< 箭头ImageView*/
@property (nonatomic, assign) UIActivityIndicatorViewStyle activityViewStyle;/**< 小菊花样式*/

@end
