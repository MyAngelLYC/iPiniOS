//
//  iPinRequestCenter.h
//  iPin
//
//  Created by 刘亦辰 on 14-7-1.
//  Copyright (c) 2014年 ___iPinStudio___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface iPinRequestCenter : NSObject

+ (iPinRequestCenter *)sharedInstance;
- (NSMutableDictionary *)sendRequest:(NSMutableDictionary *)sendJSON;
- (NSString *)md5:(NSString *)str;
@end
