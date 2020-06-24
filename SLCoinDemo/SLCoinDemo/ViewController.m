//
//  ViewController.m
//  SLCoinDemo
//
//  Created by li shuai on 2020/4/9.
//  Copyright © 2020 li shuai. All rights reserved.
//

#import "ViewController.h"
#import "FileCoinBLSKey.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self testFileCoin];
}
//fileCoin
- (void)testFileCoin{
    NSString *seedStr = @"543d7c46cbbf5baabc4ab01661faa91a693b2704f667e33585e4d63ba5069e27";
    uint8_t seed[] = {0, 50, 6, 244, 24, 199, 1, 25, 52, 88, 192,
    19, 18, 12, 89, 6, 220, 18, 102, 58, 209,
    82, 12, 62, 89, 110, 182, 9, 44, 20, 254, 22};
    NSMutableData *data =[NSMutableData data];
    for (int i=0; i<sizeof(seed);i++) {
        [data appendBytes:&seed[i] length:1];
    }
    FileCoinBLSKey *blsKey =[FileCoinBLSKey createFileCoinBLSKeyWithPrivateData:[self fromHexString:seedStr]];

    NSLog(@"%@",blsKey.blsPrivateData);
}
- (NSMutableData *)fromHexString:(NSString*)str {
  NSMutableData *data = [NSMutableData new];
  // 处理不是2的倍数
  int len = (int)(str.length);
  if(str.length % 2 != 0){
      len--;
  }
  for (int i = 0; i < len; i+=2) {
      NSString *hexChar = [str substringWithRange:NSMakeRange(i, 2)];
      uint8_t value1 = strtoul([hexChar UTF8String], nil, 16);
      [data appendBytes:&value1 length:sizeof(value1)];
  }
    return data;
}
@end
