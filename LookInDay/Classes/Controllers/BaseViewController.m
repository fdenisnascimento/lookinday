//
//  BaseViewController.m
//  MensagemDigital
//
//  Created by Denis Nascimento on 5/18/15.
//  Copyright (c) 2015 Denis Nascimento. All rights reserved.
//

#import "BaseViewController.h"
#import "THSNavigationController.h"
#import "Constants.h"


@interface BaseViewController ()<UITextViewDelegate,UITextFieldDelegate>

@end

@implementation BaseViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
  
    // Do any additional setup after loading the view.
  self.normalFont1.font = [UIFont fontWithName:@"UrbanElegance" size:self.normalFont1.font.pointSize];
  self.normalFont2.font = [UIFont fontWithName:@"UrbanElegance" size:self.normalFont2.font.pointSize];
  self.normalFont3.font = [UIFont fontWithName:@"UrbanElegance" size:self.normalFont3.font.pointSize];
  self.normalFont4.font = [UIFont fontWithName:@"UrbanElegance" size:self.normalFont4.font.pointSize];
  self.normalFont6.font = [UIFont fontWithName:@"UrbanElegance" size:self.normalFont6.font.pointSize];
  self.normalFont5.font = [UIFont fontWithName:@"UrbanElegance" size:self.normalFont5.font.pointSize];
  self.normalFont7.font = [UIFont fontWithName:@"UrbanElegance" size:self.normalFont7.font.pointSize];
  self.normalFont8.font = [UIFont fontWithName:@"UrbanElegance" size:self.normalFont8.font.pointSize];
  
  self.boldFont1.font = [UIFont fontWithName:@"UrbanElegance-Bold" size:self.boldFont1.font.pointSize];
  self.boldFont2.font = [UIFont fontWithName:@"UrbanElegance-Bold" size:self.boldFont2.font.pointSize];
  self.boldFont3.font = [UIFont fontWithName:@"UrbanElegance-Bold" size:self.boldFont3.font.pointSize];
  self.boldFont4.font = [UIFont fontWithName:@"UrbanElegance-Bold" size:self.boldFont4.font.pointSize];
  self.boldFont6.font = [UIFont fontWithName:@"UrbanElegance-Bold" size:self.boldFont5.font.pointSize];
  self.boldFont5.font = [UIFont fontWithName:@"UrbanElegance-Bold" size:self.boldFont6.font.pointSize];
  self.boldFont7.font = [UIFont fontWithName:@"UrbanElegance-Bold" size:self.boldFont7.font.pointSize];
  self.boldFont8.font = [UIFont fontWithName:@"UrbanElegance-Bold" size:self.boldFont8.font.pointSize];
  
  

  
  
  self.thinFont1.font = [UIFont fontWithName:@"UrbanElegance-Italic" size:self.thinFont1.font.pointSize];
  self.thinFont2.font = [UIFont fontWithName:@"UrbanElegance-Italic" size:self.thinFont2.font.pointSize];
  self.thinFont3.font = [UIFont fontWithName:@"UrbanElegance-Italic" size:self.thinFont3.font.pointSize];
  self.thinFont4.font = [UIFont fontWithName:@"UrbanElegance-Italic" size:self.thinFont4.font.pointSize];
  self.thinFont5.font = [UIFont fontWithName:@"UrbanElegance-Italic" size:self.thinFont5.font.pointSize];
  self.thinFont6.font = [UIFont fontWithName:@"UrbanElegance-Italic" size:self.thinFont6.font.pointSize];
  self.thinFont7.font = [UIFont fontWithName:@"UrbanElegance-Italic" size:self.thinFont7.font.pointSize];
  self.thinFont8.font = [UIFont fontWithName:@"UrbanElegance-Italic" size:self.thinFont8.font.pointSize];
  
  
  UIBarButtonItem *backButton =  [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    // [backButton setImage:[UIImage imageNamed:@"voltar"]];
  [backButton setImageInsets:UIEdgeInsetsMake(backButton.imageInsets.top,-10, backButton.imageInsets.bottom, backButton.imageInsets.right)];
  self.navigationItem.backBarButtonItem = backButton;
  
  UIButton *buttonNavBack = [UIButton buttonWithType:UIButtonTypeCustom];
  [buttonNavBack setImage:[UIImage imageNamed:@"seta"] forState:UIControlStateNormal];
  [buttonNavBack setTitleColor:[UIColor colorWithRed:0.188f green:0.278f blue:0.322f alpha:1.00f] forState:UIControlStateNormal];
  [buttonNavBack addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
  [buttonNavBack sizeToFit];
  buttonNavBack.titleEdgeInsets = UIEdgeInsetsMake(0,-30, 0, 0);
  buttonNavBack.imageEdgeInsets = UIEdgeInsetsMake(0,-30, 0, 0);
  buttonNavBack.titleLabel.textAlignment = NSTextAlignmentLeft;
  buttonNavBack.titleLabel.font = [UIFont fontWithName:@"UrbanElegance-Bold" size:28];
  
  UIBarButtonItem* customBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:buttonNavBack];
  self.navigationItem.backBarButtonItem = customBarButtonItem;
  [self setMenuEnabled:NO];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self setNeedsStatusBarAppearanceUpdate];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




