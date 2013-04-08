//
//  ACDemoNoticeView.m
//  NoticeViewDemo
//
//  Created by Arnaud Coomans on 4/7/13.
//  Copyright (c) 2013 acoomans. All rights reserved.
//

#import "ACDemoOnTopNoticeView.h"

@implementation ACDemoOnTopNoticeView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        self.alpha = 0.5;
    }
    return self;
}

@end
