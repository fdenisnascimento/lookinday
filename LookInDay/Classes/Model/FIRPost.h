//
//  FIRPost.h
//  LookInDay
//
//  Created by Denis Nascimento on 6/27/16.
//  Copyright © 2016 Denis Nascimento. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FIRModel.h"


@interface FIRPost : FIRModel

@property (nonatomic, strong) NSData    *image1;
@property (nonatomic, strong) NSData    *image2;

@property (nonatomic, strong) NSString *userUID;
@property (nonatomic, strong) NSString *photo1;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *photo2;
@property (nonatomic, assign) AddPostType postType;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *descriptionValue;
@property (nonatomic, strong) NSString *userPhoto;
@property (nonatomic, assign) NSNumber *scoreimage1;
@property (nonatomic, assign) NSNumber *scoreimage2;
@property (nonatomic, strong) NSNumber *created;



+(void)updatePost:(FIRPost*)post completion:(completion)completion;
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;
-(void)config;
-(void)savePost:(completion)completion;



@end
