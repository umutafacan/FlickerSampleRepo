//
//  PhotoCollectionViewCell.m
//  FlickerSimpleClient
//
//  Created by umut on 6/26/16.
//  Copyright © 2016 umutafacan. All rights reserved.
//

#import "PhotoCollectionViewCell.h"

@implementation PhotoCollectionViewCell


-(void)configureCellWithPhoto:(FAPhoto *)photo
{
    _photo = photo;
    _imageView.allowsAnimations=YES;
    _imageView.managesRequestPriorities=YES;
    [_imageView prepareForReuse];
    [_imageView setImageWithResource:[ServiceManager urlOfPhoto:photo ] targetSize:self.imageView.bounds.size contentMode:DFImageContentModeAspectFill options:nil];
    
    
    
    
}



@end
