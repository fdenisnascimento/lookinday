//
//  BaseTableViewCell.h
//  LookInDay
//
//  Created by Denis Nascimento on 11/24/15.
//  Copyright © 2015 Denis Nascimento. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DXStarRatingView.h"
#import "THSModel.h"
#import "FIRPost.h"
#import "FIRFavorito.h"


@import Firebase;
@import FirebaseAuth;
@import FirebaseDatabase;
@import FirebaseStorage;

@class BaseTableViewCell;

@protocol BaseTableViewCellDelegate <NSObject>

-(void)didtableCellSelected:(BaseTableViewCell*)tableCell;

@end

@interface BaseTableViewCell : UITableViewCell <UIAlertViewDelegate>
@property(nonatomic,assign) id<BaseTableViewCellDelegate> delegate;
@property (nonatomic, strong) FIRPost *currentPost;
@property (nonatomic, strong) FIRFavorito *currentFavorito;
@property (nonatomic, strong) NSArray *favoritos;
@property (strong, nonatomic) IBOutlet UIButton *btnFavorito;
@property (strong, nonatomic) IBOutlet UIButton *btnDelete;
@property (weak, nonatomic) IBOutlet DXStarRatingView *starRatingView;
@property (strong, nonatomic) IBOutlet UILabel *labelComentarios;
@property(nonatomic,assign) BOOL isProfile;

- (IBAction)btnFavorito:(UIButton*)sender;
- (IBAction)btnDelete:(UIButton*)sender;
- (void)checkFavoritos;
- (void)checkRatting;
- (void)checkCountPost;
@end
