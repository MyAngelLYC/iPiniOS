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
    else if([cmd isEqualToString:@"clearLocation"] || [cmd isEqualToString:@"NearByRefresh"])
        [request setURL:[NSURL URLWithString:@"http://203.195.201.242/interface/nearby.php"]];
    
    
    NSData *backData=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if(backData!=nil)
        return [NSJSONSerialization JSONObjectWithData:backData options:NSJSONReadingMutableContainers error:nil];
    else
        return nil;
}

- (NSString *)md5:(NSString *)str
{
    const char *cStr=[str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result);
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",result[0],result[1],result[2],result[3],result[4],result[5],result[6],result[7],result[8],result[9],result[10],result[11],result[12],result[13],result[14],result[15]];
}
@end
