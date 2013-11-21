//
//  APPBookmarksViewController.m
//  RssReader
//
//  Created by Hara Kang on 2013. 11. 18..
//  Copyright (c) 2013년 Appcoda. All rights reserved.
//

#import "APPBookmarksViewController.h"
#import "APPDetailViewController.h"

@interface APPBookmarksViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *bookmarks;

@end

@implementation APPBookmarksViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.bookmarksTableView.dataSource = self;
    self.bookmarksTableView.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.bookmarks = [[defaults objectForKey:@"bookmarks"] mutableCopy];
    [super viewWillAppear:animated];
    [self.bookmarksTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.bookmarks.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BookmarkCell" forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BookmarkCell"];
    }
    
    NSDictionary *item = [self.bookmarks objectAtIndex:indexPath.row];
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:1];
    
    titleLabel.text = [NSString stringWithFormat:@"%@", [item objectForKey:@"title"]];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showDetail"]) {
        APPDetailViewController *destinationViewController = segue.destinationViewController;
        
        NSIndexPath *indexPath = [self.bookmarksTableView indexPathForSelectedRow];
        destinationViewController.item = self.bookmarks[indexPath.row];
        
        
    }
}
@end
