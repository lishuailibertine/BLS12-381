//
//  FileCoinBLSKey.h
//  SLCoinDemo
//
//  Created by li shuai on 2020/5/8.
//  Copyright © 2020 li shuai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileCoinBLSKey : NSObject
@property (nonatomic, strong,readonly) NSData *blsPrivateData;
@property (nonatomic, strong,readonly) NSData *blsPublicData;
//根据seed 生成bls签名对象
+ (uint8_t)uint8FromBytes:(NSData *)fData;
+ (instancetype)createFileCoinBLSKeyWithSeed:(NSData *)seed;
+ (instancetype)createFileCoinBLSKeyWithPrivateData:(NSMutableData *)privateData;
//签名message
- (NSData *)signWithMessage:(NSData *)messageData;
@end
