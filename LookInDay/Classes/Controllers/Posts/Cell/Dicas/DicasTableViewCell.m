//
//  PostTableViewCell.m
//  LookInDay
//
//  Created by Denis Nascimento on 6/16/15.
//  Copyright (c) 2015 Denis Nascimento. All rights reserved.
//

#import "DicasTableViewCell.h"
#import "Constants.h"
#import "THSViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "UIViewUtils.h"
#import "UIImage+Utilities.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "FIRPost.h"

@implementation DicasTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.imageThumb.layer.cornerRadius = self.imageThumb.frame.size.width/2;
    
    self.imageCapa.tag = 2000;
    
    self.labelName.font = [UIFont fontWithName:UrbanEleganceBold size:self.labelName.font.pointSize];
    self.labelComentarios.font = [UIFont fontWithName:UrbanEleganceBold size:self.labelComentarios.font.pointSize];
    self.labelContent.font = [UIFont fontWithName:UrbanEleganceBold size:self.labelContent.font.pointSize];
    
    
    
    [Constants insertGradientInView:self.viewDegrader];
    
    self.imageCapa.contentMode = UIViewContentModeCenter;
    self.imageCapa.clipsToBounds = YES;
}


-(void)updateContentCell:(FIRPost*)post
{
    
    if (self.isProfile) {
        self.btnDelete.enabled  = YES;
        self.btnDelete.hidden   =  NO;
    }
    
    self.currentPost = post;
    [self checkFavoritos];
    [self checkRatting];
    [self checkCountPost];

    self.labelName.text = post.userName;
    self.labelContent.text = post.descriptionValue;
    
    UIImage *placeHolder = [UIImage imageNamed:@"placeholder_thumb"];
    
    [self.imageThumb sd_setImageWithURL:[NSURL URLWithString:post.userPhoto]
                       placeholderImage:placeHolder
                              completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                  self.imageThumb.image = image;
                              }];
    
    NSString  *pathImageCapa = post.photo1 ;
    [self.imageCapa sd_setImageWithURL:[NSURL URLWithString:pathImageCapa]
                      placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                             completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                 self.imageCapa.image = image;
                             }];
    
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
