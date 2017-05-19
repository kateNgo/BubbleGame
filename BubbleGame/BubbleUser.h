//
//  BubbleUser.h
//  MyGame2
//
//  Created by phuong on 3/5/17.
//  Copyright © 2017 ppben. All rights reserved.
//

#import <Foundation/Foundation.h>

#define BubbleUserName  "name"
#define BubbleUserScore  "score"
#define BubbleUserGameTimer  "gameTimer"
#define BubbleUserMaxNumberOfBubbles  "maxNumberOfBubbles"
#define BubbleUserHighestScore  "highestScore"


@interface BubbleUser : NSObject <NSCoding>

@property (strong, nonatomic ) NSString *name;
@property float score;
@property float highestScore;
@property int maxNumberOfBubbles;
@property int gameTimer;

-(id) initWithName:(NSString *)theName;
-(id) initWithName:(NSString *)theName andScore:(float) theScore;
-(void) addPoint:(float)addedPoint;
@end
