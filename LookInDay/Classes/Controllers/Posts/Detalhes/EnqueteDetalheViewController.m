//
//  PostDetalheViewController.m
//  LookInDay
//
//  Created by Denis Nascimento on 6/26/15.
//  Copyright (c) 2015 Denis Nascimento. All rights reserved.
//

#import "EnqueteDetalheViewController.h"
#import "UIViewUtils.h"
#import "PostDetalheViewCell.h"
#import "UIView+NibLoading.h"
#import "THSModel.h"
#import "GalleryViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "FIRScore.h"

@import FirebaseAuth;

@interface EnqueteDetalheViewController ()
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) NSArray *itemsComentarios;
@property (nonatomic, strong) NSNumber *rating;
@property (nonatomic, strong) NSLayoutConstraint * headerViewHeightConstraint;

@end

@implementation EnqueteDetalheViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setStyleDefault];
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"ENQUETE";
    
    self.btnComentarios.titleLabel.font  = [UIFont fontWithName:UrbanEleganceBold size:self.btnSendAvaliar.titleLabel.font.pointSize];
    
    self.btnSendAvaliar.titleLabel.font  = [UIFont fontWithName:UrbanEleganceBold size:self.btnSendAvaliar.titleLabel.font.pointSize];
    self.btnCancelComentario.titleLabel.font  = [UIFont fontWithName:UrbanEleganceBold size:self.btnCancelComentario.titleLabel.font.pointSize];
    self.btnSendComentatio.titleLabel.font  = [UIFont fontWithName:UrbanEleganceBold size:self.btnSendComentatio.titleLabel.font.pointSize];
    
    
    
    self.btnCancelComentario.layer.cornerRadius = 5;
    self.btnCancelComentario.layer.masksToBounds = YES;
    
    self.btnSendAvaliar.layer.cornerRadius = 5;
    self.btnSendAvaliar.layer.masksToBounds = YES;
    
    self.btnSendComentatio.layer.cornerRadius = 5;
    self.btnSendComentatio.layer.masksToBounds = YES;
    
    self.viewBgAvaliar.layer.cornerRadius = 5;
    self.viewBgAvaliar.layer.masksToBounds = YES;
    
    
    self.textViewComentarios.placeholderText =@"Escreva seu comentário";
    self.textViewComentarios.layer.cornerRadius = 5;
    self.textViewComentarios.layer.masksToBounds = YES;
    self.tableView.tableFooterView = [UIView new];
    
    
    
    self.ratingView.type = 2;
    self.ratingView.enabledVoto = YES;
    
    [self.ratingView setStars:1 callbackBlock:^(NSNumber *newRating) {
        [self updateRating:newRating];
    }];
    
    
    self.btnShowAvaliar.layer.cornerRadius = 5;
    self.btnShowAvaliar.layer.masksToBounds = YES;
    self.imageThumb.layer.cornerRadius =   self.imageThumb.frame.size.width/2;
    self.imageThumb.layer.masksToBounds = YES;
    
    
    self.btnShowAvaliar.titleLabel.font  = [UIFont fontWithName:UrbanEleganceBold size:self.btnShowAvaliar.titleLabel.font.pointSize];
    self.btnShowAvaliar.backgroundColor = [UIColor colorWithRed:0.208f green:0.322f blue:0.361f alpha:1.00f];
    [Constants insertGradientInView:self.viewDegrader];
    self.labelText.font = [UIFont fontWithName:UrbanElegance size:self.labelText.font.pointSize];
    
    
    self.labelText.preferredMaxLayoutWidth = CGRectGetWidth(self.labelText.frame);
    
    self.tableView.separatorColor = [UIColor colorWithRed:0.875f green:0.875f blue:0.882f alpha:1.00f];
    self.labelOu.layer.cornerRadius = self.labelOu.frame.size.width/2;
    self.labelOu.clipsToBounds = YES;
    self.labelOu.font = [UIFont fontWithName:@"Urban Elegance Bold" size:self.labelOu.font.pointSize];
    
    self.imageCapa.tag = 1;
    self.imageCapa1.tag = 2;
    self.imageCapa.userInteractionEnabled = YES;
    self.imageCapa1.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(opeGallery:)];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(opeGallery:)];
    [self.imageCapa addGestureRecognizer:tap];
    [self.imageCapa1 addGestureRecognizer:tap1];
    
    [self updateContent];
    
}

-(void)opeGallery:(UIGestureRecognizer*)gesture
{
    GalleryViewController *vc = [GalleryViewController new];
    if (gesture.view.tag == 1)
        vc.urlString = self.currentPost.photo1;
    else
        vc.urlString = self.currentPost.photo2;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)updateRating:(NSNumber *)number
{
    self.rating = number;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)sizeHeaderToFit
{
    
    UIView *header = self.viewHeader;
    
    [header setNeedsLayout];
    [header layoutIfNeeded];
    
    CGFloat height = [header systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
    CGRect headerFrame = header.frame;
    headerFrame.size.height = height;
    
    header.frame = headerFrame;
    
    self.tableView.tableHeaderView = header;
    
}



-(void)updateContent
{
    
    if (self.currentPost)
    {

        if ([self.currentPost.userUID isEqualToString:[FIRAuth auth].currentUser.uid]) {
            self.btnFavorito1.hidden = YES;
            self.btnFavorito2.hidden = YES;
        }
        
        [self updateContetTable];
        

        self.labelName.text = self.currentPost.userName;
        self.labelText.text = self.currentPost.descriptionValue;

        UIImage *placeHolder = [UIImage imageNamed:@"placeholder_thumb"];
        
        [self.imageThumb sd_setImageWithURL:[NSURL URLWithString:self.currentPost.userPhoto]
                           placeholderImage:placeHolder
                                  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                      self.imageThumb.image = image;
                                  }];
        
        [self.imageCapa sd_setImageWithURL:[NSURL URLWithString:self.currentPost.photo1]
                          placeholderImage:[UIImage imageNamed:@"placeholder_post"]
                                 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                     self.imageCapa.image = image;
                                 }];
        
        
        [self.imageCapa1 sd_setImageWithURL:[NSURL URLWithString:self.currentPost.photo2]
                           placeholderImage:[UIImage imageNamed:@"placeholder_post"]
                                  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                      self.imageCapa1.image = image;
                                  }];
        
        
        
        [self sizeHeaderToFit];

    }
    
}

