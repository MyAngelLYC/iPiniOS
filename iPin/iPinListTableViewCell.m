//
//  iPinListTableViewCell.m
//  iPin
//
//  Created by 刘亦辰 on 14-6-11.
//  Copyright (c) 2014年 ___iPinStudio___. All rights reserved.
//

#import "iPinListTableViewCell.h"

@implementation iPinListTableViewCell
@synthesize backImage,fromPlace,toPlace,time,username,seats;

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)changeSex
{
    [backImage setImage:[UIImage imageNamed:@"information_frame_female"]];
}

- (void)setItem:(iPinListItem *)item
{
    [fromPlace setText:item.fromPlace];
    [toPlace setText:[item toPlace]];
    [time setText:[item date]];
    [username setText:[item username]];
    [seats setText:[item seats]];
    if([[item sex] isEqual:@"女"]) [self changeSex];
}
@end
