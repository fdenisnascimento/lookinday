//
//  THSParseModel.h
//  LookInDay
//
//  Created by Denis Nascimento on 6/29/15.
//  Copyright (c) 2015 Denis Nascimento. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FIRModel.h"



@interface THSModel : FIRModel



+(void)sendPush:(NSString*)message channel:(NSString*)channel;
+(void)subscribeToChannelInBackground;
+(void)logout;
+(void)favoties:(completion)completion;
+(void)dicas:(completion)completion;
+(void)enquetes:(completion)completion;
+(void)looks:(completion)completion;
+(void)myDicas:(completion)completion;
+(void)myEnquetes:(completion)completion;
+(void)myLooks:(completion)completion;
+(void)countFromPost:(NSString*)post completion:(completion)completion;
+(void)hasFavorite:(NSString*)post completion:(completion)completion;
+(void)removeFavorite:(NSString*)favorite completion:(completion)completion;
+(void)allPosts:(completion)completion;
+(void)comments:(NSString*)post completion:(completion)completion;
+(void)removePost:(NSString*)post completion:(completion)completion;

@end
