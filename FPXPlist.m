//
//  FPXPlist.m
//  fpx
//
//  Created by Yusuke SHIBATA on 2013/03/18.
//  Copyright (c) 2013年 Yusuke SHIBATA. All rights reserved.
//

#import "FPXPlist.h"

@implementation FPXPlist

+ (NSString *)name {
    NSString *p = [[NSBundle mainBundle] bundlePath];
    return [[p lastPathComponent] stringByDeletingPathExtension];
}
+ (NSString *)path {
    NSString *p = [[NSBundle mainBundle] bundlePath];
    return [[p stringByDeletingPathExtension] stringByAppendingPathExtension:@"plist"];
}
+ (BOOL)exists {
    NSFileManager *fm = [NSFileManager defaultManager];
    return [fm fileExistsAtPath:[FPXPlist path]];
}

+ (void)store: (NSDictionary *)dic {
    [dic writeToFile:[FPXPlist path] atomically:YES];
}

+ (NSDictionary *)retrieve {
    return [NSDictionary dictionaryWithContentsOfFile:[FPXPlist path]];
}

@end
