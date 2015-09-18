//
//  CPAST.m
//  CoreParser
//
//  Created by baidu on 15/9/17.
//  Copyright © 2015年 dzpqzb. All rights reserved.
//

#import "CPAST.h"
#import "CPToken.h"
@implementation CPAST

- (instancetype) initWithTokens:(NSArray*)tokens
{
    self = [super init];
    if (!self) {
        return self;
    }
    [self decodeWithTokens:tokens];
    return self;
}

- (void) decodeWithTokens:(NSArray*)tokens
{
    
}
@end
