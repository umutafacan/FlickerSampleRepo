//
//  PopupManager.h
//  FlickerSimpleClient
//
//  Created by umut on 6/27/16.
//  Copyright © 2016 umutafacan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <STPopup/STPopup.h>
#import "LoadingPopupViewController.h"
typedef void (^removalCompletion)(void);
typedef void (^showCompletion)(void);

@interface PopupManager : NSObject

+(PopupManager *)sharedManager;
-(id)init;

@property (nonatomic,strong) NSMutableArray *arrayPopup;
@property (nonatomic,strong) STPopupController *currentPopup;
@property (nonatomic) BOOL isPopupActive;
@property (nonatomic,strong) UIViewController *popupVC;

-(void)showLoading:(UIViewController*)host completion:(showCompletion)completion;
-(void)removeAllPopups;


@end
