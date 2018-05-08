#import "Measurement.h"
#import "TestUtility.h"

@implementation Measurement
@dynamic name, startTime, duration, ip, asn, asnName, country, networkName, networkType, state, blocking, input, category, result;

+ (NSDictionary *)defaultValuesForEntity {
    //defailt test to failure in case onEntry is never called
    return @{@"startTime": [NSDate date], @"duration" : [NSNumber numberWithInt:0], @"blocking": [NSNumber numberWithInt:MEASUREMENT_FAILURE]};
}

-(void)setAsnAndCalculateName:(NSString *)asn{
    //TODO-ART calculate asnname
    self.asnName = @"Vodafone";
    self.asn = asn;
}

-(void)setStartTimeWithUTCstr:(NSString*)dateStr{
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *localDate = [dateFormatter dateFromString:dateStr];
    self.startTime = localDate;
}

- (NSString*)getFile:(NSString*)ext{
    //log files are unique for web_connectivity test
    if ([self.name isEqualToString:@"web_connectivity"] && [ext isEqualToString:@"log"]){
        return [NSString stringWithFormat:@"%@-%@.%@", self.result.name, self.result.Id, ext];
    }
    return [NSString stringWithFormat:@"%@-%@.%@", self.result.name, self.Id, ext];
}

-(NSString*)getReportFile{
    return [self getFile:@"json"];
}

-(NSString*)getLogFile{
    return [self getFile:@"log"];
}

-(void)save{
    [self commit];
    NSLog(@"---- START LOGGING MEASUREMENT OBJECT----");
    NSLog(@"%@", self);
    NSLog(@"---- END LOGGING MEASUREMENT OBJECT----");
    /*
     NSLog(@"---- START LOGGING MEASUREMENT OBJECT----");
     NSLog(@"%@", self);
     NSLog(@"---- END LOGGING MEASUREMENT OBJECT----");
    NSLog(@"name %@", self.name);
    NSLog(@"startTime %@", self.startTime);
    NSLog(@"endTime %@", self.endTime);
    NSLog(@"ip %@", self.ip);
    NSLog(@"asn %@", self.asn);
    NSLog(@"country %@", self.country);
    NSLog(@"networkName %@", self.networkName);
    NSLog(@"networkType %@", self.networkType);
    NSLog(@"state %ud", self.state);
    NSLog(@"blocking %ld", self.blocking);
     NSLog(@"logFile %@", [self getLogFile]);
     NSLog(@"reportFile %@", [self getReportFile]);
    //NSLog(@"reportId %@", self.reportId);
    NSLog(@"input %@", self.input);
    NSLog(@"category %@", self.category);
    NSLog(@"resultId %ld", self.resultId);
     */
}

-(void)deleteObject{
    [TestUtility removeFile:[self getLogFile]];
    [TestUtility removeFile:[self getReportFile]];
    [self remove];
}

@end
