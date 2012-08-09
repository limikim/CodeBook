//
//  NetConnTest.m
//  NetworkStatus
//
//  Created by Gim Jeong hee on 12. 8. 6..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "NetConnTest.h"
#import <netinet/in.h>
#import <netdb.h>
#import <arpa/inet.h>
#import <SystemConfiguration/SystemConfiguration.h>

@interface NetConnTest()
@property (nonatomic,strong) NSTimer *netChecker;
- (void)netCheckerInTimer;
@end
@implementation NetConnTest

@synthesize netStatus;
@synthesize netChecker;
@synthesize ipAddress;

- (id)init
{
    self = [super init];
    if (self)
    {
        self.netStatus = @"not ready";
        netChecker = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(netCheckerInTimer) userInfo:nil repeats:YES];
    }
    return self;
}
- (void)netCheckerInTimer
{
    if ([self connectedToNetwork])
        self.netStatus = @"connected";
    else 
        self.netStatus = @"notConnected";
    
    self.ipAddress = [self localIPAddress];
    NSLog(@"time : %@ netStatus:%@ ipaddress:%@",[NSDate date], self.netStatus, self.ipAddress);
}
- (BOOL)connectedToNetwork
{
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
        printf("Error.");
        return 0;
    }
    
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    BOOL isWifi = !( flags & kSCNetworkReachabilityFlagsIsWWAN );
    if (isWifi)
        NSLog(@"Wifi....");
    else 
        NSLog(@"Not Wifi...");
    return (isReachable && !needsConnection) ? YES : NO;
    
}

- (NSString *)localIPAddress
{
    char baseHostName[255];
    gethostname(baseHostName, 255);
    
    char hn[255];
    if( [[NSString stringWithCString:baseHostName encoding:NSASCIIStringEncoding]hasSuffix:@".local"] )
    {
        sprintf(hn, "%s", baseHostName);
    }
    else 
    {
        sprintf(hn, "%s.local", baseHostName);
    }
    struct hostent *host = gethostbyname(hn);
    if (host == NULL)
    {
        herror("resolve");
        return NULL;
    }
    else 
    {
        struct in_addr **list = (struct in_addr **)host->h_addr_list;
        return [NSString stringWithCString:inet_ntoa(*list[0]) encoding:NSASCIIStringEncoding];
    }
    return NULL;
}
@end
