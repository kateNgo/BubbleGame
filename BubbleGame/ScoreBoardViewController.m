//
//  ScoreBoardViewController.m
//  MyGame2
//
//  Created by phuong on 15/5/17.
//  Copyright © 2017 ppben. All rights reserved.
//

#import "ScoreBoardViewController.h"
#import "AppDelegate.h"
#import "MyTableViewCell.h"
@interface ScoreBoardViewController ()

@end

@implementation ScoreBoardViewController
@synthesize scoreboardTableView;

NSMutableArray *players;

- (void)viewDidLoad {
    [super viewDidLoad];
}
-(void) viewWillAppear:(BOOL)animated{
    AppDelegate* app= (AppDelegate *)[[UIApplication sharedApplication] delegate];
    players = [[NSMutableArray alloc] init];
    // players contains all users with highest score > 0
    for (BubbleUser *user in [app getAllUsers]){
        if (user.highestScore > 0){
            [players addObject:user];
        }
    }
    [scoreboardTableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return ([players count] > 0 ? [players count]:1);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"PlayerDetail";
    MyTableViewCell *cell = (MyTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PlayerDetail" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    // if No player has highest score, display No Player
    if ([players count] == 0){
        cell.playerName.text =@"No Player";
        cell.playerScore.text = @"";
    } else {
        BubbleUser *player = [players objectAtIndex:indexPath.row];
        cell.playerName.text = player.name;
        cell.playerScore.text = [NSString stringWithFormat:@" %.1f",  player.highestScore];
    }
    return cell;
}
@end
