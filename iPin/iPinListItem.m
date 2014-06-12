//
//  iPinListItem.m
//  iPin
//
//  Created by 刘亦辰 on 14-6-12.
//  Copyright (c) 2014年 ___iPinStudio___. All rights reserved.
//

#import "iPinListItem.h"

@implementation iPinListItem

@synthesize username,sex,telephone,fromPlace,toPlace,date,detail;

- (iPinListItem*)initWithUsername:(NSString *)Username sex:(NSString *)Sex telephone:(NSString *)Telephone fromPlace:(NSString *)FromPlace toPlace:(NSString *)ToPlace date:(NSString *)Date detail:(NSString *)Detail seats:(NSString *)Seats
{
    self=[super init];
    if(self)
    {
        [self setUsername:Username];
        [self setSex:Sex];
        [self setTelephone:Telephone];
        [self setFromPlace:FromPlace];
        [self setToPlace:ToPlace];
        [self setDate:Date];
        [self setDetail:Detail];
        [self setSeats:Seats];
    }
    return self;
}

@end
