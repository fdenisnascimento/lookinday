//
//  PostTableViewCell.h
//  LookInDay
//
//  Created by Denis Nascimento on 6/16/15.
//  Copyright (c) 2015 Denis Nascimento. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DXStarRatingView.h"


#import <SDWebImage/UIImageView+WebCache.h>
#import "BaseTableViewCell.h"


@interface DicasTableViewCell : BaseTableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imageCapa;
@property (strong, nonatomic) IBOutlet UIImageView *imageThumb;

@property (strong, nonatomic) IBOutlet UILabel *labelName;
@property (strong, nonatomic) IBOutlet UILabel *labelContent;
@property (strong, nonatomic) IBOutlet UIView *viewDegrader,*viewBorder;


- (void)updateContentCell:(FIRPost*)post;

@end
