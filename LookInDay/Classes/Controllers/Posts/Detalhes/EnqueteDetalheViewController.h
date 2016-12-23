//
//  PostDetalheViewController.h
//  LookInDay
//
//  Created by Denis Nascimento on 6/26/15.
//  Copyright (c) 2015 Denis Nascimento. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "DXStarRatingView.h"
#import "LPlaceholderTextView.h"
#import "FIRPost.h"

@interface EnqueteDetalheViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintViewComentario;

@property (weak, nonatomic) IBOutlet UIButton *btnSendAvaliar;
@property (weak, nonatomic) IBOutlet UIButton *btnSendComentatio;

@property (weak, nonatomic) IBOutlet UIButton *btnCancelComentario;
@property (weak, nonatomic) IBOutlet UIView *viewHeader;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet DXStarRatingView *ratingView;
@property (nonatomic, strong) FIRPost *currentPost;
@property (weak, nonatomic) IBOutlet LPlaceholderTextView *textViewComentarios;
@property (weak, nonatomic) IBOutlet UIView *viewComentario;
@property (weak, nonatomic) IBOutlet UIView *viewAvaliar;
@property (weak, nonatomic) IBOutlet UIButton *btnComentarios;
@property (weak, nonatomic) IBOutlet UIView *viewBgAvaliar;
@property (weak, nonatomic) IBOutlet UIView *viewBackgroud;
@property (strong, nonatomic) IBOutlet UILabel *labelOu;



@property (weak, nonatomic) IBOutlet UIImageView *imageCapa;
@property (weak, nonatomic) IBOutlet UIImageView *imageCapa1;
@property (weak, nonatomic) IBOutlet UIImageView *imageThumb;
@property (weak, nonatomic) IBOutlet UIButton *btnFavorito1;
@property (weak, nonatomic) IBOutlet UIButton *btnFavorito2;
@property (weak, nonatomic) IBOutlet UIButton *btnShowAvaliar;
@property (weak, nonatomic) IBOutlet UIView *viewDegrader;
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelText;

- (IBAction)btnShowComentario:(id)sender;
- (IBAction)btnSendComentario:(id)sender;
- (IBAction)btnCancelComentario:(id)sender;
- (IBAction)btnAvaliar:(id)sender;
- (IBAction)btnCancelar:(id)sender;
- (IBAction)btnSendAvaliar:(id)sender;
- (IBAction)btnFavorito:(UIButton*)sender;

@end
