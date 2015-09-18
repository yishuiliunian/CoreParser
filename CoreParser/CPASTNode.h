//
//  CPASTNode.h
//  CoreParser
//
//  Created by baidu on 15/9/17.
//  Copyright © 2015年 dzpqzb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CPToken.h"
@interface CPASTNode : CPToken
{
    NSMutableArray* _paramters;
}
@property (nonatomic, strong, readonly) NSArray* paramters;
@end
