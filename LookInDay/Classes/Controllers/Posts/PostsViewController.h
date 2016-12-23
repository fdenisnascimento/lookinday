//
//  PostsViewController.h
//  LookInDay
//
//  Created by Denis Nascimento on 6/16/15.
//  Copyright (c) 2015 Denis Nascimento. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"



@interface PostsViewController : BaseViewController
@property (strong, nonatomic) IBOutlet UIButton *btnAddLook;
@property (strong, nonatomic) IBOutlet UIButton *btnAddEnquete;
@property (strong, nonatomic) IBOutlet UIButton *btnAddDica;
@property (strong, nonatomic) IBOutlet UIView *viewAddPost;
@property (strong, nonatomic) IBOutlet UIView *viewFavoritos;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,assign) BOOL isFavoritos;
@property (nonatomic,assign) PostType postType;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintViewAddY;

- (IBAction)btnAddPostSelect:(UIButton *)sender;

@end
