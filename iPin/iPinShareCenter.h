//
//  iPinShareCenter.h
//  iPin
//
//  Created by 刘亦辰 on 14-6-16.
//  Copyright (c) 2014年 ___iPinStudio___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"
#define weChatAppId        @"wx73a779afcf9f37a4"
#define weChatAppKey       @"ee0278f98e208b879e25924874d6b865"

@interface iPinShareCenter : NSObject<WXApiDelegate>

+ (iPinShareCenter *) sharedInstance;
- (void)registerApp;
- (BOOL)handleOpenURL:(NSURL *)url;
- (void)weChatShare;
- (void)weChatFriendsShare;
- (void)weChatFavoriteShare;
@end
