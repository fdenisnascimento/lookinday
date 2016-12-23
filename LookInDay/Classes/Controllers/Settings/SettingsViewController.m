//
//  SettingsViewController.m
//  LookInDay
//
//  Created by Denis Nascimento on 6/19/15.
//  Copyright (c) 2015 Denis Nascimento. All rights reserved.
//

#import "SettingsViewController.h"
#import "WebViewController.h"
#import "PersonalizarViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "LoginViewController.h"
#import "THSModel.h"

@interface SettingsViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSArray *items;

@end

@implementation SettingsViewController

-(void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  [self setStylePost];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
if ([FIRAuth auth].currentUser != nil)
  {
    self.items = @[@{@"name":@"Sobre",@"id":@"1",@"icon":@"icon_sobre"},
                   @{@"name":@"Politíca de Privacidade",@"id":@"2",@"icon":@"icon_politicas"},
                   @{@"name":@"Termo de Uso",@"id":@"3",@"icon":@"icon_termos"},
                   //                 @{@"name":@"Personalizar",@"id":@"4",@"icon":@"personalizar"},
                   @{@"name":@"Sair do Aplicativo",@"id":@"5",@"icon":@"icon_sair"}
                   ];
    
  }
  else
  {
    self.items = @[@{@"name":@"Sobre",@"id":@"1",@"icon":@"icon_sobre"},
                   @{@"name":@"Politíca de Privacidade",@"id":@"2",@"icon":@"icon_politicas"},
                   @{@"name":@"Termo de Uso",@"id":@"3",@"icon":@"icon_termos"},
                   ];
    
  }
  
  
    self.title = @"Configurações";
  self.tableView.tableFooterView = [UIView new];
  [self createButtonMenu];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 70;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
  return self.items.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *cellIdentifier = @"Cell";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  if (cell == nil)
  {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    cell.textLabel.font = [UIFont fontWithName:@"FSEmeric-Medium" size:20];
    cell.textLabel.textColor = [UIColor colorWithRed:0.361 green:0.220 blue:0.427 alpha:1.000];
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
  }
  
  NSDictionary *dic = [self.items objectAtIndex:indexPath.row];
  cell.textLabel.text = [dic valueForKey:@"name"];
  cell.imageView.image = [UIImage imageNamed:[dic valueForKey:@"icon"]];
  
  return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   NSDictionary *item = [self.items objectAtIndex:indexPath.row];
  
  if ([[item valueForKey:@"id"]integerValue] == 1)
  {
    WebViewController *vc = [WebViewController new];
      vc.title = @"Sobre";
      vc.url = URL_HTML_ABOUT;
    [self.navigationController pushViewController:vc animated:YES];
    return;
  }

  if ([[item valueForKey:@"id"]integerValue] == 2)
  {
    WebViewController *vc = [WebViewController new];
      vc.title = @"Politíca de Privacidade";
      vc.url = URL_HTML_POLICY;
    [self.navigationController pushViewController:vc animated:YES];
    return;
  }

  if ([[item valueForKey:@"id"]integerValue] == 3)
  {
    WebViewController *vc = [WebViewController new];
      vc.title = @"Termo de uso";
      vc.url = URL_HTML_TERMS;
    [self.navigationController pushViewController:vc animated:YES];
    return;
  }
  
  if ([[item valueForKey:@"id"]integerValue] == 4)
  {
    PersonalizarViewController *vc = [PersonalizarViewController new];
    [self.navigationController pushViewController:vc animated:YES];
    return;
  }
  
  if ([[item valueForKey:@"id"]integerValue] == 5)
  {
    if ([FBSDKAccessToken currentAccessToken])
    {
      FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
      [login logOut];
      [FBSDKAccessToken setCurrentAccessToken:nil];
      [FBSDKProfile setCurrentProfile:nil];
    
        [THSModel logout];
      LoginViewController *vc = [LoginViewController new];
      [self.navigationController setViewControllers:@[vc] animated:YES];

    }
  }

                           
}



@end
