//
//  NSURL+Extension.m
//  ShareExtension
//
//  Created by icoco on 20/04/2018.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import "NSURL+Extension.h"
#import <UIKit/UIKit.h>
@implementation NSURL(Extension)

- (NSDictionary*)getPrameters{
  
  NSURLComponents *components = [NSURLComponents componentsWithURL:self resolvingAgainstBaseURL:NO];
  NSArray *queryItems = [components queryItems];
  
  NSMutableDictionary *dict = [NSMutableDictionary new];
  
  for (NSURLQueryItem *item in queryItems)
  {
    [dict setObject:[item value] forKey:[item name]];
  }
  return dict;
}

- (NSString*)getPrameterValue:(NSString*)name{
  
  NSURLComponents *components = [NSURLComponents componentsWithURL:self resolvingAgainstBaseURL:NO];
  NSArray *queryItems = [components queryItems];
  
  NSMutableDictionary *dict = [NSMutableDictionary new];
  
  for (NSURLQueryItem *item in queryItems)
  {
    [dict setObject:[item value] forKey:[item name]];
  }
  
  return [dict valueForKey:name];
}

@end
