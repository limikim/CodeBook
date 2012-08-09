//
//  TimeZoneTest.m
//  CodeTest
//
//  Created by 정희 김 on 12. 8. 7..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "DateTest.h"

@implementation DateTest

static unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit ;

/*
 */
+ (void)dateComptForCurrentLocalTime
{
    // GMT 현재 시간이 나온다.
    NSDate *dateNow = [NSDate date];
    NSLog(@"GMT date : %@", dateNow);
    
    // 달력엔 타임존 정보가  있다.
    NSCalendar *calNow = [NSCalendar currentCalendar];
    NSLog(@"current calendar identifier: %@", [calNow calendarIdentifier]);
    NSLog(@"current calendar timezone : %@", [calNow timeZone]);
    NSLog(@"current calendar locale : %@", [[calNow locale]localeIdentifier]);
   
    // GMT 시간에서 Timezone 에 맞는 시간을 구한다.
    NSDateComponents *cmptForCal = [calNow components:unitFlags fromDate:dateNow];
    NSLog(@"date components From calendar in TimeZone(%@) : %@" , cmptForCal, [[calNow timeZone]name]);
    
    [calNow setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    cmptForCal = [calNow components:unitFlags fromDate:dateNow];
    NSLog(@"date components From calendar in TimeZone(%@) : %@",cmptForCal, [[calNow timeZone]name]);
}

+ (void)dateCreate
{
    // 임의의 GMT date를 생성한다.
    NSDate *tDate = [NSDate dateWithTimeIntervalSinceReferenceDate:1];
    NSLog(@"some date : %@", tDate);
    
    NSCalendar *tCal = [NSCalendar currentCalendar];
    NSLog(@"calendar timezone: %@", [[tCal timeZone]name] );
    
    NSDateComponents *tDateCmpt = [tCal components:unitFlags fromDate:tDate];
    
    NSLog(@"datecompt : %@", tDateCmpt);
    NSLog(@"datecompt timezone : %@", [[tDateCmpt timeZone]name]);

    
}
/*
 결론!!
 NSDateFormatter 에 timezone 과 시간정보를 같이 주고,
 NSDate 로 변환하면 NSDate 는 GMT 시간을 가지므로 GMT 시간으로 변환되어 NSDate 에 저장된다. 
 */
+ (void)dateFormaterWithTimezone
{
    NSTimeZone *anyTimeZone = [NSTimeZone timeZoneWithName:@"EST"];
    
    // DateFormatter 를 세팅할때, 시간과 그것에 맞는 timezone 을 세팅한다.
    NSDateFormatter *dateFormater = [NSDateFormatter new];
    [dateFormater setTimeZone:anyTimeZone];
    [dateFormater setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    // NSDate 는 항상 GMT 의 시간을 가지므로, 위의 타임존 시간대에서 GMT 시간대로 바뀌어서 저장된다.
    NSString *strDate = @"2000-01-02 03:05";
    NSDate *dateFromFormatter = [dateFormater dateFromString:strDate];

    NSLog(@"Time in Timezone(%@) : %@",[anyTimeZone name], strDate);
    NSLog(@"Time in Timezone(GMT) : %@",dateFromFormatter);
    
}
/*
 NSDate엔 GMT Date 값 밖에 가질 수 없다.
  
 */
+ (void)calendar
{
    NSDate *dateinGmt = [NSDate date];  
    NSLog(@"current gmt date : %@", dateinGmt);
    
    NSDateComponents *dateComponentFromCurrentCalendar = [[NSCalendar currentCalendar] components:unitFlags fromDate:dateinGmt];
    
    NSLog(@"component : %@",dateComponentFromCurrentCalendar);
    NSLog(@"current calendar timezone : %@", [[NSCalendar currentCalendar]timeZone]);
    NSLog(@"component timezone : %@", [[dateComponentFromCurrentCalendar timeZone]name]);
}
@end
