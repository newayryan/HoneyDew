//
//  RestauranteCollectionView.m
//  HoneyDew
//
//  Created by Song Wang on 4/19/15.
//  Copyright (c) 2015 Song Wang. All rights reserved.
//

#import "RestauranteCollectionViewController.h"


@interface RestauranteCollectionViewController ()

@property (nonatomic, strong) NSArray *restauranteImages;
@end

@implementation RestauranteCollectionViewController
{
  UICollectionView * _collectionView;
}


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    
  }
  
  return self;
}


- (void)viewDidLoad
{
  [super viewDidLoad];
  CGRect frame = [[UIScreen mainScreen] bounds];
  
  CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
  
  self.view = [[UIView alloc] initWithFrame:CGRectMake(0, statusBarHeight, frame.size.width - 20
                                                       , frame.size.height - statusBarHeight)];
  
  //TODO: use a better layout
  UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
  layout.itemSize = CGSizeMake(100, 100);
  layout.minimumInteritemSpacing = 20;
  layout.minimumLineSpacing = 48;
  layout.sectionInset = UIEdgeInsetsMake(32, 32, 32, 32);
  
  _collectionView=[[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
  
  
  
  [_collectionView setDataSource:self];
  [_collectionView setDelegate:self];
  
  [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CellReuseIdentifier"];
  [_collectionView setBackgroundColor:[UIColor clearColor]];
  
  [self.view addSubview:_collectionView];
  
}

#pragma mark UICollectionView Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  return self.restauranteImages.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellReuseIdentifier" forIndexPath:indexPath];
  UIImageView * imageView = [[UIImageView alloc] initWithImage:self.restauranteImages[indexPath.item % self.restauranteImages.count]];
  imageView.contentMode = UIViewContentModeScaleAspectFill;
  [cell.contentView addSubview:imageView];
  return cell;
}



- (NSArray *)restauranteImages {
  if (!_restauranteImages) {
    _restauranteImages = @[
                     [UIImage imageNamed:@"back"],
                     [UIImage imageNamed:@"balcony"],
                     [UIImage imageNamed:@"birds"],
                     [UIImage imageNamed:@"bridge"],
                     [UIImage imageNamed:@"ceiling"],
                     [UIImage imageNamed:@"city"],
                     [UIImage imageNamed:@"cityscape"],
                     [UIImage imageNamed:@"game"],
                     [UIImage imageNamed:@"leaves"],
                     [UIImage imageNamed:@"mountain-tops"],
                     [UIImage imageNamed:@"mountains"],
                     [UIImage imageNamed:@"sitting"],
                     [UIImage imageNamed:@"snowy-mountains"],
                     [UIImage imageNamed:@"stars"],
                     [UIImage imageNamed:@"stream"],
                     [UIImage imageNamed:@"sunset"],
                     [UIImage imageNamed:@"two-birds"],
                     [UIImage imageNamed:@"waves"]
                     ];
  }
  return _restauranteImages;
}

@end
