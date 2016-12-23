//
//  PostDetalheViewCell.m
//  LookInDay
//
//  Created by Denis Nascimento on 6/26/15.
//  Copyright (c) 2015 Denis Nascimento. All rights reserved.
//

#import "PostDetalheViewCell.h"
#import "Constants.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "FIRComments.h"


@implementation PostDetalheViewCell

- (void)awakeFromNib {
    // Initialization code
  [super awakeFromNib];
  self.imageThumb.layer.cornerRadius =  self.imageThumb.frame.size.height/2;
  self.imageThumb.layer.masksToBounds = YES;
  self.labelName.font = [UIFont fontWithName:UrbanEleganceBold size:self.labelName.font.pointSize];
  self.labelText.font = [UIFont fontWithName:UrbanElegance size:self.labelText.font.pointSize];
  
  self.labelText.preferredMaxLayoutWidth = CGRectGetWidth(self.labelText.frame);

}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)updateContentCell:(FIRComments*)comment
{
  
  //Users  *user = [Users parseModelUserWithParseUser:comment.user];
  
  self.labelName.text = comment.userName;
  self.labelText.text = comment.comment;
  
  UIImage *placeHolder = [UIImage imageNamed:@"placeholder_thumb"];
  
  [self.imageThumb sd_setImageWithURL:[NSURL URLWithString:comment.userPhoto]
                     placeholderImage:placeHolder
                            completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                              self.imageThumb.image = image;
                            }];
  
}

@end
