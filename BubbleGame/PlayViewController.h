//
//  ViewController.h
//  MyGame2
//
//  Created by phuong on 1/5/17.
//  Copyright © 2017 ppben. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BubbleUser.h"

@interface PlayViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *timerLabel;
@property (strong, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutlet UILabel *highScoreLabel;
@property (strong, nonatomic) NSMutableArray  *redBalls, *greenBalls, *pinkBalls, *blueBalls, *blackBalls;
@property NSString *sentName;
@property (strong, nonatomic) IBOutlet UIView *userDetailView;
@property (strong, nonatomic) IBOutlet UIView *bubbleContainer;
@property (strong, nonatomic) NSString *previousColorTouched;
@property (strong, nonatomic) IBOutlet UILabel *countDownLabel;

@end

