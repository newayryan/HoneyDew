//
//  InvitationDetailViewController.m
//  HoneyDew
//
//  Created by Song Wang on 5/9/15.
//  Copyright (c) 2015 Song Wang. All rights reserved.
//

#import "IncomingInvitationDetailViewController.h"

static const CGFloat kMargin = 10;
static const CGFloat kHeightOfLabel = 40;
static const CGFloat kHeightOfButton = 60;

@interface IncomingInvitationDetailViewController ()

@property (nonatomic, strong) UIButton *acceptInvitationButton;

@end

@implementation IncomingInvitationDetailViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  
  if (self) {
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.restaurantImageView];
    [self.view addSubview:self.nameLabel];
    [self.view addSubview:self.dateLabel];
    [self.view addSubview:self.restaurantNameLabel];
    [self.view addSubview:self.acceptInvitationButton];
  }
  return self;
}


- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  [self manuallyLayoutSubviews];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.

}

#pragma mark -- manually layout subviews

- (void)manuallyLayoutSubviews
{
  self.view.frame = [UIScreen mainScreen].bounds;
  CGFloat contentWidth = self.view.frame.size.width;
  CGFloat remainHeight = self.view.frame.size.height - self.navigationController.navigationBar.frame.size.height;
  self.restaurantImageView.frame = CGRectMake(0, self.navigationController.navigationBar.frame.size.height,
                                              contentWidth,ceilf(remainHeight /2));
  NSLog(@"frame of the view: %@", NSStringFromCGRect(self.view.frame));
  NSLog(@"frame of restaurante image view %@", NSStringFromCGRect(self.restaurantImageView.frame));
  
  self.nameLabel.frame = CGRectMake(0, self.restaurantImageView.frame.size.height + kMargin, contentWidth, kHeightOfLabel);
  NSLog(@"frame of name label: %@", NSStringFromCGRect(self.nameLabel.frame));
  
  self.dateLabel.frame = CGRectMake(0, self.nameLabel.frame.origin.y + self.nameLabel.frame.size.height + kMargin, contentWidth, kHeightOfLabel);
  NSLog(@"frame of date label: %@", NSStringFromCGRect(self.dateLabel.frame));
  
  self.restaurantNameLabel.frame = CGRectMake(0, self.dateLabel.frame.origin.y + self.dateLabel.frame.size.height + kMargin, contentWidth, kHeightOfLabel);
  NSLog(@"frame of restaurante label: %@", NSStringFromCGRect(self.restaurantNameLabel.frame));
  
  self.acceptInvitationButton.frame = CGRectMake(0, self.view.frame.size.height - kHeightOfButton - 4 * kMargin, contentWidth, kHeightOfButton);
  NSLog(@"frame of acception invitation label: %@", NSStringFromCGRect(self.acceptInvitationButton.frame));
}


#pragma mark -- view life cycle

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidDisappear:(BOOL)animated {
  [super viewDidDisappear:animated];
  self.navigationController.navigationBarHidden = YES;
}

#pragma mark -- accessors

- (UIImageView *)restaurantImageView
{
  if (_restaurantImageView == nil) {
    self.restaurantImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back"]];
    self.restaurantImageView.contentMode = UIViewContentModeScaleAspectFill;
  }
  return _restaurantImageView;
}

- (UILabel *)nameLabel
{
  if (_nameLabel == nil) {
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.backgroundColor = [UIColor whiteColor];
    _nameLabel.textColor = [UIColor blueColor];
    _nameLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:14];
    _nameLabel.numberOfLines = 0;
  }
  return _nameLabel;
}

- (UILabel *)dateLabel
{
  if (_dateLabel == nil) {
    _dateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _dateLabel.textAlignment = NSTextAlignmentCenter;
    _dateLabel.backgroundColor = [UIColor whiteColor];
    _dateLabel.textColor = [UIColor blueColor];
    _dateLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:14];
    _dateLabel.numberOfLines = 0;
  }
  return _dateLabel;
}

- (UILabel *)restaurantNameLabel
{
  if (_restaurantNameLabel == nil) {
    _restaurantNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _restaurantNameLabel.textAlignment = NSTextAlignmentCenter;
    _restaurantNameLabel.textColor = [UIColor blueColor];
    _restaurantNameLabel.backgroundColor = [UIColor whiteColor];
    _restaurantNameLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:14];
    _restaurantNameLabel.numberOfLines = 0;
    _restaurantNameLabel.text = @"Bon Jour Restaurante"; //TODO: placeholder
  }
  return _restaurantNameLabel;
}


- (UIButton *)acceptInvitationButton
{
  if (_acceptInvitationButton == nil) {
    _acceptInvitationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _acceptInvitationButton.backgroundColor = [UIColor blueColor];
    [_acceptInvitationButton setTitle:@"Accept Invitation" forState:UIControlStateNormal];
    [_acceptInvitationButton addTarget:self action:@selector(acceptButtonTaped:) forControlEvents:UIControlEventTouchUpInside];
  }
  return _acceptInvitationButton;
}

#pragma mark -- button action

- (void)acceptButtonTaped:(id)sender
{
  NSLog(@"%@", NSStringFromSelector(_cmd));
}




@end
