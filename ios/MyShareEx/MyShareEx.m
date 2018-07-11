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
  // @step gather the image and then save to shared directonry
  // then pass the saved file URL to Main App with URL scheme
  [self load:^(NSString *value, UIImage *image, NSString *contentType, NSException *exception) {
    //@step handle url => (WhatsApp/Facebook etc.)
    if  (nil == image && nil != value ){
      image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:value]]];
    }
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd_hh:mm:ss"];
    NSString *timeString = [formatter stringFromDate:date];
    
    NSString* keyName = [NSString stringWithFormat:@"image_%@.png", timeString]; // @"image.png";
    NSLog(@"image with datetime->%@",keyName);
    NSData* pictureData = UIImagePNGRepresentation(image);
    NSString* imageURL = [ShareMaster storeData:pictureData name:keyName];
    // [self performSelector:@selector(lauchHostApp:) withObject:keyName afterDelay:0.1];
    [self lauchHostApp:imageURL];
    [self.extensionContext completeRequestReturningItems:@[] completionHandler:nil];
  }];
  
}

- (void)lauchHostApp:(NSString*)keyName{
  NSString* url = [NSString stringWithFormat:@"%@?imageUrl=%@", KApp_Scheme,keyName];
  NSURL *destinationURL = [NSURL URLWithString: url];
  
  // Get "UIApplication" class name through ASCII Character codes.
  NSString *className = [[NSString alloc] initWithData:[NSData dataWithBytes:(unsigned char []){0x55, 0x49, 0x41, 0x70, 0x70, 0x6C, 0x69, 0x63, 0x61, 0x74, 0x69, 0x6F, 0x6E} length:13] encoding:NSASCIIStringEncoding];
  if (NSClassFromString(className)) {
    id object = [NSClassFromString(className) performSelector:@selector(sharedApplication)];
    [object performSelector:@selector(openURL:) withObject:destinationURL];
  }
}



@end
