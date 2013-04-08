//
//  ACNoticeView.m
//  NoticeViewDemo
//
//  Created by Arnaud Coomans on 4/7/13.
//  Copyright (c) 2013 acoomans. All rights reserved.
//

#import "ACNoticeView.h"

//static NSTimeInterval kACNoticeViewDelay = 2.0;
static NSTimeInterval kACNoticeViewDuration = 0.28;

@implementation ACNoticeView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.appearOnTop = NO;
        self.dismissOnTap = YES;
        //self.dismissAfterDelay = YES;
        //self.delay = kACNoticeViewDelay;
        self.animationDuration = kACNoticeViewDuration;
        //self.completion = nil;
        
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleBottomMargin;
    }
    return self;
}


#pragma mark - visibility

- (void)showInView:(UIView*)view animated:(BOOL)animated completion:(void (^)(void))completion {
    self.frame = CGRectMake(0,
                            -CGRectGetHeight(self.bounds),
                            CGRectGetWidth(view.bounds),
                            CGRectGetHeight(self.bounds)
                            );
    [view addSubview:self];
    [UIView animateWithDuration:(animated ? self.animationDuration : 0)
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.frame = CGRectOffset(self.frame, 0, CGRectGetHeight(self.bounds));
                     }
                     completion:^(BOOL finished) {
                         if (completion) {
                             completion();
                         }
                     }];
}

- (void)dismissAfterDelay:(NSTimeInterval)delay animated:(BOOL)animated completion:(void (^)(void))completion {
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [UIView animateWithDuration:(animated ? self.animationDuration : 0)
                              delay:0
                            options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             self.frame = CGRectOffset(self.frame, 0, -CGRectGetHeight(self.bounds));
                         }
                         completion:^(BOOL finished) {
                             if (completion) {
                                 completion();
                             }
                             [self removeFromSuperview];
                         }];
    });
}


- (void)showInView:(UIView*)view
          animated:(BOOL)animated
 dismissAfterDelay:(NSTimeInterval)delay
        completion:(void (^)(void))completion {
    
    [self showInView:view
            animated:animated
          completion:^{
              [self dismissAfterDelay:delay
                             animated:animated
                           completion:^{
                               completion();
                           }];
          }];
}


@end
