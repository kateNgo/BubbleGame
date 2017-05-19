//
//  SettingViewController.m
//  MyGame2
//
//  Created by phuong on 4/5/17.
//  Copyright © 2017 ppben. All rights reserved.
//

#import "SettingViewController.h"
#import "AppDelegate.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

@synthesize timer, numberOfBubbles;
@synthesize gameTimerLabel, maxNumberOfBubblesLabel, saveBtn;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    timer.value  = app.currentUser.gameTimer;
    numberOfBubbles.value = app.currentUser.maxNumberOfBubbles;
    gameTimerLabel.text = [NSString stringWithFormat:@"Game perioded: %i seconds", (int)timer.value];
    maxNumberOfBubblesLabel.text = [NSString stringWithFormat:@"Maximun of bubbles: %i", (int)numberOfBubbles.value];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation
- (IBAction)saveSettingValues:(id)sender {
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (app.currentUser){
        app.currentUser.maxNumberOfBubbles = (int)numberOfBubbles.value;
        app.currentUser.gameTimer = (int)timer.value;
        [app saveCurrentUser];
    }
    [self.navigationController popViewControllerAnimated:NO];
}
- (IBAction)gameTimerChange:(id)sender {
    gameTimerLabel.text = [NSString stringWithFormat:@"Game perioded: %i seconds", (int)timer.value];
}
- (IBAction)maxNumberOfBubblesChange:(id)sender {
    maxNumberOfBubblesLabel.text = [NSString stringWithFormat:@"Maximun of bubbles: %i", (int)numberOfBubbles.value];
}
@end
