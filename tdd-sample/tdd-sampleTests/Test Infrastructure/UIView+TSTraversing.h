//
//  UIView+TSTraversing.h
//  tdd-sample
//

#import <UIKit/UIKit.h>


typedef BOOL (^TsViewTest)(UIView *candidate);

@interface UIView (TSTraversing)

- (UIView *)ts_firstViewPassingTest:(TsViewTest)test;
- (UIView *)ts_firstViewOfClass:(Class)klass;
- (UIView *)ts_first:(Class)klass withText:(NSString *)text;
- (UIView *)ts_first:(Class)klass withImageName:(NSString *)imageName;

@end
