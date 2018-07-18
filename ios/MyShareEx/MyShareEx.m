//
//  MyShareEx.m
//  MyShareEx
//
//  Created by Adel Grimm on 12.04.18.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactNativeShareExtension.h"
#import <React/RCTBundleURLProvider.h>
#import <React/RCTRootView.h>
#import <React/RCTLog.h>

#import "ShareMaster.h"

@interface MyShareEx : ReactNativeShareExtension
@end

@implementation MyShareEx

RCT_EXPORT_MODULE();

- (UIView*) shareView {
  
  [self loadImageBackToMainApp];
  //@step we do not need show the extension view here
  UIView* result = [[UIView alloc]initWithFrame:CGRectZero];
  return result;
  
  NSURL *jsCodeLocation;
  
  jsCodeLocation = [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index.ios" fallbackResource:nil];
  
  RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                                      moduleName:@"MyShareEx"
                                               initialProperties:nil
                                                   launchOptions:nil];
  rootView.backgroundColor = nil;
  
  return rootView;
}

- (void)loadImageBackToMainApp{
  [self loads:^(NSArray *items, NSException *exception) {
    NSString* buf = @"";
    int i = 1 ;
    for(NSDictionary * item in items){
      NSString* url = [self store2Cache:item  index:i];
      buf = [buf stringByAppendingFormat:@"%@;",url];
      i = i + 1;
    }
    NSRange range = NSMakeRange(0,buf.length -1);
    buf = [buf substringWithRange:range];
    [self lauchHostApp:buf];
    [self.extensionContext completeRequestReturningItems:@[] completionHandler:nil];

  }];
  
}

- (NSString*)store2Cache:(NSDictionary*)item index:(int)index{
  UIImage* image = [item objectForKey:@"image"];
  NSString* value = [item objectForKey:@"val"];
  NSString* contentType = [item objectForKey:@"contentType"];
  if  (nil == image && nil != value ){
    image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:value]]];
  }
  
  NSDate *date = [NSDate date];
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setDateFormat:@"yyyy-MM-dd_hh:mm:ss"];
  NSString *timeString = [formatter stringFromDate:date];
  
  NSString* keyName = [NSString stringWithFormat:@"picked_%d_%@%@",index, timeString,contentType]; // @"image.png";
  NSLog(@"image with datetime->%@, contentType:%@",keyName, contentType);
  NSData* pictureData = UIImagePNGRepresentation(image);
  NSString* imageURL = [ShareMaster storeData:pictureData name:keyName];
  return imageURL;
}


- (void)lauchHostApp:(NSString*)keyName{
  NSString* url = [NSString stringWithFormat:@"%@?imageUrls=%@", KApp_Scheme,keyName];
  NSURL *destinationURL = [NSURL URLWithString: url];
  
  NSLog(@"lauchHostApp:%@",destinationURL);
  
  // Get "UIApplication" class name through ASCII Character codes.
  NSString *className = [[NSString alloc] initWithData:[NSData dataWithBytes:(unsigned char []){0x55, 0x49, 0x41, 0x70, 0x70, 0x6C, 0x69, 0x63, 0x61, 0x74, 0x69, 0x6F, 0x6E} length:13] encoding:NSASCIIStringEncoding];
  if (NSClassFromString(className)) {
    id object = [NSClassFromString(className) performSelector:@selector(sharedApplication)];
    [object performSelector:@selector(openURL:) withObject:destinationURL];
  }
}



@end
