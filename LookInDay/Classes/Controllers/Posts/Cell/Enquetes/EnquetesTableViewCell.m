//
//  PostTableViewCell.m
//  LookInDay
//
//  Created by Denis Nascimento on 6/16/15.
//  Copyright (c) 2015 Denis Nascimento. All rights reserved.
//

#import "EnquetesTableViewCell.h"
#import "Constants.h"
#import "THSViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "UIViewUtils.h"
#import <SDWebImage/UIImageView+WebCache.h>




@implementation EnquetesTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.imageThumb.layer.cornerRadius = self.imageThumb.frame.size.width/2;
    self.imageThumb.layer.masksToBounds =YES;
    self.labelOu.layer.cornerRadius = self.labelOu.frame.size.width/2;
    self.labelOu.clipsToBounds = YES;
    self.labelOu.font = [UIFont fontWithName:UrbanEleganceBold size:self.labelOu.font.pointSize];
    self.labelScoreLeft.font = [UIFont fontWithName:UrbanEleganceBold size:self.labelScoreLeft.font.pointSize];
    self.labelScoreRight.font = [UIFont fontWithName:UrbanEleganceBold size:self.labelScoreRight.font.pointSize];
    
    
    self.labelName.font = [UIFont fontWithName:UrbanEleganceBold size:self.labelName.font.pointSize];
      self.labelComentarios.font = [UIFont fontWithName:UrbanEleganceBold size:self.labelComentarios.font.pointSize];
    self.labelContent.font = [UIFont fontWithName:UrbanEleganceBold size:self.labelContent.font.pointSize];
    
    
    
    self.viewScoreLeft.layer.cornerRadius = 16.f;
    self.viewScoreLeft.layer.masksToBounds = YES;
    self.viewScoreRight.layer.masksToBounds = YES;
    self.viewScoreRight.layer.cornerRadius = 16.f;
    
    [UIViewUtils addBottomBorderWithColor:[UIColor lightGrayColor] andWidth:0.5 inView:self.viewBorder];
    //self.labelComentarios.hidden = YES;
    
    [Constants insertGradientInView:self.viewDegrader];
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
    

    
    [self.imageCapa1 sd_setImageWithURL:[NSURL URLWithString:post.photo1]
                       placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                              completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                  self.imageCapa1.image = image;
                              }];
    
    [self.imageCapa2 sd_setImageWithURL:[NSURL URLWithString:post.photo2]
                       placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                              completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                  self.imageCapa2.image = image;
                              }];
    
    self.labelScoreLeft.text = self.currentPost.scoreimage1.stringValue;
    self.labelScoreRight.text = self.currentPost.scoreimage2.stringValue;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (IBAction)sendLike:(UIButton *)sender {
    //  self.btnFavorito1.selected = NO;
    //  self.btnFavorito2.selected = NO;
    //  
    //  sender.selected = YES;
}



@end
