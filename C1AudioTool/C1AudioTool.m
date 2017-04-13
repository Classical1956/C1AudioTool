//
//  C1AudioTool.m
//  Pods
//
//  Created by 李磊 on 2017/4/13.
//
//

#import "C1AudioTool.h"

@implementation C1AudioTool
+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    static C1AudioTool *tool = nil;
    dispatch_once(&onceToken, ^{
        tool = [[C1AudioTool alloc] init];
    });
    return tool;
}
@end
