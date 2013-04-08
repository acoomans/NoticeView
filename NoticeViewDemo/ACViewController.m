//
//  ACViewController.m
//  NoticeViewDemo
//
//  Created by Arnaud Coomans on 4/7/13.
//  Copyright (c) 2013 acoomans. All rights reserved.
//

#import "ACViewController.h"
#import "ACDemoNoticeView.h"

@interface ACViewController ()

@end

@implementation ACViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)noticeButtonTapped:(id)sender {
    ACDemoNoticeView *demoNoticeView = [[ACDemoNoticeView alloc] initWithFrame:CGRectMake(0, 0, 0, 44)];
    
    [demoNoticeView showInView:self.view
                      animated:YES
             dismissAfterDelay:2.0
                    completion:^{
                        NSLog(@"completed");
                    }];
}

@end
