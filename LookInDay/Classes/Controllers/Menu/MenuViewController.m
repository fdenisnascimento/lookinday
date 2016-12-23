//
//  MenuViewController.m
//  MensagemDigital
//
//  Created by Denis Nascimento on 5/18/15.
//  Copyright (c) 2015 Denis Nascimento. All rights reserved.
//

#import "MenuViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "Constants.h"
#import "LoginViewController.h"
#import "THSNavigationController.h"
#import "WebViewController.h"
#import "SettingsViewController.h"
#import "PostsViewController.h"
#import "ProfileViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "AppDelegate.h"

@interface MenuViewController ()

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) UILabel *labelName;
@property (nonatomic, strong) UIImageView *imageView ;

@end

@implementation MenuViewController


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [AppDelegate sharedInstance].window.windowLevel = UIWindowLevelStatusBar;
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
   // [AppDelegate sharedInstance].window.windowLevel = UIWindowLevelNormal;
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    
    self.items = @[@{@"name":@"POSTS",@"id":@"1",@"icon":@"icon_posts"},
                   @{@"name":@"FAVORITOS",@"id":@"2",@"icon":@"icon_favoritos_menu"},
                   @{@"name":@"DICAS",@"id":@"4",@"icon":@"icon_dicas"},
                   @{@"name":@"LOOKS",@"id":@"5",@"icon":@"icon_looks"},
                   @{@"name":@"ENQUETES",@"id":@"6",@"icon":@"icon_enquetes"},
                   @{@"name":@"CONFIGURAÇÕES",@"id":@"7",@"icon":@"icon_config"}];
    
    
    self.tableView.separatorColor = [UIColor colorWithRed:150/255.0f green:161/255.0f blue:177/255.0f alpha:1.0f];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.opaque = NO;
    self.tableView.backgroundColor =[UIColor colorWithRed:0.188f green:0.282f blue:0.322f alpha:1.00f];
    self.tableView.tableHeaderView = ({
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 184.0f)];
      
      UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(openProfile:)];
      

        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, view.frame.size.height/2-25, 70, 70)];
        _imageView.image = [UIImage imageNamed:@"placeholder_foto_post"];
        _imageView.layer.masksToBounds = YES;
        _imageView.layer.cornerRadius = _imageView.frame.size.height/2;
      [_imageView addGestureRecognizer:tap];
        [view addSubview:_imageView];
        
        _labelName = [[UILabel alloc] initWithFrame:CGRectMake(100, view.frame.size.height/2-25, CGRectGetWidth([UIScreen mainScreen].bounds) -140, 50)];
        _labelName.text = @"Visitante";
        _labelName.font = [UIFont fontWithName:@"UrbanElegance" size:20];
        _labelName.backgroundColor = [UIColor clearColor];
      _labelName.textColor = [UIColor colorWithRed:0.906f green:0.863f blue:0.784f alpha:1.00f];
        _labelName.numberOfLines = 2;
        [view addSubview:_labelName];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(20, 160, CGRectGetWidth([UIScreen mainScreen].bounds)-15, 0.5)];
        [line setBackgroundColor:[UIColor colorWithHexValue:@"#8B888C"]];
        [view addSubview:line];
        
        view;
    });
    
    [self updateView];
}

-(void)openProfile:(UITapGestureRecognizer*)gesture
{
  [self.frostedViewController hideMenuViewController];
  ProfileViewController *vc = [ProfileViewController new];
  THSNavigationController *nav = [[THSNavigationController alloc]initWithRootViewController:vc];
  self.frostedViewController.contentViewController = nav;
  vc.title = @"Profile";
  
}

-(void)updateView
{

    FIRUser *user = [FIRAuth auth].currentUser;
    
    if (user != nil) {
        self.labelName.text = user.displayName;
  
    [self.imageView sd_setImageWithURL:user.photoURL
                      placeholderImage:[UIImage imageNamed:@"placeholder_post"]
                             completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                               self.imageView.image = image;
                             }];
        self.imageView.userInteractionEnabled = YES;
    }
  
}

