//
//  HomeScreenViewController.m
//  HoneyDew
//
//  Created by Song Wang on 3/31/15.
//  Copyright (c) 2015 Song Wang. All rights reserved.
//

#import "HomeScreenViewController.h"
#import "BloggerCellTableViewCell.h"
#import "HomeBloggerDetailViewController.h"

static const CGFloat kHorizontalMargin = 10;
static const CGFloat kVerticalMargin = 10;
static const CGFloat kLabelHeight = 40;
static const CGFloat kTopVerticalMargin = 80;

@interface HomeScreenViewController ()
@property (nonatomic, strong) UILabel *bloggerLabel;
@property (nonatomic, strong) UICollectionView *bloggerCollectionView;
@property (nonatomic, strong) NSMutableArray *thumbnailArray;
@end

@implementation HomeScreenViewController

#pragma mark - view cycle
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  
  if (self) {
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Home";
    self.tabBarItem.image = [UIImage imageNamed:@"Home-25"];
    
    [self.view addSubview:self.bloggerLabel];
    [self.view addSubview:self.bloggerCollectionView];
  }
  return  self;
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
  // create the data model
  [self createData];
  [self.bloggerCollectionView registerClass:[BloggerCellTableViewCell class] forCellWithReuseIdentifier:@"BlogerCell"];
  [self.bloggerCollectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI
- (UILabel *)bloggerLabel {
  if (_bloggerLabel == nil) {
    _bloggerLabel = [[UILabel alloc] initWithFrame:CGRectMake(kHorizontalMargin, kTopVerticalMargin, self.view.bounds.size.width, kLabelHeight)];
    _bloggerLabel.textAlignment = NSTextAlignmentCenter;
    _bloggerLabel.backgroundColor = [UIColor clearColor];
    _bloggerLabel.textColor = [UIColor colorWithRed:0 green:0.2 blue:0.8 alpha:1.0];
    _bloggerLabel.numberOfLines = 1;
    _bloggerLabel.text = @"Blogger Food";
    _bloggerLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight"  size:30];
  }
  return _bloggerLabel;
}

- (UICollectionView *)bloggerCollectionView {
  if (!_bloggerCollectionView) {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    _bloggerCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(kHorizontalMargin, kTopVerticalMargin + kLabelHeight + kVerticalMargin, self.view.frame.size.width - kHorizontalMargin * 2, self.view.frame.size.height - kTopVerticalMargin - kLabelHeight - kVerticalMargin * 2 - 50) collectionViewLayout:layout];
    _bloggerCollectionView.delegate = self;
    _bloggerCollectionView.dataSource = self;
    _bloggerCollectionView.backgroundColor = [UIColor clearColor];
  }
  return _bloggerCollectionView;
}

#pragma mark - UICollectionView Datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  if (!self.thumbnailArray) return 0;
  return self.thumbnailArray.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  BloggerCellTableViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BlogerCell" forIndexPath:indexPath];
  NSString *imgName = self.thumbnailArray[indexPath.row];
  cell.thumbnail = [UIImage imageNamed:imgName];
  return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  HomeBloggerDetailViewController *blogerDetailVC = [[HomeBloggerDetailViewController alloc] init];
  [self.navigationController pushViewController:blogerDetailVC animated:YES];
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  CGSize retval = CGSizeMake(100, 100);
  return retval;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
  return UIEdgeInsetsMake(20, 20, 20, 20);
}

#pragma mark - Private (data)
- (void)createData {
  self.thumbnailArray = [@[@"back", @"balcony", @"birds", @"bridge", @"ceiling", @"city", @"cityscape", @"game", @"leaves", @"mountain-tops", @"moutains", @"sitting", @"snowy-mountains", @"stars", @"stream", @"sunset", @"two-birds", @"waves"] mutableCopy];
}
@end
