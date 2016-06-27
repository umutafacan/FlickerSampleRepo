//
//  PopupManager.m
//  FlickerSimpleClient
//
//  Created by umut on 6/27/16.
//  Copyright © 2016 umutafacan. All rights reserved.
//

#import "PopupManager.h"

@implementation PopupManager
+(PopupManager *)sharedManager
{
    static PopupManager *_sharedManager = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate,^{ _sharedManager = [[PopupManager alloc]init];});
    
    return  _sharedManager;
}


-(id)init
{
    if (self) {
        _currentPopup=nil;
        _isPopupActive=NO;
        _arrayPopup =[NSMutableArray array];
    }
    return self;
}

- (UIViewController*) topMostController
{
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    
    return topController;
}


-(void)showLoading:(UIViewController*)host completion:(showCompletion)completion
{
    [self hideCurrentPopup];
    LoadingPopupViewController *popupView =  [[LoadingPopupViewController alloc]initWithNibName:@"LoadingPopupViewController" bundle:[NSBundle mainBundle]];
    _popupVC=popupView;
    popupView.contentSizeInPopup = CGSizeMake(50, 50);
    STPopupController *popupController = [[STPopupController alloc] initWithRootViewController:popupView];
    UIView *bgview = [UIView new] ;
    [bgview setBackgroundColor: [UIColor colorWithWhite:0 alpha:0.5]];
    popupController.backgroundView = bgview;
    
    popupController.navigationBarHidden=YES;
    popupController.containerView.layer.cornerRadius = 25.0f;
    [popupController presentInViewController:host completion:completion] ;
    _currentPopup = popupController;
    //    [self.arrayPopup addObject:popupController];
    
}


-(void)hideCurrentPopup
{
    [_currentPopup dismiss];
    
}

-(void)removeAllPopups
{
    [_currentPopup dismissWithCompletion:^{
        
    }];
    /* for (STPopupController *popup in _arrayPopup) {
     [popup dismiss];
     [_arrayPopup removeObject:popup];
     
     }*/
}



@end
