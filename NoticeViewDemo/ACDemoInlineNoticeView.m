//
//  ACDemoInlineNoticeView.m
//  NoticeViewDemo
//
//  Created by Arnaud Coomans on 4/7/13.
//  Copyright (c) 2013 acoomans. All rights reserved.
//

#import "ACDemoInlineNoticeView.h"

@implementation ACDemoInlineNoticeView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blueColor];
        self.appearOnTop = NO;
    }
    return self;
}


@end
