//
//  CLPlist.h
//  CL
//
//  Created by Yusuke SHIBATA on 2013/03/18.
//  Copyright (c) 2013年 Yusuke SHIBATA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLPlist : NSObject

+ (NSString *)path;
+ (BOOL)exists;
+ (BOOL)ok;
+ (void)store: (NSDictionary *)dic;
+ (NSDictionary *)retrieve;

@end
