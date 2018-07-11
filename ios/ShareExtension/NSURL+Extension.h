//
//  NSURL+Extension.h
//  ShareExtension
//
//  Created by icoco on 20/04/2018.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL(Extension)

- (NSDictionary*)getPrameters;

- (NSString*)getPrameterValue:(NSString*)name;
@end
