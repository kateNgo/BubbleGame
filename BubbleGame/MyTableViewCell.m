//
//  MyTableViewCell.m
//  MyGame2
//
//  Created by phuong on 15/5/17.
//  Copyright © 2017 ppben. All rights reserved.
//

#import "MyTableViewCell.h"

@implementation MyTableViewCell
@synthesize playerName, playerScore;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
