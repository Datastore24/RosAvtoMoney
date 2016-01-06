//
//  OnlineViewController.m
//  RosAvtoDengi
//
//  Created by Viktor on 26.12.15.
//  Copyright © 2015 Viktor. All rights reserved.
//

#import "OnlineViewController.h"
#import "CreateFormViewController.h"
#import "FotoViewController.h"

@interface OnlineViewController ()
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *callButton;
@property (weak, nonatomic) IBOutlet UIButton *createFormButton;
@property (weak, nonatomic) IBOutlet UIButton *buttonPTS;

@end

@implementation OnlineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.backButton addTarget:self action:@selector(backButtonAction)
              forControlEvents:UIControlEventTouchUpInside];
    [self.callButton addTarget:self action:@selector(callButtonAction)
              forControlEvents:UIControlEventTouchUpInside];
    [self.createFormButton addTarget:self action:@selector(createFormButtonAction)
                    forControlEvents:UIControlEventTouchUpInside];
    [self.buttonPTS addTarget:self action:@selector(buttonPTSAction)
             forControlEvents:UIControlEventTouchUpInside];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (void)backButtonAction
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void) callButtonAction
{
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"tel:+79885035228"]];
}

- (void) createFormButtonAction
{
    CreateFormViewController * detail = [self.storyboard
    instantiateViewControllerWithIdentifier:@"createFormViewController"];
    [self.navigationController pushViewController:detail animated:YES];
}

- (void) buttonPTSAction
{
    FotoViewController * detail = [self.storyboard
    instantiateViewControllerWithIdentifier:@"fotoViewController"];
    [self.navigationController pushViewController:detail animated:YES];
}





@end
