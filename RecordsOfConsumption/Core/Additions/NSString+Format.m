//
//  NSString+Format.m
//
//
//  Created by xuhui on 13-11-6.
//
//

#import "NSString+Format.h"

@implementation NSString (Format)

- (BOOL)isDecimal
{
    if (self.length<=0) {
        return NO;
    }
    NSString *numberRegex = @"^[1-9]+(\\.[0-9]{2})?$";
    NSPredicate *numberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberRegex];
    return [numberTest evaluateWithObject:self];
}

-(BOOL)isValidateEmail {
//    if(!TTIsStringWithAnyText(self)) {
//        return NO;
//    }
    if (self.length<=0) {
        return NO;
    }
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

-(BOOL)isMobileNumber {
    
    /**
     
     *
     手机号码
     
     *
     移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     
     *
     联通：130,131,132,152,155,156,185,186
     
     *
     电信：133,1349,153,180,189
     
     */
    
    NSString*
    MOBILE=
    @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    
    /**
     *
     中国移动：China Mobile
     
     *
     134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     
     */
    
    //    NSString*
    //    CM=
    //    @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    //
    //    /**
    //
    //     *
    //     中国联通：China Unicom
    //
    //     *
    //     130,131,132,152,155,156,185,186
    //
    //     */
    //
    //    NSString*
    //    CU=
    //    @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    //
    //    /**
    //
    //     *
    //     中国电信：China Telecom
    //
    //     *
    //     133,1349,153,180,189
    //
    //     */
    //
    //    NSString*
    //    CT=
    //    @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    
    NSPredicate* regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    if(([regextestmobile evaluateWithObject:self] == YES))
        
    {
        return YES;
    }
    else
        
    {
        return NO;
    }
    
}

-(BOOL)isPhoneNum {
    /**
     
     *
     大陆地区固话及小灵通
     
     *
     区号：010,020,021,022,023,024,025,027,028,029
     
     *
     号码：七位或八位
     
     */
    
    //
    NSString * PHS = @"^(0(10|2[0-5789]|\\d{3})){0,4}-?\\d{7,8}$";
    NSPredicate* regextestphone = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    return [regextestphone evaluateWithObject:self];
}

#pragma mark -- 获取系统当前时间的字符串格式 格式例如yyyy-MM-dd HH:mm:ss:SSS
+ (NSString *)stringDateByFormatString:(NSString *)formatString {
    NSDateFormatter * dateFromatter=[[NSDateFormatter alloc] init];
    [dateFromatter setTimeStyle:NSDateFormatterShortStyle];
    if(formatString!=nil) {
        [dateFromatter setDateFormat:formatString];
    }
    NSString * strDate=[dateFromatter stringFromDate:[NSDate date]];
    return strDate;
}


- (NSString *)formatedTime {
    NSString* time = nil;
    if (self.length<=0) {
        return time;
    }
    
    NSTimeZone* GTMzone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:GTMzone];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSTimeInterval timeZoneOffset = [[NSTimeZone systemTimeZone] secondsFromGMTForDate:[NSDate date]];
    NSDate *today = [[NSDate date] dateByAddingTimeInterval:timeZoneOffset];
    NSDate* theDate = [formatter dateFromString:self];
    
    NSDateFormatter* formatter2 = [[NSDateFormatter alloc] init];
    [formatter2 setTimeZone:GTMzone];
    [formatter2 setDateFormat:@"yyyy-MM-dd"];
    
    if ([[formatter2 stringFromDate:today] isEqualToString:[formatter2 stringFromDate:theDate]]) {
        NSTimeInterval seconds = - [theDate timeIntervalSinceDate:today];
        if(seconds > 3600) { // > 1小时
            time = [[NSString alloc] initWithFormat:@"%d小时前", (int)(seconds / 3600)];
        } else if(seconds > 60) { // > 1分钟
            time = [[NSString alloc] initWithFormat:@"%d分钟前", (int)(seconds / 60)];
        } else if(seconds > 1) { // > 1秒
            time = [[NSString alloc] initWithFormat:@"%d秒前", (int)(seconds)];
        } else {
            //时间为负，服务器时间跟本地不一致 设置为刚刚
            time = @"刚刚";
        }
    }
    else
    {
        time = [formatter2 stringFromDate:theDate];
    }
    return time;
}

@end
