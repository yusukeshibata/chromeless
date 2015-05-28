//
//  FPXPlist.h
//  fpx
//
//  Created by Yusuke SHIBATA on 2013/03/18.
//  Copyright (c) 2013年 Yusuke SHIBATA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FPXPlist : NSObject

+ (NSString *)path;
+ (BOOL)exists;
+ (void)store: (NSDictionary *)dic;
+ (NSDictionary *)retrieve;

@end
