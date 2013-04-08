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


@interface ACNoticeView ()
@property (nonatomic, copy) void(^didDismissOnTap)();
@end


@implementation ACNoticeView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.appearOnTop = YES;
        self.dismissOnTap = YES;
        //self.dismissAfterDelay = YES;
        //self.delay = kACNoticeViewDelay;
        self.animationDuration = kACNoticeViewDuration;
        //self.completion = nil;
        self.didDismissOnTap = nil;
        
        self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
        [self addGestureRecognizer:self.tapGestureRecognizer];
        
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
                         /*
                         self.frame = CGRectOffset(self.frame, 0, CGRectGetHeight(self.bounds));
                         
                         if (!self.appearOnTop) {
                             for (UIView *subview in view.subviews) {
                                 if (subview == self) continue;
                                 subview.frame = CGRectOffset(<#CGRect rect#>, <#CGFloat dx#>, <#CGFloat dy#>)
                                 
                                 
                                 
                                 CGRect frame = subview.frame;
                                 frame.size.height = MIN(frame.size.height, view.frame.size.height - CGRectGetHeight(self.frame));
                                 if (frame.origin.y+frame.size.height < self.view.frame.size.height) {
                                     frame.origin.y += self.noticeViewHeight;
                                 } else {
                                     frame.origin.y -= self.view.frame.size.height - (frame.origin.y+frame.size.height);
                                 }
                                 subview.frame = frame;
                                 
                                 
                                 
                                 
                                 
                             }
                         }
                          */
                         
                         for (UIView *subview in view.subviews) {
                             if (
                                    (subview == self || !self.appearOnTop) &&
                                    ![self viewPositionIsFixedAtBottom:subview]
                                 ) {
                                 subview.frame = CGRectOffset(subview.frame, 0, CGRectGetHeight(self.bounds));
                             }
                         }
                         
                     }
                     completion:^(BOOL finished) {
                         if (completion) {
                             completion();
                         }
                     }];
}

- (BOOL)viewPositionIsFixedAtBottom:(UIView*)view {
    BOOL viewPositionIsFixedAtBottom = (
                                        (view.autoresizingMask & UIViewAutoresizingFlexibleTopMargin) &&
                                        !(view.autoresizingMask & UIViewAutoresizingFlexibleBottomMargin)
    );
    return viewPositionIsFixedAtBottom;
}

- (void)dismissAfterDelay:(NSTimeInterval)delay animated:(BOOL)animated completion:(void (^)(void))completion {
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [UIView animateWithDuration:(animated ? self.animationDuration : 0)
                              delay:0
                            options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             //self.frame = CGRectOffset(self.frame, 0, -CGRectGetHeight(self.bounds));
                             
                             for (UIView *subview in self.superview.subviews) {
                                 if (
                                     (subview == self || !self.appearOnTop) &&
                                     ![self viewPositionIsFixedAtBottom:subview]
                                     ) {
                                     subview.frame = CGRectOffset(subview.frame, 0, -CGRectGetHeight(self.bounds));
                                 }
                             }
                             
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

- (void)setDismissOnTap:(BOOL)dismissOnTap completion:(void (^)(void))completion {
    self.dismissOnTap = dismissOnTap;
    self.didDismissOnTap = completion;
}

#pragma mark - actions

- (void)tapped:(UITapGestureRecognizer*)tapGestureRecognizer {
    if (self.dismissOnTap) {
        [self dismissAfterDelay:0
                       animated:YES
                     completion:^{
                         if (self.didDismissOnTap) {
                             self.didDismissOnTap();
                         }
                     }];
    }
}

@end
