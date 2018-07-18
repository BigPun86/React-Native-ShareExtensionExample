//
//  ShareMaster.h
//  MemoMeisterShare
//
//  Created by Adel Grimm on 12.04.18.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

// Need config this two value bellows:

static NSString *const KApp_Scheme = @"shareScheme://";

static NSString *const  KApp_Group_ID = @"group.memomeister";

@interface ShareMaster : NSObject

+ (NSString*)store:(NSString*) urlStr   name:(NSString*) name;

+ (NSString*)storeData:(NSData*) data   name:(NSString*) name ;

+ (NSURL*)combineURL:(NSString*)name;

@end
