//
//  PostFotoViewController.m
//  RosAvtoDengi
//
//  Created by Viktor on 04.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import "PostFotoViewController.h"

@interface PostFotoViewController ()
@property (weak, nonatomic) IBOutlet UIButton *postButton;
@property (weak, nonatomic) IBOutlet UIButton *backButton;

@end

@implementation PostFotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.backButton addTarget:self action:@selector(backButtonAction)
              forControlEvents:UIControlEventTouchUpInside];
    [self.postButton addTarget:self action:@selector(postButtonAction)
              forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void) backButtonAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) postButtonAction {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
