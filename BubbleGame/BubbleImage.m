//
//  BubbleImage.m
//  MyGam
//
//  Created by phuong on 28/4/17.
//  Copyright © 2017 ppben. All rights reserved.
//

#import "BubbleImage.h"
#import "AppDelegate.h"

@implementation BubbleImage

@synthesize mark, color;

-(id) initWithColor:(NSString *)theColor atPoint:(CGPoint)point{
   
    self =[super init];
    if (self){
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        UIImage *image = [[UIImage alloc] initWithContentsOfFile:[appDelegate getImageFilePath:theColor]];
        [self setImage:image forState:UIControlStateNormal];
        [self setFrame:CGRectMake(point.x, point.y, BUBBLE_WIDTH, BUBBLE_HEIGHT)];
        self.contentMode = UIViewContentModeScaleToFill;
        [self setUserInteractionEnabled:YES];
        self.mark = [appDelegate getMark:theColor];
        self.color = theColor;
        return self;
    }
    return nil;
}
-  (void)viewDidLoad {
}
    
-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    if (CGRectContainsPoint(self.bounds, point)) {
        return true;
    } else {
        return false;
    }
}

@end
