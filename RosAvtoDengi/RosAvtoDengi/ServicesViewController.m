//
//  ServicesViewController.m
//  RosAvtoDengi
//
//  Created by Viktor on 26.12.15.
//  Copyright © 2015 Viktor. All rights reserved.
//

#import "ServicesViewController.h"
#import "OnlineViewController.h"

@interface ServicesViewController ()
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *callButton;
@property (weak, nonatomic) IBOutlet UIButton *buttonOnlineView;

@end

@implementation ServicesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.backButton addTarget:self action:@selector(backButtonAction)
              forControlEvents:UIControlEventTouchUpInside];
    [self.callButton addTarget:self action:@selector(callButtonAction)
              forControlEvents:UIControlEventTouchUpInside];
    [self.buttonOnlineView addTarget:self action:@selector(buttonOnlineViewAction)
              forControlEvents:UIControlEventTouchUpInside];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (void)backButtonAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) callButtonAction
{
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"tel:+79885035228"]];

}

- (void) buttonOnlineViewAction
{
    OnlineViewController * detail = [self.storyboard
    instantiateViewControllerWithIdentifier:@"onlineViewController"];
    [self.navigationController pushViewController:detail animated:YES];
}


@end
