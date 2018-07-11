//
//  ShareMaster.m
//  MemoMeisterShare
//
//  Created by Adel Grimm on 12.04.18.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import "ShareMaster.h"

@implementation ShareMaster

+ (NSString*)store:(NSString*) urlStr   name:(NSString*) name {
  NSLog(@"will storeData read from ->%@",urlStr);
  NSFileManager *fileManager = [NSFileManager defaultManager];
   
  NSData* data = [fileManager contentsAtPath:urlStr];
  return [ShareMaster storeData:data name:name];
}

+ (NSString*)storeData:(NSData*) data   name:(NSString*) name {
  NSURL* fileURL = [ShareMaster combineURL:name ];
  NSLog(@"will storeData->%@",fileURL);
  NSError* error;
  BOOL result =[data writeToURL:fileURL options:NSDataWritingAtomic error:&error];
  //  [data writeToURL:fileURL atomically:true];
  NSLog(@"storeData->%@",result ? @"success": @"failed");
  return [fileURL absoluteString];
}

+ (NSURL*)combineURL:(NSString*)name{
  NSURL *groupURL = [ShareMaster getWorkDir];
  NSURL *fileURL = [groupURL URLByAppendingPathComponent:name];
  return fileURL;
}

+ (NSURL*)getWorkDir{
  NSURL *groupURL = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:KApp_Group_ID];
  NSURL* result = [groupURL URLByAppendingPathComponent:@"user_share"];
  [ShareMaster createDirAtSharedContainerPath:[result path]];
  return result;
}

+(void)createDirAtSharedContainerPath:(NSString*)dirPath
{
  BOOL isdir;
  NSError *error = nil;
  
  NSFileManager *mgr = [[NSFileManager alloc]init];

  if (![mgr fileExistsAtPath:dirPath isDirectory:&isdir]) { //create a dir only that does not exists
    if (![mgr createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:&error]) {
      NSLog(@"error while creating dir: %@", error.localizedDescription);
    } else {
      NSLog(@"dir was created....");
    }
  }
}

@end
