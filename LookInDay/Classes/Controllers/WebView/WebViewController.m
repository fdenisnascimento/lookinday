//
//  WebViewController.m
//  MensagemDigital
//
//  Created by Denis Nascimento on 6/5/15.
//  Copyright (c) 2015 Denis Nascimento. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController


-(void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  [self setStyleDefault];
}

- (void)viewDidLoad
{
  [super viewDidLoad];

  
//  [self.webView setBackgroundColor:[UIColor clearColor]];
//  [self.webView setOpaque:NO];
//  
//  for(UIView *view in self.webView.subviews){
//    if ([view isKindOfClass:[UIImageView class]]) {
//        // to transparent
//      [view removeFromSuperview];
//    }
//    if ([view isKindOfClass:[UIScrollView class]]) {
//      UIScrollView *sView = (UIScrollView *)view;
//        
//      sView.showsVerticalScrollIndicator = NO;
//      sView.showsHorizontalScrollIndicator = NO;
//      for (UIView* shadowView in [sView subviews]){
//          //to remove shadow
//        if ([shadowView isKindOfClass:[UIImageView class]]) {
//          [shadowView setHidden:TRUE];
//        }
//      }
//    }
//  }
  
  [self updateView];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)updateView
{
  [self.act startAnimating];
    
    if(self.url){
        NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:self.url]];
        [self.webView loadRequest:request];
    }
}


-(void)webViewDidStartLoad:(UIWebView *)webView
{

}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
  
  [self.act stopAnimating];
  
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
  
  [self.act stopAnimating];
  
}

@end
