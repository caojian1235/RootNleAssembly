//
//  NSString+Extra.h
//  CashierChoke
//
//  Created by zjs on 2019/9/16.
//  Copyright © 2019 zjs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

static NSString  *const XCColorKey = @"color";
static NSString  *const XCFontKey = @"font";
static NSString  *const XCRangeKey = @"range";

/**
 * @brief range的校验结果
 */
typedef enum
{
    RangeCorrect = 0,
    RangeError = 1,
    RangeOut = 2,
    
}RangeFormatType;

@interface NSString (Extra)


-(BOOL)isAllKongGe;//判断是不是全是空格
-(BOOL)isContainsJudge;//判断是否包含空格
-(BOOL)isContainsEmoji;//判断是否包含表情
+(CGFloat)ZSZCalculateTheHeightOfTheString:(NSString *)str andFont:(UIFont *)font MaxWidth:(CGFloat)maxWidth;

/** 判断是否是有效的(非空/非空白)字符串 */
- (BOOL)dn_isValidString;

/** 判断是否包含指定字符串 */
- (BOOL)dn_containsString:(NSString *)string;

/* 修剪字符串（去掉头尾两边的空格和换行符）*/
- (NSString *)dn_stringByTrim;

/** md5加密 */
- (nullable NSString *)dn_md5String;

/**
 *  @brief  获取文本的大小
 *
 *  @param  font           文本字体
 *  @param  maxSize        文本区域的最大范围大小
 *  @param  linewdeakMode  字符截断类型
 *
 *  @return 文本大小
 */
- (CGSize)dn_getTextSize:(UIFont *)font
                 maxSize:(CGSize)maxSize
                    mode:(NSLineBreakMode)linewdeakMode;

/**
 *  @brief  获取文本的宽度
 *
 *  @param  font    文本字体
 *  @param  height  文本高度
 *
 *  @return 文本宽度
 */
- (CGFloat)dn_getTextWidth:(UIFont *)font height:(CGFloat)height;

/**
 *  @brief  获取文本的高度
 *
 *  @param  font   文本字体
 *  @param  width  文本宽度
 *
 *  @return 文本高度
 */
- (CGFloat)dn_getTextHeight:(UIFont *)font width:(CGFloat)width;


///==================================================
///             正则表达式
///==================================================

- (BOOL)dn_isPassword ;

/** 判断是否是有效的手机号 */
- (BOOL)dn_isValidPhoneNumber;

/** 判断是否是有效的用户密码 */
- (BOOL)dn_isValidPassword;

- (BOOL)dn_isValidPwdContainNumAndChar;

/** 判断是否是有效的用户名（20位的中文或英文）*/
- (BOOL)dn_isValidUserName;

/** 判断是否是有效的邮箱 */
- (BOOL)dn_isValidEmail;

/** 判断是否是有效的URL */
- (BOOL)isValidUrl;

/** 判断是否是有效的银行卡号 */
- (BOOL)dn_isValidBankNumber;

/** 判断是否是有效的身份证号 */
- (BOOL)dn_isValidIDCardNumber;

/** 判断是否是有效的IP地址 */
- (BOOL)dn_isValidIPAddress;

/** 判断是否是纯汉字 */
- (BOOL)dn_isValidChinese;

/** 判断是否是邮政编码 */
- (BOOL)dn_isValidPostalcode;

/** 判断是否是工商税号 */
- (BOOL)dn_isValidTaxNo;

/** 判断是否是车牌号 */
- (BOOL)dn_isCarNumber;

/** 通过身份证获取性别（1:男, 2:女） */
- (nullable NSNumber *)dn_getGenderFromIDCard;

/** 银行卡密文显示 */
- (NSString *)dn_secretBankCardNumber;

/** 隐藏证件号指定位数字（如：360723********6341） */
- (nullable NSString *)dn_hideCharacters:(NSUInteger)location length:(NSUInteger)length;
//判断是不是纯阿拉伯数字
+ (BOOL)isNumber:(NSString *)strValue;
#pragma mark - 改变单个范围字体的大小和颜色
/**
 *  @brief 改变字体的颜色
 *
 *  @param color 颜色（UIColor）
 *  @param range 范围（NSRange）
 *
 *  @return 转换后的富文本（NSMutableAttributedString）
 */
- (NSMutableAttributedString *)dn_changeColor:(UIColor *)color
                                     andRange:(NSRange)range;


/**
 *  @brief 改变字体大小
 *
 *  @param font  字体大小(UIFont)
 *  @param range 范围(NSRange)
 *
 *  @return 转换后的富文本（NSMutableAttributedString）
 */
- (NSMutableAttributedString *)dn_changeFont:(UIFont *)font
                                    andRange:(NSRange)range;


