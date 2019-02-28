//
//  YMKJVerificationTools.h
//  ==================注释说明====================
//                      ||
//                      ||
//                      ||
//                     \\//
//                      \/
//                   验证信息类
//  =============================================
//  Created by qinzhongzeng on 16/6/29.
//  Copyright © 2016年 qinzhongzeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YMKJVerificationTools : NSObject
+ (YMKJVerificationTools *)sharedVerificationTools;

/**
 *  验证是否是电话号码
 *
 *  @param mobileNum 电话号码
 *
 *  @return BOOL
 */
+ (BOOL)isMobileNumber:(NSString *)mobileNum;

/**
 *  验证是否是集装箱号
 *
 *  @param Code 集装箱号
 *
 *  @return BOOL
 */
+ (BOOL)isContainerCode:(NSString *)Code;

/**
 *  验证是否是车底号
 *
 *  @param Code 车底号
 *
 *  @return BOOL
 */
+ (BOOL)isCarNo:(NSString *)Code;

/**
 *  验证是否是运单号
 *
 *  @param Code 运单号
 *
 *  @return BOOL
 */
+ (BOOL)isWayBillCode:(NSString *)Code;

/**
 *  验证是否是批次号
 *
 *  @param Code 批次号
 *
 *  @return BOOL
 */
+ (BOOL)isOrderBillCode:(NSString *)Code;

/**
 *  验证是否是车牌号
 *
 *  @param Code 运单号
 *
 *  @return BOOL
 */
+ (BOOL)isLicensePlateNumber:(NSString *)Code;

/**
 *  密码是否有效
 *
 *  @return BOOL
 */
+ (BOOL)isAvailablePassWord:(NSString *)password;

/**
 *  是否为纯数字
 *
 *  @return BOOL
 */
+ (BOOL)isAvailableNumber:(NSString *)str;

/**
 *  是否为数字或者字母
 *
 *  @return BOOL
 */
+ (BOOL)isAvailabLetterAndNumber:(NSString *)str;

/**
 *  是否为汉字或者字母或者数字
 *
 *  @return BOOL
 */
+ (BOOL)isAvailabHasAndLatter:(NSString *)str;

/**
 *  是否为电话号
 *
 *  @return BOOL
 */
+ (BOOL)isAvailablePhoneNumber:(NSString *)PhoneNumber;

/**
 *  验证是否是邮箱
 *
 *  @param email email地址
 *
 *  @return BOOL
 */
+ (BOOL)isAvailableEmail:(NSString *)email;

/**
 *  判断字符串中是否含有中文
 *
 *  @param string 待验证的字符串
 *
 *  @return BOOL
 */
+ (BOOL)isHaveChineseInString:(NSString *)string;

/**
 *  判断字符串中是否含有空格
 *
 *  @param string 待验证的字符串
 *
 *  @return BOOL
 */
+ (BOOL)isHaveSpaceInString:(NSString *)string;

/**
 *  判断身份证号是否合法
 *
 *  @param cardNum 身份证号
 *
 *  @return BOOL
 */
+ (BOOL)checkIdentityCardNum:(NSString*)cardNum;
@end
