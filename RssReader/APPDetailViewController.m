//
//  APPDetailViewController.m
//  RssReader
//
//  Created by gsands on 11/6/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "APPDetailViewController.h"

@interface APPDetailViewController ()

@end

@implementation APPDetailViewController

#pragma mark - Managing the detail item


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.textView.text = [NSString stringWithFormat:@"%@", [self.item objectForKey:@"description"]];
    self.titleTextView.text = [NSString stringWithFormat:@"%@", [self.item objectForKey:@"title"]];
    
    if ([self bookmarkContainsItem:self.item]) {
        self.bookmarkButton.selected = YES;
    } else {
        self.bookmarkButton.selected = NO;
    }
}


- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
//    self.titleViewHeightConstraint.constant = self.titleTextView.contentSize.height;
    
    self.textViewHeightConstraint.constant = self.textView.contentSize.height;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)shareButtonPressed:(UIBarButtonItem *)sender {
    NSString *shareText = self.title;
    NSArray *shareItems = @[shareText];
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:shareItems applicationActivities:nil];
    activityViewController.excludedActivityTypes = @[UIActivityTypeAddToReadingList, UIActivityTypeAirDrop, UIActivityTypeAssignToContact, UIActivityTypeCopyToPasteboard, UIActivityTypePostToFacebook, UIActivityTypePostToFlickr, UIActivityTypePostToTencentWeibo, UIActivityTypePostToVimeo, UIActivityTypePostToWeibo, UIActivityTypePrint, UIActivityTypeSaveToCameraRoll];
    
    [self presentViewController:activityViewController animated:YES completion:nil];
}

- (IBAction)bookmarkButtonPressed {
    
    if ([self bookmark:self.item]) {
        self.bookmarkButton.selected = YES;
    } else {
        self.bookmarkButton.selected = NO;
    }
}
@end
