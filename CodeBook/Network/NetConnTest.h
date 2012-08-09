//
//  NetConnTest.h
//  NetworkStatus
//
//  Created by Gim Jeong hee on 12. 8. 6..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NetConnTest : NSObject

@property (nonatomic,strong) NSString *netStatus;
@property (nonatomic,strong) NSString *ipAddress;

- (BOOL)connectedToNetwork;
@end
