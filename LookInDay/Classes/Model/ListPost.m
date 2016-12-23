//
//  Store.m
//  Fidelino
//
//  Created by Denis Nascimento on 4/15/15.
//  Copyright (c) 2015 Denis Nascimento. All rights reserved.
//

#import "ListPost.h"

@implementation ListPost

@dynamic descricao;
@dynamic postType;
@dynamic user_id;
@dynamic photoName;
@dynamic image1;
@dynamic image2;
@dynamic  user;

+(NSArray*)posts
{
  PFQuery *query = [PFQuery queryWithClassName:@"Posts"];
  [query orderByDescending:@"createdAt"];
  return [query findObjects];
}

+ (void)load
{
  [self registerSubclass];
}


+ (NSString *)parseClassName {
  return @"Posts";
}

@end
