//
//  GalleryViewController.m
//  LookInDay
//
//  Created by Denis Nascimento on 11/3/15.
//  Copyright © 2015 Denis Nascimento. All rights reserved.
//

#import "GalleryViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#define MINIMUM_SCALE 1.f
#define  MAXIMUM_SCALE 4.f


@interface GalleryViewController ()<UIScrollViewDelegate>

@end

@implementation GalleryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
  self.title = @"Galeria de imagem";
  [self setStyleDefault];
  
  self.scrollView.minimumZoomScale = MINIMUM_SCALE;
  self.scrollView.maximumZoomScale = MAXIMUM_SCALE;
  
  self.scrollView.delegate=self;

  
  UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
  [doubleTap setNumberOfTapsRequired:2];
  [self.scrollView addGestureRecognizer:doubleTap];
  
  [self updateContent];
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
  return self.imageView;
}

- (void)handleDoubleTap:(UIGestureRecognizer *)gestureRecognizer
{
  
  if(self.scrollView.zoomScale > self.scrollView.minimumZoomScale)
    [self.scrollView setZoomScale:self.scrollView.minimumZoomScale animated:YES];
  else
    [self.scrollView setZoomScale:self.scrollView.maximumZoomScale animated:YES];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateContent
{
  if (self.urlString)
  {

    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.urlString]
                      placeholderImage:[UIImage imageNamed:@"placeholder_post"]
                             completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                               self.imageView.image = image;
                                 if (image.size.width > [UIScreen mainScreen].bounds.size.width){
                                     self.imageView.contentMode = UIViewContentModeScaleAspectFit;
                                 }else{
                                     self.imageView.contentMode = UIViewContentModeScaleAspectFill;
                                 }
                             }];
  }
  
}

@end
