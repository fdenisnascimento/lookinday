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

@interface AddPostViewController : BaseViewController
@property (strong, nonatomic) IBOutlet UIButton *imageCapa;
@property (strong, nonatomic) IBOutlet LPlaceholderTextView *textView;
@property (strong, nonatomic) IBOutlet UIButton *btnSend;
@property (nonatomic, assign) AddPostType postType;
- (IBAction)didTapImageCapa:(UIButton*)button;
- (IBAction)btnSend:(UIButton *)sender;
@end
