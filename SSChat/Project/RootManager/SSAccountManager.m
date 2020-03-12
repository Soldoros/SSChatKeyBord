//
//  SSAccountManager.m
//  SSChat
//
//  Created by soldoros on 2019/5/17.
//  Copyright © 2019 soldoros. All rights reserved.
//

#import "SSAccountManager.h"
#import "SSDocumentManager.h"

static  NSString *Model_account   = @"account";
static  NSString *Model_password  = @"password";

static  NSString *Model_token     = @"token";
static  NSString *Model_userId    = @"userId";
static  NSString *Model_headerImg = @"headerImg";
static  NSString *Model_nickName  = @"nickName";
static  NSString *Model_mobile    = @"mobile";


@implementation SSAccountModel : NSObject

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)aDecoder {
    
    if(self = [super init]){
        _account   = [aDecoder decodeObjectForKey:Model_account];
        _password  = [aDecoder decodeObjectForKey:Model_password];
        
        _token     = [aDecoder decodeObjectForKey:Model_token];
        _userId    = [aDecoder decodeObjectForKey:Model_userId];
        _headerImg = [aDecoder decodeObjectForKey:Model_headerImg];
        _nickName  = [aDecoder decodeObjectForKey:Model_nickName];
        _mobile    = [aDecoder decodeObjectForKey:Model_mobile];
    }
    return self;
}

- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {

    [aCoder encodeObject:_account  forKey:Model_account];
    [aCoder encodeObject:_password forKey:Model_password];
    
    [aCoder encodeObject:_token forKey:Model_token];
    [aCoder encodeObject:_userId forKey:Model_userId];
    [aCoder encodeObject:_headerImg forKey:Model_headerImg];
    [aCoder encodeObject:_nickName forKey:Model_nickName];
    [aCoder encodeObject:_mobile forKey:Model_mobile];
}

@end


@implementation SSAccountManager

static SSAccountManager *account = nil;

+(instancetype)shareManager{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        account = [[SSAccountManager alloc] init];
    });
    return account;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _filePath  = [[SSDocumentManager getAPPDocumentPath] stringByAppendingPathComponent:@"account_login_data"];
        [self readLocalDatas];
    }
    return self;
}

-(void)readLocalDatas{
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:_filePath]){
        id object = [NSKeyedUnarchiver  unarchiveObjectWithFile:_filePath];
        _model = [object isKindOfClass:[SSAccountModel class]] ? object : nil;
    }
}

-(void)setModel:(SSAccountModel *)model{
    _model = model;
    [self saveLocalDatas];
}


-(void)saveLocalDatas{
    [NSKeyedArchiver archiveRootObject:_model toFile:_filePath];
}


@end
