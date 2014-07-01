//
//  iPinShareCenter.m
//  iPin
//
//  Created by 刘亦辰 on 14-6-16.
//  Copyright (c) 2014年 ___iPinStudio___. All rights reserved.
//

#import "iPinShareCenter.h"

@implementation iPinShareCenter

static iPinShareCenter *sharedSingleton = nil;

+ (iPinShareCenter *) sharedInstance
{
    if (sharedSingleton == nil)
    {
        sharedSingleton = [[iPinShareCenter alloc] init];
    }
    
    return sharedSingleton;
}

- (void)registerApp
{
    [WXApi registerApp:weChatAppId];
}

- (BOOL)handleOpenURL:(NSURL *)url
{
    return [WXApi handleOpenURL:url delegate:self];
}

- (void)weChatShare
{
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = @"iPin";
    message.description = @"iPin在手，说走就走！iPin拼车，专注校园拼车出行解决方案！";
    [message setThumbImage:[UIImage imageNamed:@"Icon"]];
    
    WXAppExtendObject *ext = [WXAppExtendObject object];
    ext.url = @"http://www.ipinstudio.tk";
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneSession;
    
    [WXApi sendReq:req];

}

- (void)weChatFriendsShare
{
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = @"iPin";
    message.description = @"iPin在手，说走就走！iPin拼车，专注校园拼车出行解决方案！";
    [message setThumbImage:[UIImage imageNamed:@"Icon"]];
    
    WXAppExtendObject *ext = [WXAppExtendObject object];
    ext.url = @"http://www.ipinstudio.tk";
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneTimeline;
    
    [WXApi sendReq:req];
}

- (void)weChatFavoriteShare
{
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = @"iPin";
    message.description = @"iPin在手，说走就走！iPin拼车，专注校园拼车出行解决方案！";
    [message setThumbImage:[UIImage imageNamed:@"Icon"]];
    
    WXAppExtendObject *ext = [WXAppExtendObject object];
    ext.url = @"http://www.ipinstudio.tk";
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneFavorite;
    
    [WXApi sendReq:req];
}

- (void)onReq:(BaseReq *)req
{
    
}

-(void)onResp:(BaseResp *)resp
{
    
}
@end
