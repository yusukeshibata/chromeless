//
//  CLPlist.m
//  CL
//
//  Created by Yusuke SHIBATA on 2013/03/18.
//  Copyright (c) 2013年 Yusuke SHIBATA. All rights reserved.
//

#import "CLPlist.h"

@implementation CLPlist

+ (NSString *)path {
    NSString *p = [[NSBundle mainBundle] resourcePath];
    return [p stringByAppendingPathComponent:@"CL.plist"];
}
+ (BOOL)exists {
    NSFileManager *fm = [NSFileManager defaultManager];
    return [fm fileExistsAtPath:[CLPlist path]];
}
+ (BOOL)ok {
    if([CLPlist exists] == NO) return NO;
    NSDictionary *dic = [CLPlist retrieve];
    NSString *url = [dic objectForKey:@"url"];
    return (url && url.length > 0);
}
+ (void)store: (NSDictionary *)dic {
    [dic writeToFile:[CLPlist path] atomically:YES];
}
+ (NSDictionary *)retrieve {
    return [NSDictionary dictionaryWithContentsOfFile:[CLPlist path]];
}

@end
