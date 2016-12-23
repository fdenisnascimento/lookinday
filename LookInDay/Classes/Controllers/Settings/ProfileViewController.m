//
//  ProfileViewController.m
//  LookInDay
//
//  Created by Denis Nascimento on 11/3/15.
//  Copyright © 2015 Denis Nascimento. All rights reserved.
//

#import "ProfileViewController.h"
#import "DicasTableViewCell.h"
#import "PostTableViewCell.h"
#import "EnquetesTableViewCell.h"
#import "UIView+NibLoading.h"
#import "THSModel.h"
#import "PostDetalheViewController.h"
#import "EnqueteDetalheViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "FIRPost.h"

@interface ProfileViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSArray *items;
@property (nonatomic,assign) PostType postType;

@end

@implementation ProfileViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setStylePost];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Perfil";
    
    [self createButtonMenu];
    [self updateViewUser];
    self.tableView.tableFooterView = [UIView new];
    self.imageView.layer.cornerRadius = self.imageView.frame.size.height/2;
    self.imageView.layer.masksToBounds = YES;
    self.postType = PostTypeLook;
    
}

-(void)updateViewUser
{
    self.labelName.text = [FBSDKProfile currentProfile].name;
    NSURL *urlImage = [[FBSDKProfile currentProfile]imageURLForPictureMode:FBSDKProfilePictureModeSquare size:self.imageView.frame.size];
    [self.imageView sd_setImageWithURL:urlImage
                      placeholderImage:[UIImage imageNamed:@"placeholder_post"]
                             completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                 self.imageView.image = image;
                             }];
    
    [self.view layoutIfNeeded];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setPostType:(PostType)postType
{
    _postType = postType;
    [self updateTableContents];
}



-(void)getDicas{
    
    [THSModel myDicas:^(BOOL success, id result) {
        if (success) {
            self.items = [NSArray arrayWithArray:result];
            [self.tableView reloadData];
            [self stopAnimate];
        }
    }];
    
}

-(void)getEnquetes{
    
    [THSModel myEnquetes:^(BOOL success, id result) {
        if (success) {
            self.items = [NSArray arrayWithArray:result];
            [self.tableView reloadData];
            [self stopAnimate];
        }
    }];
}

-(void)getLooks{
    
    [THSModel myLooks:^(BOOL success, id result) {
        if (success) {

            self.items = [NSArray arrayWithArray:result];
            [self.tableView reloadData];
            [self stopAnimate];
        }
    }];
    
}

-(void)updateTableContents
{
    [self startAnimate];
    
    switch (self.postType)
    {
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
    
    
    
    [self stopAnimate];
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

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return  self.viewSegment;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
        FIRPost *post = [self.items objectAtIndex:indexPath.row];

        if (post.postType == AddPostTypeDica)
        {
            DicasTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dicasTableViewCell"];
            if (cell == nil)
            {
                cell = [UIView viewWithNibName:@"DicasTableViewCell"];
            }
            cell.isProfile = YES;
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
            cell.isProfile = YES;
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
            cell.isProfile = YES;
            [cell updateContentCell:post];
            return cell;
        }
    
    
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    FIRPost *post = [self.items objectAtIndex:indexPath.row];
    
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
    
}

- (IBAction)tapSegmentControll:(UISegmentedControl*)sender {
    
    switch (sender.selectedSegmentIndex) {
        case 0:
            self.postType = PostTypeLook;
            break;
        case 1:
            self.postType = PostTypeEnquete;
            break;
        case 2:
            self.postType = PostTypeDicas;
            break;
            
        default:
            break;
    }
    
}
@end
