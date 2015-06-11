//
//  NSString+Encrypt.h
//
//  Created by Jason on 12-11-14.
//
//

#import <Foundation/Foundation.h>

@interface NSString (Encrypt)

- (NSString *)getSha256String;

- (NSString *)HASH256AndBase64;

-(BOOL)isEmpty;
@end
