//
//  ACNoticeView.h
//  NoticeViewDemo
//
//  Created by Arnaud Coomans on 4/7/13.
//  Copyright (c) 2013 acoomans. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ACNoticeView : UIView

@property (nonatomic, assign) BOOL  appearOnTop;
@property (nonatomic, assign) BOOL  dismissOnTap;
//@property (nonatomic, assign) BOOL  dismissAfterDelay;
//@property (nonatomic, assign) NSTimeInterval delay;
@property (nonatomic, assign) NSTimeInterval animationDuration;
//@property (nonatomic, copy)   void(^completion)();

- (void)showInView:(UIView*)view
          animated:(BOOL)animated
        completion:(void (^)(void))completion;

- (void)dismissAfterDelay:(NSTimeInterval)delay
                 animated:(BOOL)animated
               completion:(void (^)(void))completion;

- (void)showInView:(UIView*)view
          animated:(BOOL)animated
 dismissAfterDelay:(NSTimeInterval)delay
        completion:(void (^)(void))completion;

@end
