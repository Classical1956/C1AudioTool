//
//  C1AudioTool.h
//  Pods
//
//  Created by 李磊 on 2017/4/13.
//
//

#import <Foundation/Foundation.h>
#import "C1AudioPlayerDelegate.h"

#define AUDIOTOOL ([C1AudioTool shareInstance])

@interface C1AudioTool : NSObject <C1AudioPlayerDelegate>

+ (instancetype)shareInstance;
- (void)backgroupPlay;
@end
