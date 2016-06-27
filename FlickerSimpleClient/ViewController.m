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
#import "SearchTableViewCell.h"
#import <JTSImageViewController/JTSImageViewController.h>

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic,strong) NSMutableArray *arrayPhotos;

@property (weak, nonatomic) IBOutlet UIButton *buttonScrollToTop;
@property (nonatomic) int currentPage;

@property (nonatomic,strong) NSMutableArray *arraySearch;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableViewSearch;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightTableView;

@property (nonatomic,strong) NSString *titleForSearchTable;

@property (nonatomic,strong) NSString *searchText;
@property (nonatomic) RetrieveMode retrieveMode;

- (IBAction)buttonScrollToTopTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *buttonRecentPhotos;

- (IBAction)buttonRecentPhotosTapped:(id)sender;

@end

@implementation ViewController

#pragma mark - LIFE
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setDelegates];
    
    [self configureInfiniteScrolling];
    
    [self initializeServices];
    _tableViewSearch.translatesAutoresizingMaskIntoConstraints = NO;

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
    
    [_collectionView.infiniteScrollingView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
    
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
    PhotoCollectionViewCell *cell = (PhotoCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    
    // Create image info
    JTSImageInfo *imageInfo = [[JTSImageInfo alloc] init];
    imageInfo.imageURL = [ServiceManager urlBigPhoto:cell.photo];
    imageInfo.referenceRect = cell.frame;
    imageInfo.referenceView = cell.superview;
    
    // Setup view controller
    JTSImageViewController *imageViewer = [[JTSImageViewController alloc]
                                           initWithImageInfo:imageInfo
                                           mode:JTSImageViewControllerMode_Image
                                           backgroundStyle:JTSImageViewControllerBackgroundOption_Scaled];
    
    // Present the view controller.
    [imageViewer showFromViewController:self transition:JTSImageViewControllerTransition_FromOriginalPosition];

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

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _collectionView) {
        [_searchBar resignFirstResponder];
    }

}


-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if (scrollView == _collectionView) {
        if (velocity.y < -2.5) {
            //show
            _buttonScrollToTop.hidden=NO;
        }else if (velocity.y > 0)
        {
            //hide
            _buttonScrollToTop.hidden=YES;
            
        }
    }
    

}

#pragma mark - Search Bar Delegates

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{

    return YES;
    
}


-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if ([searchBar.text isEqualToString:@""]) {
        [self getHottestTagsAnimated:NO];
    }else
    {
        [self getReleatedTagsWith:searchBar.text animated:NO];
    }

}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    searchBar.text=@"";
    [self hideSearchTableViewWith:YES];
    [searchBar resignFirstResponder];
    
    

}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self searchWithText:searchBar.text];
    [self hideSearchTableViewWith:YES];
    [searchBar resignFirstResponder];

}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    if ([searchBar.text isEqualToString:@""]) {
        [self getHottestTagsAnimated:YES];
    }else
    {
        [self getReleatedTagsWith:searchBar.text animated:YES];
    }
    

}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [self hideSearchTableViewWith:YES];

}


#pragma mark - TableView Delegates

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"searchCell" forIndexPath:indexPath];
    
    if (cell && _arraySearch.count > indexPath.row ) {
        
        FATag *tag = [_arraySearch objectAtIndex:indexPath.row];
        
        [cell configureCellWithText:tag.content];
    }
    return cell;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arraySearch.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [self searchWithText:cell.labelTag.text];
    [self hideSearchTableViewWith:YES];
    [_searchBar resignFirstResponder];

}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return _titleForSearchTable;

}


#pragma mark - Service Methods

-(void)fetchForInfiniteScrolling
{
    switch (_retrieveMode) {
        case RecentPhotoMode:
            [self getRecentPhotosAtNextPage];
            break;
            
        case SearchTextMode:
            [self getNextPageForSearchText];
            break;
            
        default:
            break;
    }

}

-(void)getRecentPhotos
{
    
    _retrieveMode = RecentPhotoMode;
    [_collectionView setContentOffset:CGPointMake(_collectionView.contentOffset.x, 0)];

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
    _retrieveMode = SearchTextMode;
    [_collectionView setContentOffset:CGPointMake(_collectionView.contentOffset.x, 0)];

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
    
    
    
    [ServiceManager getSearchPhotosAtPage:(_currentPage+1) withSearchText:_searchText
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


-(void)getReleatedTagsWith:(NSString*)text animated:(BOOL)animated
{

    [ServiceManager getReleatedTagsListWith:text withCompletion:^(FAReleatedTagResponse *response) {
        
        _arraySearch = [NSMutableArray arrayWithArray:response.tags.tag];
        [self configureSearchTableForReleatedTags];
        
        [self showTableViewWith:animated];
        [_tableViewSearch reloadData];

    } failure:^(NSError *error) {
        
        
    }];
}

-(void)getHottestTagsAnimated:(BOOL)animated
{

    [ServiceManager getHotTagsListWithCompletion:^(FAHotTagResponse *response) {
        
        _arraySearch = [NSMutableArray arrayWithArray:response.hottags.tag];
        [self configureSearchTableForHottags];
        [self showTableViewWith:animated];

        [_tableViewSearch reloadData];

    } failure:^(NSError *error) {
        
        
        
    }];

}

#pragma mark - UI Configurators


-(void)hideSearchTableViewWith:(BOOL)animated
{
    
    for (NSLayoutConstraint *constraint in _tableViewSearch.constraints ) {
        if (constraint.firstAttribute == NSLayoutAttributeHeight)
            _heightTableView = constraint;
    }

    
    [_tableViewSearch layoutIfNeeded];

    
    _heightTableView.constant = 0.0f;
    
    CGRect frame = _tableViewSearch.frame;
    frame.size.height=0;

    [UIView animateWithDuration:0.1f animations:^{
        
        _tableViewSearch.alpha = 0.5;
        [_tableViewSearch setFrame:frame];
        [_tableViewSearch layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        _tableViewSearch.hidden=YES;
    }];
    
    
    
}

-(void)showTableViewWith:(BOOL)animated
{
    for (NSLayoutConstraint *constraint in _tableViewSearch.constraints ) {
        if (constraint.firstAttribute == NSLayoutAttributeHeight)
        {
            _heightTableView = constraint;
            break;
        }
    }
    
    
    [_tableViewSearch layoutIfNeeded];
    
    _tableViewSearch.hidden=NO;
    
    if (_arraySearch.count > 8) {
        _heightTableView.constant = (30*8 + 30);
    }
    else
    {
        _heightTableView.constant = (30*_arraySearch.count + 30);
    }
    
    
    if (animated) {
        _tableViewSearch.alpha = 0.5;
    }

    [UIView animateWithDuration:0.5f animations:^{
    
        _tableViewSearch.alpha = 1;
        [_tableViewSearch layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        
    }];
    
    

}

-(void)configureSearchTableForHottags
{
    _titleForSearchTable = @"Hot Tags";

    
}

-(void)configureSearchTableForReleatedTags
{
    _titleForSearchTable = @"Releated Tags";

}




#pragma mark - IBActions


- (IBAction)buttonScrollToTopTapped:(id)sender {
    [_collectionView setContentOffset:CGPointMake(_collectionView.contentOffset.x, 0) animated:YES];
    _buttonScrollToTop.hidden=YES;
    
}
- (IBAction)buttonRecentPhotosTapped:(id)sender {
    [self getRecentPhotos];
    
}



@end

