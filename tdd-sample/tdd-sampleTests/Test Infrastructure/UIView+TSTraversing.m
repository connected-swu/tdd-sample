//
//  UIView+TSTraversing.m
//  tdd-sample
//

#import "UIView+TSTraversing.h"


@implementation UIView (TSTraversing)

- (UIView *)ts_firstViewPassingTest:(TsViewTest)test {
    NSMutableArray *viewsToTest = [NSMutableArray arrayWithObject:self];
    while (viewsToTest.count != 0) {
        UIView *candidate = [viewsToTest firstObject];
        [viewsToTest removeObjectAtIndex:0];
        if (test(candidate)) {
            return candidate;
        } else {
            [viewsToTest addObjectsFromArray:candidate.subviews];
        }
    }
    return nil;
}

- (UIView *)ts_firstViewOfClass:(Class)klass {
    return [self ts_firstViewPassingTest:^BOOL(UIView *candidate) {
        return [candidate isKindOfClass:klass];
    }];
}

- (UIView *)ts_first:(Class)klass withText:(NSString *)text {
    return [self ts_firstViewPassingTest:^BOOL(UIView *candidate) {
        BOOL isCorrectType = [candidate isKindOfClass:klass];
        BOOL hasText = NO;
        if ([candidate respondsToSelector:@selector(text)]) {
            hasText = [text isEqualToString:[(id)candidate text]];
        } else if ([candidate respondsToSelector:@selector(attributedText)]) {
            hasText = [text isEqualToString:[[(id)candidate attributedText] string]];
        } else if ([candidate respondsToSelector:@selector(titleForState:)]) {
            hasText = [text isEqualToString:[(id)candidate titleForState:UIControlStateNormal]];
        } else if ([candidate respondsToSelector:@selector(attributedTitleForState:)]) {
            hasText = [text isEqualToString:[[(id)candidate attributedTitleForState:UIControlStateNormal] string]];
        }
        return isCorrectType && hasText;
    }];
}

- (UIView *)ts_first:(Class)klass withImageName:(NSString *)imageName {
    return [self ts_firstViewPassingTest:^BOOL(UIView *candidate) {
        BOOL isCorrectType = [candidate isKindOfClass:klass];
        BOOL hasImage = NO;
        NSData *referenceData = UIImagePNGRepresentation([UIImage imageNamed:imageName]);
        NSData *candidateData;
        if ([candidate respondsToSelector:@selector(imageForState:)]) {
            candidateData = UIImagePNGRepresentation((id)[(id)candidate imageForState:UIControlStateNormal]);
        } else if ([candidate respondsToSelector:@selector(image)]) {
            candidateData = UIImagePNGRepresentation((id)[(id)candidate image]);
        }
        hasImage = [referenceData isEqual:candidateData];
        return isCorrectType && hasImage;
    }];
}

@end
