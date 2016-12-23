//
//  BaseViewController.h
//  MensagemDigital
//
//  Created by Denis Nascimento on 5/18/15.
//  Copyright (c) 2015 Denis Nascimento. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIFont+SytemFontOverride.h"
#import "Constants.h"
#import "THSViewController.h"
#import "AppDelegate.h"


@interface BaseViewController : THSViewController

@property (weak, nonatomic) IBOutlet UILabel *normalFont1;
@property (weak, nonatomic) IBOutlet UILabel *normalFont2;
@property (weak, nonatomic) IBOutlet UILabel *normalFont3;
@property (weak, nonatomic) IBOutlet UILabel *normalFont4;
@property (weak, nonatomic) IBOutlet UILabel *normalFont5;
@property (weak, nonatomic) IBOutlet UILabel *normalFont6;
@property (weak, nonatomic) IBOutlet UILabel *normalFont7;
@property (weak, nonatomic) IBOutlet UILabel *normalFont8;

@property (weak, nonatomic) IBOutlet UILabel *semiBoldFont1;
@property (weak, nonatomic) IBOutlet UILabel *semiBoldFont2;
@property (weak, nonatomic) IBOutlet UILabel *semiBoldFont3;
@property (weak, nonatomic) IBOutlet UILabel *semiBoldFont4;
@property (weak, nonatomic) IBOutlet UILabel *semiBoldFont5;
@property (weak, nonatomic) IBOutlet UILabel *semiBoldFont6;
@property (weak, nonatomic) IBOutlet UILabel *semiBoldFont7;
@property (weak, nonatomic) IBOutlet UILabel *semiBoldFont8;


@property (weak, nonatomic) IBOutlet UILabel *boldFont1;
@property (weak, nonatomic) IBOutlet UILabel *boldFont2;
@property (weak, nonatomic) IBOutlet UILabel *boldFont3;
@property (weak, nonatomic) IBOutlet UILabel *boldFont4;
@property (weak, nonatomic) IBOutlet UILabel *boldFont5;
@property (weak, nonatomic) IBOutlet UILabel *boldFont6;
@property (weak, nonatomic) IBOutlet UILabel *boldFont7;
@property (weak, nonatomic) IBOutlet UILabel *boldFont8;



@property (weak, nonatomic) IBOutlet UILabel *extraBoldFont1;
@property (weak, nonatomic) IBOutlet UILabel *extraBoldFont2;
@property (weak, nonatomic) IBOutlet UILabel *extraBoldFont3;
@property (weak, nonatomic) IBOutlet UILabel *extraBoldFont4;
@property (weak, nonatomic) IBOutlet UILabel *extraBoldFont5;
@property (weak, nonatomic) IBOutlet UILabel *extraBoldFont6;
@property (weak, nonatomic) IBOutlet UILabel *extraBoldFont7;
@property (weak, nonatomic) IBOutlet UILabel *extraBoldFont8;


@property (weak, nonatomic) IBOutlet UILabel *thinFont1;
@property (weak, nonatomic) IBOutlet UILabel *thinFont2;
@property (weak, nonatomic) IBOutlet UILabel *thinFont3;
@property (weak, nonatomic) IBOutlet UILabel *thinFont4;
@property (weak, nonatomic) IBOutlet UILabel *thinFont5;
@property (weak, nonatomic) IBOutlet UILabel *thinFont6;
@property (weak, nonatomic) IBOutlet UILabel *thinFont7;
@property (weak, nonatomic) IBOutlet UILabel *thinFont8;



@property (nonatomic, strong) UIBarButtonItem	*addButton;

-(void)createButtonMenu;
-(void)setNavigationBarHidden:(BOOL)hidden;
-(void)setLogo;
-(void)setStyleLogin;
-(void)setStylePost;
-(void)setMenuEnabled:(BOOL)enabled;
-(void)createButtonAdd;
-(void)setStyleDefault;
@end
