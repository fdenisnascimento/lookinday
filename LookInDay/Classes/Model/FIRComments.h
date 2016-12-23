//
//  FIRComments.h
//  LookInDay
//
//  Created by Denis Nascimento on 6/27/16.
//  Copyright © 2016 Denis Nascimento. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FIRModel.h"
#import "FIRPost.h"

@interface FIRComments : FIRModel

@property (nonatomic,strong) FIRPost *post;
@property (nonatomic,strong) NSString *comment;
@property (nonatomic,strong) NSString *userName;
@property (nonatomic,strong) NSString *userPhoto;

-(void)save:(completion)completion;
-(void)config;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;



@end
