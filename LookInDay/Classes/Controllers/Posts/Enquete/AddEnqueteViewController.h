//
//  AddPostViewController.h
//  LookInDay
//
//  Created by Denis Nascimento on 6/17/15.
//  Copyright (c) 2015 Denis Nascimento. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "LPlaceholderTextView.h"

@interface AddEnqueteViewController : BaseViewController
@property (weak, nonatomic) IBOutlet LPlaceholderTextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *btnSend;
@property (nonatomic, assign) AddPostType postType;

@property (weak, nonatomic) IBOutlet UIImageView *imageCapa1;
@property (weak, nonatomic) IBOutlet UIImageView *imageCapa2;
@property (weak, nonatomic) IBOutlet UILabel *labelOU;

- (IBAction)btnSend:(UIButton *)sender;
-(IBAction)didTapImageCapa:(UIButton*)button;
@end
