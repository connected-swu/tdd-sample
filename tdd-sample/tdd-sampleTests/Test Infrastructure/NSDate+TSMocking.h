//
//  NSDate+TSMocking.h
//  tdd-sample
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define TsStubCurrentDate(CurrentDate) \
NSDate.class stub_method(@selector(date)) \
.and_return(CurrentDate)
#define TsTestDate(Y,M,D,h,m,s) [NSDate ts_dateWithYear:Y month:M day:D hour:h minute:m second:s]

@interface NSDate (TSMocking)
+ (NSDate *)ts_dateWithYear:(NSInteger)year
                      month:(NSInteger)month
                        day:(NSInteger)day
                       hour:(NSInteger)hour
                     minute:(NSInteger)minute
                     second:(NSInteger)second;
@end

NS_ASSUME_NONNULL_END
