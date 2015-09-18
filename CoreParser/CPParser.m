//
//  CPParser.m
//  CoreParser
//
//  Created by baidu on 15/9/17.
//  Copyright © 2015年 dzpqzb. All rights reserved.
//

#import "CPParser.h"
#import "CPToken.h"

char HASH_BREAK_IDENTIFIER[] = "()*+ - / ;";
BOOL CharIsBreakIdentifer(unichar c) {
    if (c == ' ') {
        return NO;
    }

    int index =  c % 10;
    if (HASH_BREAK_IDENTIFIER[index] == c) {
        return YES;
    }
    return NO;
}



typedef struct  {
    char* buffer;
    int length;
    int cursor;
}CPTokenBuffer;


void CPBufferIncrease(CPTokenBuffer* buffer) {
    int stepLength = 20;
    int length = buffer->length + stepLength;
    char* tempBuff = malloc(sizeof(char)*length);
    memset(tempBuff, 0, length);
    if (buffer->length > 0) {
        memcpy(tempBuff, buffer->buffer, buffer->length);
    }
    buffer->buffer = tempBuff;
    buffer->length = length;
}

CPTokenBuffer CPCreateBuffer() {
    CPTokenBuffer* buffer = malloc(sizeof(CPTokenBuffer));
    buffer->buffer = NULL;
    buffer->length = 0;
    CPBufferIncrease(buffer);
    buffer->cursor = 0;
    return *buffer;
};

void CPBufferRelease(CPTokenBuffer* buffer) {
    if (buffer->length > 0) {
        free(buffer->buffer);
    }
    free(buffer);
}


void CPBufferPushChar(CPTokenBuffer* buffer,  unichar c) {
    if (buffer->cursor == buffer->length) {
        CPBufferIncrease(buffer);
    }
    buffer->buffer[buffer->cursor] = c;
    buffer->cursor++;
}


void CPBufferClear(CPTokenBuffer* buffer)
{
    memset(buffer->buffer, 0, buffer->length);
    buffer->cursor = 0;
}


CPToken* CPPopToken(CPTokenBuffer* buffer) {
    CPToken* token = [CPToken new];
    CPBufferPushChar(buffer, '\0');
    token.text = [[NSString alloc] initWithCString:buffer->buffer encoding:NSUTF8StringEncoding];
    CPBufferClear(buffer);
    return token;
}

typedef enum : NSUInteger {
    Begin,
    InInterger,
    InFloat,
    InIdentifier
} CPParserState;


@interface CPParser ()
@end


@implementation CPParser
- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

#define Regx_Rule_Number                ('0' <= c && c <= '9')
#define Regx_Rule_Char                  (('a' <= c && c <= 'z') || ('A' <= c && c <= 'Z'))
#define Regx_Rule_Dot                   ('.' == c)
#define Regx_Rule_Parentheses_Left      ('(' == c)

- (NSArray*) parserWithString:(NSString*)str error:(NSError* __autoreleasing*)error
{
    CPParserState state = Begin;
    int count = (int)str.length;
    int index = 0;
    
    CPTokenBuffer tokenBuffer = CPCreateBuffer();
    CPTokenBuffer* bufferP = &tokenBuffer;

    NSMutableArray* tokens = [NSMutableArray new];
    for (; index < count; index++)
    {
        //read a char
        unichar c = [str characterAtIndex:index];
        #define BufferPushChar  CPBufferPushChar(bufferP, c);
        //state mechine
        if (CharIsBreakIdentifer(c)) {
            if (tokenBuffer.cursor > 0) {
                CPToken* token = CPPopToken(bufferP);
                [tokens addObject:token];
            }
            CPBufferPushChar(bufferP, c);
            CPToken* cToken = CPPopToken(bufferP);
            [tokens addObject:cToken];
            state = Begin;
            continue;
        }
        switch (state) {
            case Begin:
            {
                
                if ( Regx_Rule_Char) {
                    state = InIdentifier;
                    BufferPushChar
                }
                else if ( Regx_Rule_Number) {
                    state = InInterger;
                    BufferPushChar
                } else if ( Regx_Rule_Dot) {
                    state = InFloat;
                    BufferPushChar
                } else {
                }
            }
                break;
            case InInterger:
            {
                if (Regx_Rule_Dot) {
                    state = InFloat;
                    BufferPushChar;
                } else if (Regx_Rule_Number) {
                    BufferPushChar;
                }
            }
                break;
            case InFloat:{
                if (Regx_Rule_Number) {
                    BufferPushChar
                }
            }
                break;
            case InIdentifier:
            {
                if (Regx_Rule_Char) {
                    BufferPushChar;
                }
            }
                
                break;
            default:
                break;
        }

    }
    return [tokens copy];
}

@end
