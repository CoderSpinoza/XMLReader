//
//  UIViewController+Favorite.h
//  RssReader
//
//  Created by Hara Kang on 2013. 11. 18..
//  Copyright (c) 2013년 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Favorite)

- (BOOL)bookmark:(NSDictionary *)item;
- (BOOL)bookmarkContainsItem:(NSDictionary *)item;

@end
