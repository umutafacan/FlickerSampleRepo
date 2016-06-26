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

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic,strong) NSMutableArray *arrayPhotos;

@property (nonatomic) int currentPage;


@property (nonatomic,strong) NSMutableArray *arraySearch;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableViewSearch;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightTableView;

@property (nonatomic,strong) NSString *titleForSearchTable;

@property (nonatomic,strong) NSString *searchText;


@end

@implementation ViewController

#pragma mark - LIFE
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setDelegates];
    
    [self configureInfiniteScrolling];
    
    [self initializeServices];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - INITIALIZERS
-(void)initializeServices
{
    [self getRecentPhotos];
    
}

-(void)configureInfiniteScrolling
{
    
    [_collectionView addInfiniteScrollingWithActionHandler:^{
        [self getRecentPhotosAtNextPage];
    }];
    
}

-(void)setDelegates
{
    _collectionView.delegate=self;
    _collectionView.dataSource=self;
    _searchBar.delegate=self;
    _tableViewSearch.delegate=self;
    _tableViewSearch.dataSource=self;
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



#pragma mark - Search Bar Delegates

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{

    return YES;
    
}


-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{


}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{


}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self searchWithText:searchBar.text];
    [self hideSearchTableViewWith:YES];
    [searchBar resignFirstResponder];

}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{


}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{


}


#pragma mark - TableView Delegates

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    return cell;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arraySearch.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{


}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Hot Tags";

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


-(void)searchWithText:(NSString *)text {
    
    _searchText=text;
    
    [ServiceManager getSearchPhotosAtPage:1 withSearchText:text
                           withCompletion:^(FARecentPhotosResponse *response) {
                               
                               _currentPage = response.photos.page;
                               
                               if (_currentPage == response.photos.pages) {
                                   _collectionView.showsInfiniteScrolling = NO;
                               }
                               _arrayPhotos = [NSMutableArray arrayWithArray:response.photos.photo];
                               [_collectionView reloadData];
  
                               
                               
                           } failure:^(NSError *error) {
                               
                               
                           }];
    

}


-(void)getNextPageForSearchText{
    
    _currentPage++;
    
    [ServiceManager getSearchPhotosAtPage:_currentPage withSearchText:_searchText
                           withCompletion:^(FARecentPhotosResponse *response) {
                               
                               _currentPage = response.photos.page;
                               if (_currentPage == response.photos.pages) {
                                   _collectionView.showsInfiniteScrolling = NO;
                               }
                               [_arrayPhotos addObjectsFromArray: response.photos.photo];
                               [_collectionView reloadData];
                               [_collectionView.infiniteScrollingView stopAnimating];
                               
                               
                               
                           } failure:^(NSError *error) {
                               
                               
                           }];
    
    
}




-(void)getReleatedTagsWith:(NSString*)text
{

    [ServiceManager getReleatedTagsListWith:text withCompletion:^(FAReleatedTagResponse *response) {
        
    } failure:^(NSError *error) {
        
    }];
}

-(void)getHottestTags
{

    [ServiceManager getHotTagsListWithCompletion:^(FAHotTagResponse *response) {
        
    } failure:^(NSError *error) {
        
    }];

}

#pragma mark - UI Configurators


-(void)hideSearchTableViewWith:(BOOL)animated
{

    
    
    
}

-(void)showTableViewWith:(BOOL)animated
{

    
    

}

-(void)configureSearchTableForHottags
{
    

    
}

-(void)configureSearchTableForReleatedTags
{


}






@end

