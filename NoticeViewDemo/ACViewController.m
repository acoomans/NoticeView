//
//  ACViewController.m
//  NoticeViewDemo
//
//  Created by Arnaud Coomans on 4/7/13.
//  Copyright (c) 2013 acoomans. All rights reserved.
//

#import "ACViewController.h"
#import "ACNoticeView.h"
#import "ACDemoOnTopNoticeView.h"
#import "ACDemoInlineNoticeView.h"

@interface ACViewController ()
@property (atomic, strong) ACNoticeView *demoNoticeView;
@end

@implementation ACViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - actions

- (IBAction)showAndDismissButtonTapped:(id)sender {
    if (self.demoNoticeView) return;
    
    self.demoNoticeView = [[ACDemoOnTopNoticeView alloc] initWithFrame:CGRectMake(0, 0, 0, 44)];
    [self.demoNoticeView showInView:self.view
                      animated:YES
             dismissAfterDelay:2.0
                    completion:^{
                        NSLog(@"completed");
                        self.demoNoticeView = nil;
                    }];
}

- (IBAction)showButtonTapped:(id)sender {
    if (self.demoNoticeView) return;
    
    self.demoNoticeView = [[ACDemoOnTopNoticeView alloc] initWithFrame:CGRectMake(0, 0, 0, 44)];
    [self.demoNoticeView showInView:self.view
                           animated:YES
                         completion:nil];
}

- (IBAction)dismissButtonTapped:(id)sender {
    [self.demoNoticeView dismissAfterDelay:0
                                  animated:YES
                                completion:^{
                                    NSLog(@"dismissed");
                                    self.demoNoticeView = nil;
                                }];
}

- (IBAction)slideDownButtonTapped:(id)sender {
    if (self.demoNoticeView) return;
    
    self.demoNoticeView = [[ACDemoInlineNoticeView alloc] initWithFrame:CGRectMake(0, 0, 0, 44)];
    [self.demoNoticeView showInView:self.view
                           animated:YES
                  dismissAfterDelay:2.0
                         completion:^{
                             NSLog(@"completed");
                             self.demoNoticeView = nil;
                         }];
}


@end
