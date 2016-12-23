//
//  LoginViewController.h
//  MensagemDigital
//
//  Created by Denis Nascimento on 5/18/15.
//  Copyright (c) 2015 Denis Nascimento. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface LoginViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIButton *btnVisitante;
@property (weak, nonatomic) IBOutlet UIButton *btnFacebook;

@property (nonatomic, assign) BOOL fromInterna;

- (IBAction)goToVisitante:(UIButton *)sender;
- (IBAction)goToFacebook:(UIButton *)sender;

@end
