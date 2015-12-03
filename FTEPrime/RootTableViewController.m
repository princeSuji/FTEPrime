//
//  RootTableViewController.m
//  FTEPrime
//
//  Created by Sujith Achuthan on 8/31/15.
//  Copyright (c) 2015 Sujith Achuthan. All rights reserved.
//

#import "RootTableViewController.h"

@interface RootTableViewController ()

@end

@implementation RootTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString   stringWithFormat:@"Cell %li",(long)indexPath.section]];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"Cell %li",(long)indexPath.section]];
        
    }
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    
    if (indexPath.row == 0)
    {
        [button setTag:[indexPath row]];
        [button setTitle:@"Admin View" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(adminButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(0, 0,tableView.frame.size.width,cell.frame.size.height);
        [button sizeThatFits:cell.frame.size];
        [button.titleLabel setTextAlignment: NSTextAlignmentCenter];
    }
    else if (indexPath.row == 1)
    {
        [button setTag:[indexPath row]];
        [button setTitle:@"KPI Analyzer" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(kpiButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(0, 0,tableView.frame.size.width,cell.frame.size.height);
        [button sizeThatFits:cell.frame.size];
        [button.titleLabel setTextAlignment: NSTextAlignmentCenter];
    }
    
    [cell.contentView addSubview:button];
    
    return cell;
}

- (void)adminButtonClicked:(id)sender
{
    [self performSegueWithIdentifier:@"adminView" sender:self];
}
- (void)kpiButtonClicked:(id)sender
{
    [self performSegueWithIdentifier:@"kpiView" sender:self];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
