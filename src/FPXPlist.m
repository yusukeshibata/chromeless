//
//  FPXPlist.m
//  fpx
//
//  Created by Yusuke SHIBATA on 2013/03/18.
//  Copyright (c) 2013年 Yusuke SHIBATA. All rights reserved.
//

#import "FPXPlist.h"

@implementation FPXPlist

+ (NSString *)path {
    NSString *p = [[NSBundle mainBundle] resourcePath];
    return [p stringByAppendingPathComponent:@"fpx.plist"];
}
+ (BOOL)exists {
    NSFileManager *fm = [NSFileManager defaultManager];
    return [fm fileExistsAtPath:[FPXPlist path]];
}
+ (BOOL)ok {
    if([FPXPlist exists] == NO) return NO;
    NSDictionary *dic = [FPXPlist retrieve];
    NSString *url = [dic objectForKey:@"url"];
    return (url && url.length > 0);
}
+ (void)store: (NSDictionary *)dic {
    [dic writeToFile:[FPXPlist path] atomically:YES];
}
+ (NSDictionary *)retrieve {
    return [NSDictionary dictionaryWithContentsOfFile:[FPXPlist path]];
}

@end
