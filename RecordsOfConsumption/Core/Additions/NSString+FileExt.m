//
//  NSString+FileExt.m
//
//
//  Created by xuhui on 13-11-5.
//
//

#import "NSString+FileExt.h"
//#import "Three20Core/TTGlobalCorePaths.h"

@implementation NSString (FileExt)

- (BOOL)isPhotoExt {
    NSString* fileExt = [self lowercaseString];
    if([fileExt isEqualToString:@"jpg"]
       || [fileExt isEqualToString:@"jpeg"]
       || [fileExt isEqualToString:@"png"]
       || [fileExt isEqualToString:@"gif"]) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)isVideoExt {
    NSString* fileExt = [self lowercaseString];
    if ([fileExt isEqualToString:@"mp4"]) {
        return YES;
    }
    return NO;
}

- (NSString *)mimeType {
    NSString* fileExt = [self lowercaseString];
    if([fileExt isEqualToString:@"doc"]) {
        return @"application/msword";
    } else if([fileExt isEqualToString:@"docx"]) {
        return @"application/vnd.openxmlformats-officedocument.wordprocessingml.document";
    } else if([fileExt isEqualToString:@"xls"]) {
        return @"application/vnd.ms-excel";
    } else if([fileExt isEqualToString:@"xlsx"]) {
        return @"application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
    } else if([fileExt isEqualToString:@"ppt"]) {
        return @"application/vnd.ms-powerpoint";
    } else if([fileExt isEqualToString:@"pptx"]) {
        return @"application/vnd.openxmlformats-officedocument.presentationml.presentation";
    } else if([fileExt isEqualToString:@"pdf"]) {
        return @"application/pdf";
    } else if([fileExt isEqualToString:@"txt"]){
        return @"text/plain";
    }
    // TODO
    return nil;
}

- (NSString *)bundleResourcePath:(NSString*)prefix {
    static const NSDictionary* dict = nil;
    
    dict = [NSDictionary dictionaryWithObjectsAndKeys:
            @"jpg", @"jpg",
            @"jpg", @"jpeg",
            @"doc", @"docx",
            @"doc", @"doc",
            @"ppt", @"pptx",
            @"ppt", @"ppt",
            @"xls", @"xlsx",
            @"xls", @"xls",
            @"zip", @"zip",
            @"exe", @"exe",
            @"bmp", @"bmp",
            @"gif", @"gif",
            @"iso", @"iso",
            @"png", @"png",
            @"mpeg", @"mov",
            @"mpeg", @"mpeg",
            @"msi", @"msi",
            @"mp3", @"mp3",
            @"pdf", @"pdf",
            @"rar", @"rar",
            @"swf", @"swf",
            @"txt", @"txt",
            @"apk", @"apk",
            @"ipa", @"ipa",
            nil];
    
    // TODO may be other's
    
    NSString* fileExt = [self lowercaseString];
    NSString* newFileExt = [dict objectForKey:fileExt];
    if(newFileExt) {
        return [[NSString alloc] initWithFormat:@"%@_%@.png", prefix,newFileExt];
    } else {
        return [[NSString alloc] initWithFormat:@"%@_otherfile.png",prefix];
    }
}

- (NSString *)documentFilePath {
    NSString* fileName = [self uuid];
    NSString* fileNameWithExt = [[NSString alloc] initWithFormat:@"%@.%@", fileName, self];
    return TTPathForDocumentsResource(fileNameWithExt);
}

- (NSString *)uuid {
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    
    CFRelease(uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString*)uuid_string_ref];
    
    CFRelease(uuid_string_ref);
    return uuid;
}

@end
