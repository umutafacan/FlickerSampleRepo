//
//  PhotoCollectionViewCell.h
//  FlickerSimpleClient
//
//  Created by umut on 6/26/16.
//  Copyright © 2016 umutafacan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DFImageView.h"



@interface PhotoCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong) FAPhoto *photo;
@property (nonatomic,weak) IBOutlet DFImageView *imageView;
-(void)configureCellWithPhoto:(FAPhoto *)photo;

@end
