//
//  SearchTableViewCell.h
//  FlickerSimpleClient
//
//  Created by umut on 6/27/16.
//  Copyright © 2016 umutafacan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchTableViewCell : UITableViewCell

@property (nonatomic,weak) IBOutlet UILabel *labelTag;

-(void)configureCellWithText:(NSString*)text;


@end
