//
//  FIRScore.h
//  LookInDay
//
//  Created by Denis Nascimento on 6/28/16.
//  Copyright © 2016 Denis Nascimento. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FIRModel.h"
#import "FIRPost.h"

@interface FIRScore : FIRModel

@property (nonatomic,strong) FIRPost *post;
@property (nonatomic, strong) NSNumber* rating;

-(void)save:(completion)completion;
-(void)config;
+(void)ratingFromPost:(NSString*)post completion:(completion)completion;

@end
