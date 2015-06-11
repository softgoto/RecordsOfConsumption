//
//  EncryptUtil.m
//  desTest
//
//  Created by zheng on 14/11/28.
//  Copyright (c) 2014年 zheng. All rights reserved.
//

#import "EncryptUtil.h"
#import "GTMBase64.h"
#import <Foundation/Foundation.h>

#import <CommonCrypto/CommonCryptor.h>

@interface EncryptUtil ()


+(NSString *) encryptUseDES:(NSString *)plainText desKey:(NSString *)desKey;

+(NSString *) decryptUseDES:(NSString *)cipherText desKey:(NSString *)desKey;

+(NSString *) stringFromHexString:(NSString *)hexString;

+(NSString *) hexStringFromString:(NSString *)string;

@end

@implementation EncryptUtil


const Byte iv[] = {1,2,3,4,5,6,7,8};

#pragma mark DES加密，测试可以加密长度为3000的明文，如需更大字符串，需要增大buffer
+(NSString *) encryptUseDES:(NSString *)plainText desKey:(NSString *)desKey
{
    NSString *ciphertext = nil;
    NSData *textData = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [textData length];
    unsigned char buffer[4096];
    memset(buffer, 0, sizeof(char));
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          [desKey UTF8String], kCCKeySizeDES,
                                          iv,
                                          [textData bytes], dataLength,
                                          buffer, 4096,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        ciphertext = [GTMBase64 stringByEncodingData:data];
    }
    return ciphertext;
}

#pragma mark DES解密，测试可以解密长度为10000的密文，如需更大字符串，需要增大buffer
+(NSString *)decryptUseDES:(NSString *)cipherText desKey:(NSString *)desKey
{
    NSString *plaintext = nil;
    NSData *cipherdata = [GTMBase64 decodeString:cipherText];
    unsigned char buffer[4096];
    memset(buffer, 0, sizeof(char));
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          [desKey UTF8String], kCCKeySizeDES,
                                          iv,
                                          [cipherdata bytes], [cipherdata length],
                                          buffer, 4096,
                                          &numBytesDecrypted);
    if(cryptStatus == kCCSuccess) {
        NSData *plaindata = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
        plaintext = [[[NSString alloc]initWithData:plaindata encoding:NSUTF8StringEncoding]autorelease];
    }
    return plaintext;
}


#pragma mark  十六进制转换为普通字符串
+ (NSString *)stringFromHexString:(NSString *)hexString
{
    if(hexString == nil || hexString.length <= 0){
        return @"";
    }
    char *myBuffer = (char *)malloc((int)[hexString length] / 2 + 1);
    bzero(myBuffer, [hexString length] / 2 + 1);
    for (int i = 0; i < [hexString length] - 1; i += 2) {
        unsigned int anInt;
        NSString * hexCharStr = [hexString substringWithRange:NSMakeRange(i, 2)];
        NSScanner * scanner = [[[NSScanner alloc] initWithString:hexCharStr] autorelease];
        [scanner scanHexInt:&anInt];
        myBuffer[i / 2] = (char)anInt;
    }
    NSString *unicodeString = [NSString stringWithCString:myBuffer encoding:4];
    free(myBuffer);
    return unicodeString;
    
    
}

#pragma mark 普通字符串转换为十六进制
+ (NSString *)hexStringFromString:(NSString *)string{
    NSData *myD = [string dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[myD bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[myD length];i++)
        
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        
        if([newHexStr length]==1)
            
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        
        else 
            
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr]; 
    } 
    return hexStr; 
}

#pragma mark 将KeyCode解码成key
+ (NSString *)desKeyFromKey:(NSString *)key{
    NSString *string = [self stringFromHexString:key];
    NSString *decode1 = [[[NSString alloc] initWithData:[GTMBase64 decodeString:string]  encoding:NSUTF8StringEncoding]autorelease];
    NSString *decode2 = [[[NSString alloc] initWithData:[GTMBase64 decodeString:decode1]  encoding:NSUTF8StringEncoding] autorelease];
    return decode2;
}

#pragma mark 加密
+(NSString *) encrypt:(NSString *)plainText desKey:(NSString *)desKey
{
    NSString *ciphertext = [EncryptUtil encryptUseDES:plainText desKey:desKey];
    NSString *hexString = [self hexStringFromString:ciphertext];
    return hexString;
}

#pragma mark 解密
+(NSString *)decrypt:(NSString *)cipherText desKey:(NSString *)desKey
{
    NSString *desCipherText = [EncryptUtil stringFromHexString:cipherText];
    NSString *plaintext = [EncryptUtil decryptUseDES:desCipherText desKey:desKey];
    return plaintext;
}

@end



