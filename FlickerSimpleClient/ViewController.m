//
//  ViewController.m
//  FlickerSimpleClient
//
//  Created by umut on 24/06/16.
//  Copyright © 2016 umutafacan. All rights reserved.
//

#import "ViewController.h"
#import "PhotoCollectionViewCell.h"
#import "SVPullToRefresh.h"

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic,strong) NSMutableArray *arrayPhotos;
@property (nonatomic) NSUInteger numberOfColumns;
@property (nonatomic) int currentPage;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _numberOfColumns = (NSUInteger)(self.collectionView.bounds.size.width + 5.0f / 75.0f);

    _collectionView.delegate=self;
    _collectionView.dataSource=self;
    
    [_collectionView addInfiniteScrollingWithActionHandler:^{
        [self getRecentPhotosAtNextPage];
    }];

    [self getRecentPhotos];
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - CollectionView Delegates
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{


}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{

    return  [self.arrayPhotos count];
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCollectionViewCell" forIndexPath:indexPath];
    
    
    
    if (cell) {
    
        //NSUInteger index = indexPath.row * _numberOfColumns  + indexPath.section;
        
        [cell configureCellWithPhoto:[self.arrayPhotos objectAtIndex:indexPath.row]];
        
    }
    
    return cell;

}



#pragma mark - Service Methods

-(void)getRecentPhotos
{
    
    
    [ServiceManager getRecentPhotosWithCompletion:^(FARecentPhotosResponse *response) {
        _currentPage = response.photos.page;
        
        if (_currentPage == response.photos.pages) {
            _collectionView.showsInfiniteScrolling = NO;
        }
        _arrayPhotos = [NSMutableArray arrayWithArray:response.photos.photo];
        [_collectionView reloadData];
    
    } failure:^(NSError *error) {
        
    }];

}

-(void)getRecentPhotosAtNextPage
{
    
    [ServiceManager getRecentPhotosAtPage:(_currentPage+1) withCompletion:^(FARecentPhotosResponse *response) {
        _currentPage = response.photos.page;
        if (_currentPage == response.photos.pages) {
            _collectionView.showsInfiniteScrolling = NO;
        }
        [_arrayPhotos addObjectsFromArray: response.photos.photo];
        [_collectionView reloadData];
        [_collectionView.infiniteScrollingView stopAnimating];

        
    } failure:^(NSError *error) {
        
        [_collectionView.infiniteScrollingView stopAnimating];
    }];

}

@end
