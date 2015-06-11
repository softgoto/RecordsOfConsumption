//
//  NSString+FileExt.h
//
//
//  Created by xuhui on 13-11-5.
//
//

#import <Foundation/Foundation.h>

@interface NSString (FileExt)

- (BOOL)isPhotoExt;
- (BOOL)isVideoExt;
- (NSString *)mimeType;

- (NSString *)bundleResourcePath:(NSString*)prefix;

- (NSString *)documentFilePath;

@end
