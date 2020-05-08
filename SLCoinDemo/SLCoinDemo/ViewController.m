//
//  ViewController.m
//  SLCoinDemo
//
//  Created by li shuai on 2020/4/9.
//  Copyright © 2020 li shuai. All rights reserved.
//

#import "ViewController.h"
#import "SLCoinDemo-Swift.h"
#import "FileCoinAccount.h"
#import "FileCoinECKey.h"
#import "NSString+Base58.h"
#import "FileCoinJsonrpcProvider.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self testFileSign];
}
//fileCoin
- (void)testFileCoin{
    FileCoinAccount *account =[FileCoinAccount randomMnemonicAccount];
    FileCoinECKey *ecKey =[[FileCoinECKey alloc] initWithPriKey:account.privateKey.hexToData];
}
- (void)testToAddress{
    Byte byte[32] = {251,94,160,238,167,133,53,119,240,101,1,22,26,102,137,161,178,105,
        28,22,136,225,18,194,16,166,75,183,102,4,160,164
    };
    NSData *privateData =[NSData dataWithBytes:byte length:32];
    FileCoinECKey *ecKey =[[FileCoinECKey alloc] initWithPriKey:privateData];
    
    Byte publicData[65];
    [ecKey.publicKeyAsData getBytes:&publicData length:65];
    NSLog(@"%@",[FileCoinAddress toBase32Address:ecKey.publicKeyAsData]);
    [self testSign:ecKey];
}
- (void)testGetBalance{
    FileCoinJsonrpcProvider *rpc =[[FileCoinJsonrpcProvider alloc] init];
    [rpc getBalanceWithBalance:@"t1r5m7sguodv6klestmo52wj744vmhsgm3n2ik5di" callback:^(NSError *error, id response) {
        
    }];
}
- (void)testFileSign{
    FileCoinAccount *account =[FileCoinAccount accountWithPrivateKey:@"dda247046ab9d18f461819f1e0fdce7c40172c03e0686dcad0d853de8e7b2561"];
    FileCoinTransaction *transaction =[[FileCoinTransaction alloc] init];
    transaction.fromAddress =@"t1r5m7sguodv6klestmo52wj744vmhsgm3n2ik5di";
    transaction.toAddress =@"t1eksi7z6553elrprm7ply2dq4lk7u5cvaa66m7oa";
    transaction.gasLimit =[BigNumber bigNumberWithInteger:10000];
    transaction.gasPrice =[BigNumber bigNumberWithInteger:1];
    transaction.value =[BigNumber bigNumberWithInteger:1];
    transaction.method =@(0);
    transaction.nonce =@(1);
    transaction.params =@"";
    

    [transaction sign:account];
    NSLog(@"%@",[transaction signedMessage]);
}
- (void)testSign:(FileCoinECKey *)eckey{
    NSString * hexMessage =@"a1";
    NSLog(@"%@",[eckey sign:hexMessage.hexToData]);
}
@end
