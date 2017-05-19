//
//  SettingViewController.h
//  MyGame2
//
//  Created by phuong on 4/5/17.
//  Copyright © 2017 ppben. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingViewController : UIViewController

@property (strong, nonatomic) IBOutlet UISlider *timer;
@property (strong, nonatomic) IBOutlet UISlider *numberOfBubbles;
- (IBAction)saveSettingValues:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *gameTimerLabel;
- (IBAction)gameTimerChange:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *maxNumberOfBubblesLabel;
- (IBAction)maxNumberOfBubblesChange:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *saveBtn;

@end
