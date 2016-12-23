//
//  PersonalizarViewController.h
//  LookInDay
//
//  Created by Denis Nascimento on 10/20/15.
//  Copyright © 2015 Denis Nascimento. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface PersonalizarViewController : BaseViewController

@property(nonatomic,weak) IBOutlet UIButton *btn1;
@property(nonatomic,weak) IBOutlet UIButton *btn2;
@property(nonatomic,weak) IBOutlet UIButton *btn3;

-(IBAction)setCor:(UIButton*)sender;

@end
