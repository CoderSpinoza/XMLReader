//
//  APPMasterViewController.m
//  RssReader
//
//  Created by gsands on 11/6/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "APPMasterViewController.h"

#import "APPDetailViewController.h"

@interface APPMasterViewController () {
    NSXMLParser *parser;
    NSMutableArray *feeds;
    NSMutableDictionary *item;
    NSMutableString *title;
    NSMutableString *link;
    NSMutableString *description;
    NSString *element;
}
@end

@implementation APPMasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    feeds = [[NSMutableArray alloc] init];
    //NSURL *url = [NSURL URLWithString:@"http://images.apple.com/main/rss/hotnews/hotnews.rss"];
    NSString *xmlPath = [[NSBundle mainBundle] pathForResource:@"hotnews" ofType:@"xml"];
    NSData *xmlData = [NSData dataWithContentsOfFile:xmlPath];
    parser = [[NSXMLParser alloc] initWithData:xmlData];
    [parser setDelegate:self];
    [parser setShouldResolveExternalEntities:NO];
    [parser parse];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)bookmarkButtonPressed:(UIButton *)sender {
    UITableViewCell *currentCell = (UITableViewCell *)sender.superview.superview.superview;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:currentCell];
    NSDictionary *selectedItem = [feeds objectAtIndex:indexPath.row];
    [self bookmark:selectedItem];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return feeds.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    
    NSDictionary *cellItem = [feeds objectAtIndex:indexPath.row];
    UILabel *textLabel = (UILabel *)[cell viewWithTag:1];
    UIButton *bookmarkButton = (UIButton *)[cell viewWithTag:2];
    textLabel.text = [[feeds objectAtIndex:indexPath.row] objectForKey: @"title"];
    
    
    if ([self bookmarkContainsItem:cellItem]) {
        bookmarkButton.selected = YES;
    } else {
        bookmarkButton.selected = NO;
    }
    return cell;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    element = elementName;
    
    if ([element isEqualToString:@"item"]) {
        
        item    = [[NSMutableDictionary alloc] init];
        title   = [[NSMutableString alloc] init];
        link    = [[NSMutableString alloc] init];
        description = [[NSMutableString alloc] init];
        
        
    }
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:@"item"]) {
        
        [item setObject:title forKey:@"title"];
        [item setObject:link forKey:@"link"];
        [item setObject:description forKey:@"description"];
        [feeds addObject:[item copy]];
        
    }
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if ([element isEqualToString:@"title"]) {
        [title appendString:string];
    } else if ([element isEqualToString:@"link"]) {
        [link appendString:string];
    } else if ([element isEqualToString:@"description"]) {
        [description appendString:string];
    }
    
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
    [self.tableView reloadData];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        APPDetailViewController *destinationViewController = segue.destinationViewController;
        destinationViewController.item = feeds[indexPath.row];
    }
}

@end
