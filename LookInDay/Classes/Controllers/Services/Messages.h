//
//  Messages.h
//
//  Created by Denis Nascimento on 5/21/15
//  Copyright (c) 2015 Ths Solution. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Messages : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *messagesGender;
@property (nonatomic, assign) double messagesIdentifier;
@property (nonatomic, strong) NSString *messagesPath;
@property (nonatomic, strong) NSString *messagesFilename;
@property (nonatomic, strong) NSString *messagesName;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
