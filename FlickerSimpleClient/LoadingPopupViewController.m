//
//  LoadingPopupViewController.m
//  public
//
//  Created by umut on 4/16/16.
//  Copyright © 2016 Happy Hours. All rights reserved.
//

#import "LoadingPopupViewController.h"
#import <DRPLoadingSpinner/DRPLoadingSpinner.h>
@interface LoadingPopupViewController ()
@property (nonatomic,strong) DRPLoadingSpinner *spinner;
@end

@implementation LoadingPopupViewController


- (instancetype)init
{
    if (self = [super init]) {
        self.contentSizeInPopup = CGSizeMake(50, 50);
        self.landscapeContentSizeInPopup = CGSizeMake(50, 50);
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.layer.cornerRadius = 25.f;

    
    _spinner = [[DRPLoadingSpinner alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
    _spinner.colorSequence = [NSArray arrayWithObject:UIColorFromRGB(0X00796B)];
    _spinner.lineWidth = 3.0f;
    [self.view addSubview:_spinner];
   


    // Do any additional setup after loading the view from its nib.
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [_spinner startAnimating];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
