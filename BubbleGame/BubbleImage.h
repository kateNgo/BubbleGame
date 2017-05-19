//
//  BubbleImage.h
//  MyGam
//
//  Created by phuong on 28/4/17.
//  Copyright © 2017 ppben. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BubbleImage : UIButton
@property float mark;
@property (strong, nonatomic) NSString *color;
-(id) initWithColor:(NSString *)color atPoint:(CGPoint)point;
@end
