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
    @synchronized(self) {
        if (self.demoNoticeView) return;
        
        self.demoNoticeView = [[ACDemoOnTopNoticeView alloc] initWithFrame:CGRectMake(0, 0, 0, 44)];
        
        __block __weak ACNoticeView *notice = self.demoNoticeView;
        [self.demoNoticeView showInView:self.view
                               animated:YES
                      dismissAfterDelay:2.0
                             completion:^{
                                 NSLog(@"completed");
                                 if (self.demoNoticeView == notice) {
                                     self.demoNoticeView = nil;
                                 }
                             }];
    }
}

- (IBAction)showButtonTapped:(id)sender {
    @synchronized(self) {
        if (self.demoNoticeView) return;
        
        self.demoNoticeView = [[ACDemoOnTopNoticeView alloc] initWithFrame:CGRectMake(0, 0, 0, 44)];
        
        __block __weak ACNoticeView *notice = self.demoNoticeView;
        __block __weak ACViewController *this = self;
        [self.demoNoticeView setDismissOnTap:YES completion:^{
            NSLog(@"completed");
            if (this.demoNoticeView == notice) {
                this.demoNoticeView = nil;
            }
        }];
        [self.demoNoticeView showInView:self.view
                               animated:YES
                             completion:nil];
    }
}

- (IBAction)dismissButtonTapped:(id)sender {
    @synchronized(self) {
        
        __block __weak ACNoticeView *notice = self.demoNoticeView;
        
        [self.demoNoticeView dismissAfterDelay:0
                                      animated:YES
                                    completion:^{
                                        NSLog(@"dismissed");
                                        if (self.demoNoticeView == notice) {
                                            self.demoNoticeView = nil;
                                        }
                                    }];
    }
}

- (IBAction)slideDownButtonTapped:(id)sender {
    @synchronized(self) {
        if (self.demoNoticeView) return;
        
        self.demoNoticeView = [[ACDemoInlineNoticeView alloc] initWithFrame:CGRectMake(0, 0, 0, 44)];
        
        __block __weak ACNoticeView *notice = self.demoNoticeView;
        [self.demoNoticeView showInView:self.view
                               animated:YES
                      dismissAfterDelay:2.0
                             completion:^{
                                 NSLog(@"completed");
                                 if (self.demoNoticeView == notice) {
                                     self.demoNoticeView = nil;
                                 }
                             }];
    }
}


@end
