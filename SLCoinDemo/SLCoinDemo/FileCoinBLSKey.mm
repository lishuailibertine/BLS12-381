//
//  FileCoinBLSKey.m
//  SLCoinDemo
//
//  Created by li shuai on 2020/5/8.
//  Copyright © 2020 li shuai. All rights reserved.
//

#import "FileCoinBLSKey.h"
#import <bls-signatures-pod/bls.hpp>

@interface FileCoinBLSKey()
@property (nonatomic, strong,readwrite) NSData *blsPrivateData;
@property (nonatomic, strong,readwrite) NSData *blsPublicData;
@end

@implementation FileCoinBLSKey

+ (instancetype)createFileCoinBLSKeyWithSeed:(NSData *)seed{
    FileCoinBLSKey *BLSKey =[[FileCoinBLSKey alloc] init];
    bls::PrivateKey privateKey = bls::PrivateKey::FromSeed((uint8_t *)seed.bytes, seed.length);
    bls::PublicKey publicKey = privateKey.GetPublicKey();
    uint8_t skBytes[bls::PrivateKey::PRIVATE_KEY_SIZE];  // 32 byte array
    uint8_t pkBytes[bls::PublicKey::PUBLIC_KEY_SIZE];    // 48 byte array
    privateKey.Serialize(skBytes);   // 32 bytes
    publicKey.Serialize(pkBytes);   // 48 bytes
    NSData *privateData = [NSData dataWithBytes:skBytes length:bls::PrivateKey::PRIVATE_KEY_SIZE];
    NSData *publicData = [NSData dataWithBytes:pkBytes length:bls::PublicKey::PUBLIC_KEY_SIZE];
    BLSKey.blsPrivateData =privateData;
    BLSKey.blsPublicData =publicData;
    return BLSKey;
}
+ (instancetype)createFileCoinBLSKeyWithPrivateData:(NSMutableData *)privateKey{
    FileCoinBLSKey *BLSKey =[[FileCoinBLSKey alloc] init];
    uint8_t pkBytes[bls::PublicKey::PUBLIC_KEY_SIZE];    // 48 byte array
    bls::PrivateKey sk = bls::PrivateKey::FromBytes((const uint8_t *)privateKey.mutableBytes);
    bls::PublicKey publicKey = sk.GetPublicKey();
    publicKey.Serialize(pkBytes);   // 48 bytes
    NSData *publicData = [NSData dataWithBytes:pkBytes length:bls::PublicKey::PUBLIC_KEY_SIZE];
    BLSKey.blsPrivateData =privateKey;
    BLSKey.blsPublicData =publicData;
    return BLSKey;
}
- (NSData *)signWithMessage:(NSData *)messageData{
    uint8_t skBytes[bls::PrivateKey::PRIVATE_KEY_SIZE];  // 32 byte array
    [self.blsPrivateData getBytes:skBytes length:bls::PrivateKey::PRIVATE_KEY_SIZE];
    bls::PrivateKey sk = bls::PrivateKey::FromBytes(skBytes);
 
    //message
    //签名过的长度为96个字节
    uint8_t sigBytes[bls::Signature::SIGNATURE_SIZE];    // 96 byte array
    uint8_t messageBytes[messageData.length];
    [messageData getBytes:messageBytes length:messageData.length];
    bls::Signature sig = sk.Sign(messageBytes, sizeof(messageBytes));
    sig.Serialize(sigBytes); // 96 bytes
    NSData *returnMessageData =[NSData dataWithBytes:skBytes length:bls::Signature::SIGNATURE_SIZE];
    return returnMessageData;
}
@end