-(void)updateContetTable
{
  
    [THSModel comments:self.currentPost.uid completion:^(BOOL success, id result) {
        self.itemsComentarios = [NSArray arrayWithArray:result];
        if (self.itemsComentarios.count > 0){
            [self.tableView reloadData];
        }
        [self stopAnimate];
    }];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self heightForBasicCellAtIndexPath:indexPath];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return self.itemsComentarios.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PostDetalheViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"postDetalheViewCell"];
    if (cell == nil)
    {
        cell = [UIView viewWithNibName:@"PostDetalheViewCell"];
    }
    
    FIRComments *comment = [self.itemsComentarios objectAtIndex:indexPath.row];
    [cell updateContentCell:comment];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


- (CGFloat)heightForBasicCellAtIndexPath:(NSIndexPath *)indexPath {
    
    static PostDetalheViewCell *sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [[[UINib nibWithNibName:@"PostDetalheViewCell" bundle:nil] instantiateWithOwner:nil options:nil] objectAtIndex:0];
    });
    
    
    [self configureBasicCell:sizingCell atIndexPath:indexPath];
    
    
    return [self calculateHeightForConfiguredSizingCell:sizingCell];
}

- (CGFloat)calculateHeightForConfiguredSizingCell:(UITableViewCell *)sizingCell {
    [sizingCell setNeedsLayout];
    [sizingCell layoutIfNeeded];
    
    CGSize size = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height ;
}

- (void)configureBasicCell:(PostDetalheViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    FIRComments *comment = [self.itemsComentarios objectAtIndex:indexPath.row];
    [cell updateContentCell:comment];
}

- (IBAction)btnShowComentario:(id)sender
{
    
    if (self.viewComentario.isHidden)
        self.viewComentario.hidden = NO;
    
    if (self.constraintViewComentario.constant <= -238)
    {
        self.viewBackgroud.hidden = NO;
        self.constraintViewComentario.constant = 0.f;
        [self.textViewComentarios becomeFirstResponder];
    }
    else
    {
        self.viewBackgroud.hidden = YES;
        self.constraintViewComentario.constant = -238.f;
        self.textViewComentarios.text = @"";
        [self.textViewComentarios resignFirstResponder];
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}

- (IBAction)btnSendComentario:(id)sender
{
    if (![self.textViewComentarios.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]])
    {
        [self alertViewWithMessage:@"Escreva um comentário" title:nil button:nil];
        return;
    }
    
    [self saveComentario];
    
}

- (IBAction)btnAvaliar:(id)sender
{
    if (self.viewAvaliar.isHidden)
    {
        self.viewBackgroud.hidden = NO;
        self.viewAvaliar.hidden = NO;
    }
    else
    {
        self.viewBackgroud.hidden = YES;
        self.viewAvaliar.hidden = YES;
    }
}

- (IBAction)btnSendAvaliar:(id)sender
{
    [self btnAvaliar:nil];
    
    FIRScore *score = [FIRScore new];
    [score config];
    score.rating = self.rating;
    score.post = self.currentPost;
    [self startAnimate];
    
    [score save:^(BOOL success, id result) {
        if (!success)
        {
            NSLog(@"error");
        }
        [self stopAnimate];
    }];
}

- (IBAction)btnCancelComentario:(id)sender
{
    [self btnShowComentario:nil];
}

-(void)saveComentario
{
    FIRComments *comment = [FIRComments new];
    [comment config];
    
    comment.comment = self.textViewComentarios.text;
    comment.userName = [FIRAuth auth].currentUser.displayName;
    comment.userPhoto = [FIRAuth auth].currentUser.photoURL.absoluteString;
    comment.post = self.currentPost;
    [self startAnimate];
    [self btnShowComentario:nil];
    
    [comment save:^(BOOL success, id result) {
        if (!success)
        {
            NSLog(@"error");
        }
        [self stopAnimate];
    }];
}

- (IBAction)btnCancelar:(id)sender {
    [self btnAvaliar:nil];
}


- (IBAction)btnFavorito:(UIButton*)sender
{
    self.btnFavorito1.selected = NO;
    self.btnFavorito2.selected = NO;
    
    sender.selected = YES;
    
    NSInteger score1 = self.currentPost.scoreimage1.integerValue;
    NSInteger score2 = self.currentPost.scoreimage2.integerValue;
    
    if (sender.tag == 1)
        score1++;
    else
        score2++;
    
    self.currentPost.scoreimage1 = [NSNumber numberWithInteger:score1];
    self.currentPost.scoreimage2 = [NSNumber numberWithInteger:score2];
    
    [FIRPost updatePost:self.currentPost completion:^(BOOL success, id result) {
        if (!success)
            NSLog(@"erro");
        
    }];
    
    
}



@end