/**
 *  @brief 改变字体的颜色和大小
 *
 *  @param color      字符串的颜色
 *  @param colorRange 需要改变颜色的字符串范围
 *  @param font       字体大小
 *  @param fontRange  需要改变字体大小的字符串范围
 *
 *  @return 转换后的富文本（NSMutableAttributedString）
 */

- (NSMutableAttributedString *)dn_changeColor:(UIColor *)color
                                 andColorRang:(NSRange)colorRange
                                      andFont:(UIFont *)font
                                 andFontRange:(NSRange)fontRange;


#pragma mark - 改变多个范围内的字体和颜色

/**
 *  @brief 改变多段字符串为一种颜色
 *
 *  @param color  字符串的颜色
 *  @param ranges 范围数组:[NSValue valueWithRange:NSRange]
 *
 *  @return 转换后的富文本（NSMutableAttributedString）
 */
- (NSMutableAttributedString *)dn_changeColor:(UIColor *)color andRanges:(NSArray<NSValue *> *)ranges;

/**
 *  @brief 改变多段字符串为同一大小
 *
 *  @param font   字体大小
 *  @param ranges 范围数组:[NSValue valueWithRange:NSRange]
 *
 *  @return 转换后的富文本（NSMutableAttributedString）
 */
- (NSMutableAttributedString *)dn_changeFont:(UIFont *)font andRanges:(NSArray<NSValue *> *)ranges;
/**
 *  @brief 用于多个位置颜色和大小改变
 *
 *  @param changes 对应属性改变的数组.示例:@[@{XCColorKey:UIColor,XCFontKey:UIFont,XCRangeKey:NSArray<NSValue *>}];
 *
 *  @return 转换后的富文本（NSMutableAttributedString）
 */
- (NSMutableAttributedString *)dn_changeColorAndFont:(NSArray<NSDictionary *> *)changes;

#pragma mark - 给字符串添加中划线
/**
 *  @brief  添加中划线
 *
 *  @return 富文本
 */
- (NSMutableAttributedString *)dn_addCenterLine;

#pragma mark - 给字符串添加下划线
/**
 *  @brief  添加下划线
 *
 *  @return 富文本
 */
- (NSMutableAttributedString *)dn_addDownLine;

#pragma mark - 时间戳转化成时间
+ (NSString *)dn_timeWithTimeIntervalString:(NSString *)timeString;
+ (NSString *)dn_timeWithTimeIntervalString:(NSString *)timeString  setFormat:(NSString * )format;
///字符串时间转化时间戳
+ (long long)timeStrConverToTimeStamp:(NSString *)timeStr;
///十位
+ (NSString *)dn_timeWithTimeIntervalTenString:(NSString *)timeString;
+ (NSString *)dn_timeWithTimeIntervalTenString:(NSString *)timeString  setFormat:(NSString * )format;
- (NSString *)dn_timeWithTimeIntervalString:(NSString *)formatterStr;
+ (long long)getDateTimeTOMilliSeconds:(NSDate *)datetime;

/// @brief 获取日期所在的年月周
/// @param calendarUnit 日历类型
/// @param format 日期格式化器格式
- (NSString *)dn_dateRangeForUnit:(NSCalendarUnit)calendarUnit
                           format:(NSString *)format;

/// 根据出生年月计算年纪
- (NSString *)dn_calculateAgeForDate;

/// 判断字符串中是否存在emoji
- (BOOL)stringContainsEmoji:(NSString *)string;


- (NSDictionary *)dictionaryWithJsonString;



/** 根据图片名 判断是否是gif图 */
- (BOOL)isGifImage;

/** 根据图片data 判断是否是gif图 */
+ (BOOL)isGifWithImageData: (NSData *)data;

/**
 根据image的data 判断图片类型
 
 @param data 图片data
 @return 图片类型(png、jpg...)
 */
+ (NSString *)contentTypeWithImageData: (NSData *)data;


//距离对比
+ (double)distanceBetweenOrderBy:(double)lat1 lng:(double)lng1 lat2:(double)lat2 lng2:(double)lng2;
//判断获取到的字段是否为<null>
+ (BOOL)idTypeIsEqualNull:(id)result;

#pragma mark -加密-
+(NSString *)ZSZhmacSHA256WithSecret:(NSString *)secret content:(NSString *)content;

+(NSString *)HmacSha1:(NSString *)key data:(NSString *)data;

#pragma mark -获取当前时间戳（毫秒单位）-
+(NSString *)ZSZgetNowTimeTimestamp3;

+(NSString *)ZSZrandomStringWithLength:(NSInteger)len;

@end

NS_ASSUME_NONNULL_END
