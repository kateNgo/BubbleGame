//
//  AppDelegate.h
//  MyGame2
//
//  Created by phuong on 1/5/17.
//  Copyright © 2017 ppben. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BubbleUser.h"
#define BUBBLE_WIDTH 35
#define BUBBLE_HEIGHT 35

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong , nonatomic) BubbleUser *currentUser;
@property (nonatomic , assign) bool blockRotation;

-(NSString *)getImageFilePath:(NSString *)color;
-(int)getMark:(NSString *)color;
-(BubbleUser *)getBubbleUserWithName:(NSString *)name;
-(void) saveCurrentUser;
-(NSMutableArray *) getAllUsers;

@end

