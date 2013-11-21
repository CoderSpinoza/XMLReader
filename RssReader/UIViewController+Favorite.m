//
//  UIViewController+Favorite.m
//  RssReader
//
//  Created by Hara Kang on 2013. 11. 18..
//  Copyright (c) 2013년 Appcoda. All rights reserved.
//

#import "UIViewController+Favorite.h"

@implementation UIViewController (Favorite)

- (BOOL)bookmark:(NSDictionary *)item {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray *bookmarks = [[defaults objectForKey:@"bookmarks"] mutableCopy];
    
    if (bookmarks == nil) {
        bookmarks = [[NSMutableArray alloc] init];
    }
    BOOL bookmarked;
    if (![bookmarks containsObject:item]) {
        [bookmarks addObject:item];
        bookmarked = YES;
        [defaults synchronize];
    } else {
        [bookmarks removeObject:item];
        bookmarked = NO;
    }
    [defaults setObject:bookmarks forKey:@"bookmarks"];
    
    return bookmarked;
}

- (BOOL)bookmarkContainsItem:(NSDictionary *)item {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *bookmarks = [defaults objectForKey:@"bookmarks"];
    return [bookmarks containsObject:item];
}

@end
