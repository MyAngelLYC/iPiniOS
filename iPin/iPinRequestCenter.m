//
//  iPinRequestCenter.m
//  iPin
//
//  Created by 刘亦辰 on 14-7-1.
//  Copyright (c) 2014年 ___iPinStudio___. All rights reserved.
//

#import "iPinRequestCenter.h"

@implementation iPinRequestCenter

static iPinRequestCenter *sharedSingleton = nil;

+ (iPinRequestCenter *) sharedInstance
{
    if (sharedSingleton == nil)
    {
        sharedSingleton = [[iPinRequestCenter alloc] init];
    }
    
    return sharedSingleton;
}

-(NSMutableDictionary *)sendRequest:(NSMutableDictionary *)sendJSON
{
    NSData *postData=[NSJSONSerialization dataWithJSONObject:sendJSON options:NSJSONWritingPrettyPrinted error:nil];
    
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"POST"];
    [request setValue:[NSString stringWithFormat:@"%d",[postData length]] forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSString *cmd=(NSString *)[sendJSON objectForKey:@"cmd"];
    
    if([cmd isEqualToString:@"VersionCheck"])
        [request setURL:[NSURL URLWithString:@"http://203.195.201.242/interface/version.php"]];
    else if([cmd isEqualToString:@"InfoListRefresh"] || [cmd isEqualToString:@"publishInfo"] || [cmd isEqualToString:@"cancleOrder"] || [cmd isEqualToString:@"finishOrder"]|| [cmd isEqualToString:@"searchInfo"]|| [cmd isEqualToString:@"updateInfo"] || [cmd isEqualToString:@"DiscussRefresh"])
        [request setURL:[NSURL URLWithString:@"http://203.195.201.242/interface/info.php"]];
    else if([cmd isEqualToString:@"SetUsername"] || [cmd isEqualToString:@"SetAdvice"] || [cmd isEqualToString:@"SetPassword"] || [cmd isEqualToString:@"SetTelephone"])
        [request setURL:[NSURL URLWithString:@"http://203.195.201.242/interface/setting.php"]];
    else if([cmd isEqualToString:@"Auth"] || [cmd isEqualToString:@"AuthRefresh"]|| [cmd isEqualToString:@"userLogin"] || [cmd isEqualToString:@"userRegister"])
        [request setURL:[NSURL URLWithString:@"http://203.195.201.242/interface/user.php"]];
    else if([cmd isEqualToString:@"clearLocation"] || [cmd isEqualToString:@"nearbyRefresh"])
        [request setURL:[NSURL URLWithString:@"http://203.195.201.242/interface/nearby.php"]];
    
    
    NSData *backData=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if(backData!=nil)
        return [NSJSONSerialization JSONObjectWithData:backData options:NSJSONReadingMutableContainers error:nil];
    else
        return nil;
}
@end
