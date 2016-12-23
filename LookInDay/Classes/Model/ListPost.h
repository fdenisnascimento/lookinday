//
//  Store.h
//  Fidelino
//
//  Created by Denis Nascimento on 4/15/15.
//  Copyright (c) 2015 Denis Nascimento. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "BaseViewController.h"

@interface ListPost : PFObject<PFSubclassing>

@property (nonatomic, strong) NSString  *descricao;
@property (nonatomic, assign) AddPostType postType;
@property (nonatomic, strong) NSString  *user_id;
@property (nonatomic, strong) NSString  *photoName;
@property (nonatomic, strong) PFFile    *image1;
@property (nonatomic, strong) PFFile    *image2;
@property (nonatomic, strong) PFUser *user;

+(NSArray*)posts;
@end
