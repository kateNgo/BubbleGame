//
//  AppDelegate.m
//  MyGame2
//
//  Created by phuong on 1/5/17.
//  Copyright © 2017 ppben. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

@synthesize currentUser;
@synthesize blockRotation;
NSDictionary *imagePathDic;
NSDictionary *markDic;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self settingValues];
    return YES;
}
-(UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window{
    if (self.blockRotation) {
        return UIInterfaceOrientationMaskPortrait;
    }
    return UIInterfaceOrientationMaskAll;
    
}
// Setting initial values for the app
-(void) settingValues{
    NSString *blackBallPath = [[NSBundle mainBundle] pathForResource: @"blackBall" ofType: @"png"];
    NSString *pinkBallPath = [[NSBundle mainBundle] pathForResource: @"pinkBall" ofType: @"png"];
    NSString *blueBallPath = [[NSBundle mainBundle] pathForResource: @"blueBall" ofType: @"png"];
    NSString *greenBallPath = [[NSBundle mainBundle] pathForResource: @"greenBall" ofType: @"png"];
    NSString *redBallPath = [[NSBundle mainBundle] pathForResource: @"redBall" ofType: @"png"];
    imagePathDic = @{@"Red":redBallPath, @"Pink":pinkBallPath, @"Green":greenBallPath, @"Blue":blueBallPath, @"Black":blackBallPath};
    markDic = @{@"Red":@1, @"Pink":@2, @"Green":@5, @"Blue":@8, @"Black":@10};
}
// Return file image path by a color
-(NSString *)getImageFilePath:(NSString *)color{
    return [imagePathDic objectForKey:color];
}
//return point by color
-(int)getMark:(NSString *)color{
    return [[markDic objectForKey:color] intValue];
}
// return an existed user with name or a new one if not exist
-(BubbleUser *)getBubbleUserWithName:(NSString *)name{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BubbleUser* user;
    NSString *key = [NSString stringWithFormat:@"PPBen_%@", name];
    NSData *data = [defaults objectForKey:key];
    if (data){
        // existed user
        user = (BubbleUser *)[NSKeyedUnarchiver unarchiveObjectWithData:data];
        user.score = 0;
    } else {
        user = [[BubbleUser alloc] initWithName:name];
        user.score = 0;
        user.highestScore = 0;
        user.gameTimer = 60;
        user.maxNumberOfBubbles = 15;
    }
    currentUser = user;
    return user;
}
// save current user into UserDefault
-(void) saveCurrentUser{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:currentUser];
    // key of the user start with "PPBen_"
    NSString *key = [NSString stringWithFormat:@"PPBen_%@",currentUser.name];
    [userDefaults setValue:data forKey:key];
    [userDefaults synchronize];
}
// get all users of the game
-(NSMutableArray *)getAllUsers{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *defaultAsDic = [defaults dictionaryRepresentation];
    NSArray *keyArr = [defaultAsDic allKeys];
    NSMutableArray *users = [[NSMutableArray alloc] init];
    for (NSString *key in keyArr)
    {
        if ([key hasPrefix:@"PPBen_" ]){
            NSData *data =[defaults valueForKey:key];
            [users addObject:[NSKeyedUnarchiver unarchiveObjectWithData:data]];
        }
    }
    return users;
}
@end
