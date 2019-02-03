//
//  HistoryTableViewCell.m
//  LifeCounter
//
//  Created by Dustin Langner on 2/2/19.
//  Copyright © 2019 Dustin Langner. All rights reserved.
//

#import "HistoryTableViewCell.h"

@implementation HistoryTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.moveLabel = [[UILabel alloc]init];
        self.backgroundColor = [UIColor colorWithRed:0.09 green:0.26 blue:0.36 alpha:1.0];
        self.moveLabel.textColor = UIColor.whiteColor;
        [self.moveLabel setFont:[UIFont systemFontOfSize:22]];
        self.moveLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.moveLabel];
        
        self.moveLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.moveLabel.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor].active = YES;
        [self.moveLabel.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor].active = YES;
        [self.moveLabel.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:30].active = YES;
        [self.moveLabel.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-30].active = YES;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
