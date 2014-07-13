//
//  iPinListItem.m
//  iPin
//
//  Created by 刘亦辰 on 14-6-12.
//  Copyright (c) 2014年 ___iPinStudio___. All rights reserved.
//

#import "iPinListItem.h"

@implementation iPinListItem

@synthesize GroupID,userID,username,sex,telephone,fromPlace,toPlace,date,detail,seats;

- (iPinListItem*)initWithUsername:(NSString *)Username sex:(NSString *)Sex telephone:(NSString *)Telephone fromPlace:(NSString *)FromPlace toPlace:(NSString *)ToPlace date:(NSString *)Date detail:(NSString *)Detail seats:(NSString *)Seats
{
    self=[super init];
    if(self)
    {
        username=Username;
        sex=Sex;
        telephone=Telephone;
        fromPlace=FromPlace;
        toPlace=ToPlace;
        date=Date;
        detail=Detail;
        seats=Seats;
    }
    return self;
}

@end
