//
//  TimeZoneTest.m
//  CodeTest
//
//  Created by 정희 김 on 12. 8. 7..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "TimeZoneTest.h"

@implementation TimeZoneTest
+ (void) test
{
    // GMT 현재 시간이 나온다.
    NSDate *dateNow = [NSDate date];
    NSLog(@"date : %@", dateNow);
    
    // 달력엔 타임존 정보도 있다.
    NSCalendar *calNow = [NSCalendar currentCalendar];
    NSLog(@"calendar identifier: %@", [calNow calendarIdentifier]);
    NSLog(@"calendar timezone : %@", [calNow timeZone]);
    NSLog(@"calendar locale : %@", [[calNow locale]localeIdentifier]);
   
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit ;
    NSDateComponents *cmptForCal = [calNow components:unitFlags fromDate:dateNow];
    NSLog(@"dateCompt From calendar : %@" , cmptForCal);
}
@end
