//
//  CPParser.h
//  CoreParser
//
//  Created by baidu on 15/9/17.
//  Copyright © 2015年 dzpqzb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CPParser : NSObject
- (NSArray*) parserWithString:(NSString*)str error:(NSError* __autoreleasing*)error;
@end
