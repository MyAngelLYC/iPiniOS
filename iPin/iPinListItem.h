//
//  iPinListItem.h
//  iPin
//
//  Created by 刘亦辰 on 14-6-12.
//  Copyright (c) 2014年 ___iPinStudio___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface iPinListItem : NSObject

@property(nonatomic,strong) NSString *GroupID;
@property(nonatomic,strong) NSString *userID;
@property(nonatomic,strong) NSString *username;
@property(nonatomic,strong) NSString *sex;
@property(nonatomic,strong) NSString *telephone;
@property(nonatomic,strong) NSString *fromPlace;
@property(nonatomic,strong) NSString *toPlace;
@property(nonatomic,strong) NSString *date;
@property(nonatomic,strong) NSString *detail;
@property(nonatomic,strong) NSString *seats;


- (iPinListItem*)initWithUsername:(NSString *)Username sex:(NSString *)Sex telephone:(NSString *)Telephone fromPlace:(NSString *)FromPlace toPlace:(NSString *)ToPlace date:(NSString *)Date detail:(NSString *)Detail seats:(NSString *)Seats;

@end
