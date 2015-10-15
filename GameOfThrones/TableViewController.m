//
//  TableViewController.m
//  GameOfThrones
//
//  Created by tooshyo on 10/15/15.
//  Copyright © 2015 tooshyo. All rights reserved.
//

#import "TableViewController.h"
#import "CharacterItem.h"
#import "CustomTableViewCell.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSURL *targetURL = [NSURL URLWithString:@"http://gameofthrones.wikia.com/api/v1/Articles/Top?expand=1&category=Characters&limit=75"];
    
    NSURLSession *session =[NSURLSession sharedSession];
    
    NSURLSessionDownloadTask *task = [session downloadTaskWithURL:targetURL completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        
        NSData *jsonData = [[NSData alloc] initWithContentsOfURL:location];
        
        NSDictionary *dataDictionaryWithJsonData = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
        //    NSLog(@"%@",dataDictionary);
        
        self.charactersMutableArray = [NSMutableArray array];
        
        NSArray *charactersTemporaryArray = [dataDictionaryWithJsonData objectForKey:@"items"];
        
        for (NSDictionary *characterLoopDictionary in charactersTemporaryArray) {
            CharacterItem *characterFromItem = [CharacterItem blogPostWithTitle:[characterLoopDictionary objectForKey:@"title"]];
            characterFromItem.abstract = [characterLoopDictionary objectForKey:@"abstract"];
            characterFromItem.thumbnail = [characterLoopDictionary objectForKey:@"thumbnail"];
            //        blogPost.date = [bpDictionary objectForKey:@"date"];
            characterFromItem.url = [NSURL URLWithString:[characterLoopDictionary objectForKey:@"url"]];
            [self.charactersMutableArray addObject:characterFromItem];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
    }];
    [task resume];
    
}

    

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.charactersMutableArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    CharacterItem *characterFromItem = [self.charactersMutableArray objectAtIndex:indexPath.row];
    cell.thumbnailView.image = [UIImage imageNamed:@"got.png"];
    
    if ( [characterFromItem.thumbnail isKindOfClass:[NSString class]]) {
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDownloadTask *task = [session downloadTaskWithURL:characterFromItem.thumbnailURL completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
            NSData *imageData = [[NSData alloc] initWithContentsOfURL:location];
            UIImage *image = [UIImage imageWithData:imageData];
            dispatch_async(dispatch_get_main_queue(), ^{
                cell.thumbnailView.image = image;
            });
        }];
        [task resume];
        
    }
    
    cell.characterName.text = characterFromItem.title;
    cell.characterAbstract.text = characterFromItem.abstract;
    return cell;
}



- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}



@end
