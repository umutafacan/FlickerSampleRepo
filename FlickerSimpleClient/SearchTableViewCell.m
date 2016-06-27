//
//  SearchTableViewCell.m
//  FlickerSimpleClient
//
//  Created by umut on 6/27/16.
//  Copyright © 2016 umutafacan. All rights reserved.
//

#import "SearchTableViewCell.h"

@implementation SearchTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configureCellWithText:(NSString *)text
{
    _labelTag.text= text;
}



@end
