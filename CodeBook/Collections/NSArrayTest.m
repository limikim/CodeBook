//
//  NSArrayTest.m
//  CodeBook
//
//  Created by 정희 김 on 12. 8. 9..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "NSArrayTest.h"

@implementation NSArrayTest
+ (void)testMain
{
    
}

+ (void)saveFile
{
    NSArray *arr = [NSArray arrayWithObjects:@"abc1",@"bcd2", nil];
[arr writeToFile:@"tt" atomically:YES];

}
@end
