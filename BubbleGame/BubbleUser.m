//
//  BubbleUser.m
//  MyGame2
//
//  Created by phuong on 3/5/17.
//  Copyright © 2017 ppben. All rights reserved.
//

#import "BubbleUser.h"

@implementation BubbleUser

@synthesize name, score, gameTimer, maxNumberOfBubbles, highestScore;

-(id) initWithName:(NSString *)theName{
    return [self initWithName:theName andScore:0.0];
}
-(id) initWithName:(NSString *)theName andScore:(float) theScore{
    self = [super init];
    if (self){
        name = theName;
        score = theScore;
    }
    return self;
}
-(void) addPoint:(float)addedPoint{
    score += addedPoint;
}
-(BOOL)isEqual:(BubbleUser *)object{
    return [name isEqualToString :object.name];
}

// implement endcodinh protocol

- (id)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        name = [coder decodeObjectForKey:@BubbleUserName];
        score = [coder decodeFloatForKey:@BubbleUserScore];
        gameTimer = [coder decodeIntForKey:@BubbleUserGameTimer];
        highestScore = [coder decodeFloatForKey:@BubbleUserHighestScore];
        maxNumberOfBubbles = [coder decodeIntForKey:@BubbleUserMaxNumberOfBubbles];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:name forKey:@BubbleUserName];
    [coder encodeFloat:score forKey:@BubbleUserScore];
    [coder encodeInt:gameTimer forKey:@BubbleUserGameTimer];
    [coder encodeInt:maxNumberOfBubbles forKey:@BubbleUserMaxNumberOfBubbles];
    [coder encodeFloat:highestScore forKey:@BubbleUserHighestScore];
}

@end
