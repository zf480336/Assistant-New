//
//  MD5.m
//  Assistant
//
//  Created by lxy on 2018/11/26.
//  Copyright © 2018年 lxy. All rights reserved.
//

#import "MD5.h"

@implementation MD5

//MD5加密
+ (NSString *)stringWithMd5:(NSString *)st {

    MD5Util *md5util = [MD5Util new];

    return  [md5util md5:st];
}

@end