#pragma mark -
#pragma mark UITableView Delegate



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.frostedViewController hideMenuViewController];
    
    NSDictionary *item = [self.items objectAtIndex:indexPath.row];
    
    // Posts
    if ([[item valueForKey:@"id"]integerValue] == 1)
    {
        PostsViewController *vc = [PostsViewController new];
        vc.postType = PostTypePost;
        THSNavigationController *nav = [[THSNavigationController alloc]initWithRootViewController:vc];
        self.frostedViewController.contentViewController = nav;
      vc.title = @"Posts";
    }
    
    // Favoritos
    if ([[item valueForKey:@"id"]integerValue] == 2) {

        if ( [FIRAuth auth].currentUser != nil) {
            
            PostsViewController *vc = [PostsViewController new];
            vc.postType = PostTypeFavorito;
            THSNavigationController *nav = [[THSNavigationController alloc]initWithRootViewController:vc];
            self.frostedViewController.contentViewController = nav;
          vc.title = @"Favoritos";
            
        }else{
            
            FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
            [login logOut];
            LoginViewController *vc = [LoginViewController new];
            THSNavigationController *nav = [[THSNavigationController alloc]initWithRootViewController:vc];
            self.frostedViewController.contentViewController = nav;
        }
    }
    
    // Top 10
    if ([[item valueForKey:@"id"]integerValue] == 3)
    {
        PostsViewController *vc = [PostsViewController new];
        vc.postType = PostTypeTop10;
        THSNavigationController *nav = [[THSNavigationController alloc]initWithRootViewController:vc];
        self.frostedViewController.contentViewController = nav;
      vc.title = @"Top 10";
    }
    
    // Dicas
    if ([[item valueForKey:@"id"]integerValue] == 4)
    {
        PostsViewController *vc = [PostsViewController new];
        vc.postType = PostTypeDicas;
        THSNavigationController *nav = [[THSNavigationController alloc]initWithRootViewController:vc];
        self.frostedViewController.contentViewController = nav;
      vc.title = @"Dicas";
    }
    
    // Looks
    if ([[item valueForKey:@"id"]integerValue] == 5)
    {
        PostsViewController *vc = [PostsViewController new];
        vc.postType = PostTypeLook;
        THSNavigationController *nav = [[THSNavigationController alloc]initWithRootViewController:vc];
        self.frostedViewController.contentViewController = nav;
      vc.title = @"Looks";
    }
    
    // Enquetes
    if ([[item valueForKey:@"id"]integerValue] == 6)
    {
        PostsViewController *vc = [PostsViewController new];
        vc.postType = PostTypeEnquete;
        THSNavigationController *nav = [[THSNavigationController alloc]initWithRootViewController:vc];
        self.frostedViewController.contentViewController = nav;
      vc.title = @"Enquetes";
    }
    
    // Configuracao
    if ([[item valueForKey:@"id"]integerValue] == 7)
    {
        SettingsViewController *vc = [SettingsViewController new];
        THSNavigationController *nav = [[THSNavigationController alloc]initWithRootViewController:vc];
        self.frostedViewController.contentViewController = nav;
      vc.title = @"Configurações";
    }
    
}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 54;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
  return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *cellIdentifier = @"Cell";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.textLabel.font = [UIFont fontWithName:UrbanEleganceBold size:14];
    cell.textLabel.textColor = [UIColor whiteColor];
    UIView *viewBG = [UIView new];
    [viewBG setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.5]];
    cell.selectedBackgroundView = viewBG;

  }
  NSDictionary *item = [self.items objectAtIndex:indexPath.row];
  
  cell.textLabel.text = [item valueForKey:@"name"];
  cell.imageView.image = [UIImage imageNamed:[item valueForKey:@"icon"]];

  return cell;
}




  
@end
