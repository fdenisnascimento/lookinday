//
//  GalleryViewController.h
//  LookInDay
//
//  Created by Denis Nascimento on 11/3/15.
//  Copyright © 2015 Denis Nascimento. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface GalleryViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) NSString *urlString;

@end
