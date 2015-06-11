//
//  NSString+Format.h
//
//
//  Created by xuhui on 13-11-6.
//
//

#import <Foundation/Foundation.h>

@interface NSString (Format)

- (BOOL)isDecimal;

-(BOOL)isValidateEmail;
-(BOOL)isMobileNumber;
-(BOOL)isPhoneNum;

#pragma mark -- 获取系统当前时间的字符串格式 格式例如yyyy-MM-dd HH:mm:ss:SSS
+ (NSString *)stringDateByFormatString:(NSString *)formatString;

- (NSString *)formatedTime;

@end
