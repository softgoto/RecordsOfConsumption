//
//  Global.m
//  RecordsOfConsumption
//
//  Created by xuhui on 14/11/24.
//  Copyright (c) 2014年 xuhui. All rights reserved.
//

#import "Global.h"


NSString* TTPathForDocumentsResource(NSString* relativePath)
{
    static NSString* documentsPath =nil;
    if (nil == documentsPath) {
        NSArray* dirs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
        documentsPath = [dirs objectAtIndex:0];
    }
    return [documentsPath stringByAppendingPathComponent:relativePath];
}