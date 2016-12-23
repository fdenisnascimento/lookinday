//
//  FIRFavorito.h
//  LookInDay
//
//  Created by Denis Nascimento on 6/27/16.
//  Copyright © 2016 Denis Nascimento. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FIRModel.h"
#import "FIRPost.h"

@interface FIRFavorito : FIRModel

@property (nonatomic,strong) FIRPost *post;
@property (nonatomic,strong) FIRUser *user;

-(void)save:(completion)completion;
-(void)config;


@end
