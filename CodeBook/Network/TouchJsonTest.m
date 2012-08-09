//
//  TouchJsonTest.m
//  NetworkStatus
//
//  Created by Gim Jeong hee on 12. 8. 8..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "TouchJsonTest.h"
#import "CJSONSerializer.h"

@implementation TouchJsonTest
+(void)serialization
{
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setValue:@"abc" forKey:@"user_key"];
    [dic setValue:[NSNumber numberWithInt:123] forKey:@"sender_key"];
    
    NSError *error;
    CJSONSerializer *jsonMaker = [CJSONSerializer new];
    NSData *jsonData = [jsonMaker serializeDictionary:dic error:&error];
    
    NSLog(@"json String : %@", [NSString stringWithUTF8String:jsonData.bytes]);
    
    [self serialization2];
    
}

+(void)serialization2
{

    NSError *error;
    CJSONSerializer *jsonMaker = [CJSONSerializer new];
    NSData *jsonData = [jsonMaker serializeString:@"tt" error:&error];
    
    NSLog(@"json String : %@", [NSString stringWithUTF8String:jsonData.bytes]);
    
    
    
}

@end
