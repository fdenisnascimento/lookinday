//
//  PostTableViewCell.h
//  LookInDay
//
//  Created by Denis Nascimento on 6/16/15.
//  Copyright (c) 2015 Denis Nascimento. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DXStarRatingView.h"
#import "BaseTableViewCell.h"
#import "FIRPost.h"




@interface EnquetesTableViewCell : BaseTableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imageCapa1;
@property (strong, nonatomic) IBOutlet UIImageView *imageCapa2;
@property (strong, nonatomic) IBOutlet UIImageView *imageThumb;
@property (strong, nonatomic) IBOutlet UILabel *labelContent;
@property (strong, nonatomic) IBOutlet UILabel *labelName;
@property (strong, nonatomic) IBOutlet UILabel *labelOu;
@property (strong, nonatomic) IBOutlet UIView *viewDegrader,*viewBorder;
@property (strong, nonatomic) IBOutlet UIButton *btnFavorito1;
@property (strong, nonatomic) IBOutlet UIButton *btnFavorito2;
@property (strong, nonatomic) IBOutlet UIView *viewScoreLeft;
@property (strong, nonatomic) IBOutlet UIView *viewScoreRight;
@property (strong, nonatomic) IBOutlet UILabel *labelScoreLeft;
@property (strong, nonatomic) IBOutlet UILabel *labelScoreRight;

- (IBAction)sendLike:(UIButton *)sender;

- (void)updateContentCell:(FIRPost*)post;

@end
