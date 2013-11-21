//
//  APPDetailViewController.h
//  RssReader
//
//  Created by gsands on 11/6/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface APPDetailViewController : UIViewController

@property (strong, nonatomic) NSDictionary *item;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UITextView *titleTextView;
@property (weak, nonatomic) IBOutlet UIButton *bookmarkButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewHeightConstraint;


@end
