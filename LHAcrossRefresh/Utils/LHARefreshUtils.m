//
//  LHARefreshUtils.m
 
//
//  Created by Dreamsoul on 2018/3/30.
//  Copyright © 2018年 Dreamsoul. All rights reserved.
//

#import "LHARefreshUtils.h"

@implementation LHARefreshUtils

+ (UIImage *)getImageWithName:(NSString *)imageName {
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"LHARefresh" ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    NSString *resourcePath = [bundle pathForResource:imageName ofType:@"png"];
    if (resourcePath.length > 0) {
        return [UIImage imageWithContentsOfFile:resourcePath];
    }
    return nil;
}

@end
