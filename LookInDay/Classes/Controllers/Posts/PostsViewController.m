//
//  PostsViewController.m
//  LookInDay
//
//  Created by Denis Nascimento on 6/16/15.
//  Copyright (c) 2015 Denis Nascimento. All rights reserved.
//

#import "PostsViewController.h"

#import "UIView+NibLoading.h"
#import "PostTableViewCell.h"
#import "AddPostViewController.h"
#import "AddEnqueteViewController.h"
#import "LoginViewController.h"
#import "EnquetesTableViewCell.h"
#import "DicasTableViewCell.h"
#import "PostDetalheViewController.h"
#import "THSModel.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "THSNavigationController.h"
#import "EnqueteDetalheViewController.h"
#import "FIRModel.h"
#import "FIRPost.h"
#import "FIRFavorito.h"

@interface PostsViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) NSArray *itemsFavoritos;
@property (nonatomic,retain)  UIRefreshControl *refreshControl;

@end

@implementation PostsViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setStylePost];
    [self updateTableContents];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.title = @"LOOK IN DAY";
    [self createButtonMenu];
    if (self.postType != PostTypeFavorito)
        [self createButtonAdd];
    
    
    self.btnAddDica.titleLabel.font = [UIFont fontWithName:UrbanElegance size:self.btnAddDica.titleLabel.font.pointSize];
    self.btnAddEnquete.titleLabel.font = [UIFont fontWithName:UrbanElegance size:self.btnAddEnquete.titleLabel.font.pointSize];
    self.btnAddLook.titleLabel.font = [UIFont fontWithName:UrbanElegance size:self.btnAddLook.titleLabel.font.pointSize];
    self.btnAddDica.titleLabel.textColor = [UIColor colorWithRed:0.906f green:0.863f blue:0.784f alpha:1.00f];
    self.btnAddEnquete.titleLabel.textColor = [UIColor colorWithRed:0.906f green:0.863f blue:0.784f alpha:1.00f];
    self.btnAddLook.titleLabel.textColor = [UIColor colorWithRed:0.906f green:0.863f blue:0.784f alpha:1.00f];
    
    
    
    self.viewAddPost.backgroundColor = [UIColor colorWithRed:0.188f green:0.282f blue:0.322f alpha:1.00f];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)getAllPosts{
    
    [THSModel allPosts:^(BOOL success, id result) {
        if (success) {
            self.items = [NSArray arrayWithArray:result];
            [self.tableView reloadData];
            
        }
        [self stopAnimate];
    }];
}

-(void)getFavorites{
    
    
    [THSModel favoties:^(BOOL success, id result) {
        if (success) {
            self.items = [NSArray arrayWithArray:result];
            if (self.items.count > 0)
            {
                [self.tableView reloadData];
                self.tableView.hidden = NO;
                self.viewFavoritos.hidden = YES;
            }
            else
            {
                self.tableView.hidden = YES;
                self.viewFavoritos.hidden = NO;
            }
            
        }
        [self stopAnimate];
    }];
}

-(void)getDicas{
    
    [THSModel dicas:^(BOOL success, id result) {
        if (success) {
            self.items = [NSArray arrayWithArray:result];
            if(self.items.count <=0 ){
                self.tableView.hidden = YES;
                self.viewFavoritos.hidden = NO;
                return ;
            }
            
            [self.tableView reloadData];
        }
        [self stopAnimate];
    }];
    
}

-(void)getEnquetes{
    
    [THSModel enquetes:^(BOOL success, id result) {
        if (success) {
            self.items = [NSArray arrayWithArray:result];
            [self.tableView reloadData];
        }
        [self stopAnimate];
    }];
    
}

-(void)getLooks{
    
    [THSModel looks:^(BOOL success, id result) {
        if (success) {
            self.items = [NSArray arrayWithArray:result];
            [self.tableView reloadData];
        }
        [self stopAnimate];
    }];
    
}

-(void)updateTableContents
{
    [self startAnimate];
    switch (self.postType)
    {
        case PostTypePost:
            [self getAllPosts];
            break;
        case PostTypeFavorito:
            [self getFavorites];
            break;
            
        case PostTypeTop10:
            break;
            
        case PostTypeDicas:
            [self getDicas];
            break;
            
        case PostTypeLook:
            [self getLooks];
            break;
        case PostTypeEnquete:
            [self getEnquetes];
            break;
        default: break;
    }
    
}


-(void)addPost
{
    if (self.constraintViewAddY.constant <= -160)
    {
        self.constraintViewAddY.constant = 0;
        self.addButton.image = [UIImage imageNamed:@"icon_fechar"];
    }
    else
    {
        self.constraintViewAddY.constant = -160;
        self.addButton.image = [UIImage imageNamed:@"icpn_add"];
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return self.items.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 395;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    FIRPost *post = (FIRPost*)[self.items objectAtIndex:indexPath.row];
    
    if (post.postType == AddPostTypeDica)
    {
        DicasTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dicasTableViewCell"];
        if (cell == nil)
        {
            cell = [UIView viewWithNibName:@"DicasTableViewCell"];
        }
        [cell updateContentCell:post];
        return cell;
    }
    
    if (post.postType == AddPostTypeLook)
    {
        PostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"postTableViewCell"];
        if (cell == nil)
        {
            cell = [UIView viewWithNibName:@"PostTableViewCell"];  
        }
        [cell updateContentCell:post];
        return cell;
    }
    
    if (post.postType == AddPostTypeEnquete)
    {
        EnquetesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"enquetesTableViewCell"];
        if (cell == nil)
        {
            cell = [UIView viewWithNibName:@"EnquetesTableViewCell"];
        }
        [cell updateContentCell:post];
        return cell;
    }
    
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    FIRPost *post = (FIRPost*)[self.items objectAtIndex:indexPath.row];
    
    if (post.postType == AddPostTypeLook)
    {
        PostDetalheViewController *vc = [PostDetalheViewController new];
        vc.currentPost = post;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    if (post.postType == AddPostTypeEnquete)
    {
        EnqueteDetalheViewController *vc = [EnqueteDetalheViewController new];
        vc.currentPost = post;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
    if (post.postType == AddPostTypeDica)
    {
        PostDetalheViewController *vc = [PostDetalheViewController new];
        vc.currentPost = post;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
}

- (IBAction)btnAddPostSelect:(UIButton *)sender
{
    
    if (![FBSDKAccessToken currentAccessToken])
    {
        LoginViewController *vc = [LoginViewController new];
        vc.fromInterna = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
    if (sender.tag == 0)
    {
        AddPostViewController *vc = [AddPostViewController new];
        vc.postType = AddPostTypeLook;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
    if (sender.tag == 1)
    {
        AddEnqueteViewController *vc = [AddEnqueteViewController new];
        vc.postType = AddPostTypeEnquete;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
    if (sender.tag == 2)
    {
        AddPostViewController *vc = [AddPostViewController new];
        vc.postType = AddPostTypeDica;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
    [self addPost];
    
}



@end
