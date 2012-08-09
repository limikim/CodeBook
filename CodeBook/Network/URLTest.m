//
//  URLTest.m
//  NetworkStatus
//
//  Created by Gim Jeong hee on 12. 8. 7..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "URLTest.h"
#import "CJSONDeserializer.h"

@implementation URLTest
+ (void)test
{
    NSURL *url = [NSURL URLWithString:@"http://80.mintech.kr/connect"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    [request setHTTPMethod:@"GET"];
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *result = [NSURLConnection sendSynchronousRequest:request
                                           returningResponse:&response error:&error];

    NSString *resultString = [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
    NSLog(@"response : \n%@",resultString);
    
    CJSONDeserializer *jsonDeserializer = [CJSONDeserializer deserializer];
    NSDictionary *resultsDictionary = [jsonDeserializer deserializeAsDictionary:result error:&error];
    NSLog(@"Json String : %@", resultsDictionary);
    NSLog(@"status : %@", [resultsDictionary objectForKey:@"status"] );
    
    NSString *api_key = [resultsDictionary objectForKey:@"api_key"];
    NSString *user_id = [resultsDictionary objectForKey:@"user_id"];
    
    ////////////////////////////////////////
    url = [NSURL URLWithString:@"http://80.mintech.kr/startgame"];
    request = [[NSMutableURLRequest alloc]initWithURL:url];
    [request setValue:api_key forHTTPHeaderField:@"api_key"];
    //[request setValue:user_id forHTTPHeaderField:@"user_id"];
    [request setHTTPMethod:@"GET"];
    
    NSMutableString *logHeader = [NSMutableString new];
    NSLog(@"startgame request:\n%@",request);
    NSDictionary *headers = [request allHTTPHeaderFields];
    for(NSString *key in headers)
        [logHeader appendFormat:@"\t%@:\t%@\n",key,[headers objectForKey:key]];
    NSLog(@"\n%@\n",logHeader);
    
    
    result = [NSURLConnection sendSynchronousRequest:request
                                   returningResponse:&response error:&error];
    resultString = [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
    NSLog(@"response : \n%@",resultString);
    
}
@end
