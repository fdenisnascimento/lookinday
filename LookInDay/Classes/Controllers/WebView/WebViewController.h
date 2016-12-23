//
//  WebViewController.h
//  MensagemDigital
//
//  Created by Denis Nascimento on 6/5/15.
//  Copyright (c) 2015 Denis Nascimento. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface WebViewController : BaseViewController
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *act;
@property (strong, nonatomic) NSString *url;

@end