-(void)setLogo
{
  UIImage *image = [UIImage imageNamed: @"logo_nav.png"];
  UIImageView *imageview = [[UIImageView alloc] initWithImage: image];
  
    // set the text view to the image view
  self.navigationItem.titleView = imageview;
}

-(void)setNavigationBarHidden:(BOOL)hidden
{
  self.navigationController.navigationBar.hidden = hidden;
}

- (void)back
{
  [self.navigationController popViewControllerAnimated:YES];
}

- (void)backButtonHidden:(BOOL)hidden
{
  self.navigationItem.hidesBackButton = hidden;
}

- (void)backAnimate:(BOOL)animate
{
  [self.navigationController popViewControllerAnimated:animate];
}

-(void)createButtonMenu
{
  UIBarButtonItem	*addButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icpn_menu"] style:UIBarButtonItemStyleDone target:self action:@selector(showMenu)];
  self.navigationItem.leftBarButtonItem = addButton;
  self.navigationItem.leftBarButtonItem.enabled = YES;
}

-(void)createButtonAdd
{
  _addButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icpn_add"] style:UIBarButtonItemStyleDone target:self action:@selector(addPost)];

  self.navigationItem.rightBarButtonItem = _addButton;
  self.navigationItem.rightBarButtonItem.enabled = YES;
}

-(void)setMenuEnabled:(BOOL)enabled
{
  self.frostedViewController.panGestureEnabled = enabled;
    self.navigationController.interactivePopGestureRecognizer.enabled = !enabled;    
}

-(void)addPost
{
  
}

- (IBAction)showMenu
{
  [self.view endEditing:YES];
  [self.frostedViewController.view endEditing:YES];
  [self.frostedViewController presentMenuViewController];
}

-(void)setStyleLogin
{
  self.navigationController.navigationBar.hidden = YES;
}


-(void)setStylePost
{
  NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
  if ([[ver objectAtIndex:0] intValue] >= 7)
  {
    self.navigationController.navigationBar.barTintColor = [Constants color];
    self.navigationController.navigationBar.translucent = NO;
    NSDictionary *textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIFont fontWithName:UrbanEleganceBold size:20],NSFontAttributeName,
                                    [UIColor colorWithRed:0.188f green:0.278f blue:0.322f alpha:1.00f],NSForegroundColorAttributeName,
                                    [UIColor colorWithRed:0.188f green:0.278f blue:0.322f alpha:1.00f],NSBackgroundColorAttributeName,nil];
    self.navigationController.navigationBar.titleTextAttributes = textAttributes;
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.188f green:0.278f blue:0.322f alpha:1.00f];
  }
  else
  {
    self.navigationController.navigationBar.tintColor = [UIColor redColor];
  }
  
  self.navigationController.navigationBar.hidden = NO;
  [self setMenuEnabled:YES];
  
}



-(void)setStyleDefault
{
  
  UIButton *buttonNavBack = [UIButton buttonWithType:UIButtonTypeCustom];
  [buttonNavBack setImage:[UIImage imageNamed:@"seta"] forState:UIControlStateNormal];
  [buttonNavBack setTitleColor:[UIColor colorWithRed:0.188f green:0.278f blue:0.322f alpha:1.00f] forState:UIControlStateNormal];
  [buttonNavBack addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
  [buttonNavBack sizeToFit];
  buttonNavBack.imageEdgeInsets = UIEdgeInsetsMake(0,-20, 0, 0);
  buttonNavBack.titleLabel.textAlignment = NSTextAlignmentLeft;
  buttonNavBack.titleLabel.font = [UIFont fontWithName:@"UrbanElegance-Bold" size:20];
  
  UIBarButtonItem* customBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:buttonNavBack];
  self.navigationItem.leftBarButtonItem = customBarButtonItem;
  self.navigationItem.leftBarButtonItem.enabled = YES;
  
  
  [self.navigationController.navigationBar setTranslucent:NO];
  self.navigationController.navigationBar.tintColor = [Constants color];
  
  NSDictionary *textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                  [UIFont fontWithName:UrbanEleganceBold size:20],NSFontAttributeName,
                                  [UIColor colorWithRed:0.188f green:0.278f blue:0.322f alpha:1.00f],NSForegroundColorAttributeName,
                                  [UIColor colorWithRed:0.188f green:0.278f blue:0.322f alpha:1.00f],NSBackgroundColorAttributeName,nil];
  
  self.navigationController.navigationBar.titleTextAttributes = textAttributes;
    
}




@end
