//
//  iPinListTableViewCell.h
//  iPin
//
//  Created by 刘亦辰 on 14-6-11.
//  Copyright (c) 2014年 ___iPinStudio___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iPinListItem.h"
@interface iPinListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *backImage;
@property (weak, nonatomic) IBOutlet UILabel *fromPlace;
@property (weak, nonatomic) IBOutlet UILabel *toPlace;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *seats;

- (void)changeSex;
- (void)setItem:(iPinListItem *)item;
@end
