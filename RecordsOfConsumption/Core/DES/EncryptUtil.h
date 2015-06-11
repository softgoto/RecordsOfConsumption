//
//  EncryptUtil.h
//  desTest
//
//  Created by zheng on 14/11/28.
//  Copyright (c) 2014年 zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EncryptUtil :NSObject


+(NSString *) desKeyFromKey:(NSString *)key;

+(NSString *) encrypt:(NSString *)plainText desKey:(NSString *)desKey;

+(NSString *)decrypt:(NSString *)cipherText desKey:(NSString *)desKey;



@end
