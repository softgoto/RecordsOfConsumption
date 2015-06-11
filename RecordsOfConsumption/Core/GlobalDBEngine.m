//
//  GlobalDBEngine.m
//  CRM
//
//  Created by xuhui on 13-12-17.
//  Copyright (c) 2013年 xuhui. All rights reserved.
//

#import "GlobalDBEngine.h"
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import "FMDatabaseQueue.h"
#import "FMResultSet.h"
#import "NSDictionary+Utils.h"


@interface GlobalDBEngine () {
    FMDatabaseQueue* _dbQueue;
}

@end

@implementation GlobalDBEngine

#pragma mark -
#pragma mark NSObject

- (id)init {
    self = [super init];
    if(self) {
        [self commonInit];
    }
    return self;
}

#pragma mark -
#pragma mark Public

+ (GlobalDBEngine *)sharedDB {
    static GlobalDBEngine *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[GlobalDBEngine alloc] init];
    });
    
    return _instance;
}

- (NSString *)uuid {
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    
    CFRelease(uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString*)uuid_string_ref];
    
    CFRelease(uuid_string_ref);
    return uuid;
}



#pragma mark -
#pragma mark Private

- (void)commonInit {
    // create table
    NSString* dbFilePath = TTPathForDocumentsResource(@"xxx.db");
    _dbQueue = [FMDatabaseQueue databaseQueueWithPath:dbFilePath];
    [_dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        db.logsErrors = YES;
        [db setShouldCacheStatements:YES];
    }];
}

@end

