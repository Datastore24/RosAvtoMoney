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
@property (weak, nonatomic) IBOutlet UIButton *backButton; //Кнопка назад
@property (weak, nonatomic) IBOutlet UIButton *callButton; //Кнопка звонить
@property (weak, nonatomic) IBOutlet UIButton *createFormButton; //Кнопка выслать форму
@property (weak, nonatomic) IBOutlet UIButton *buttonPTS; //Кнопка снять ПТС
@property (weak, nonatomic) IBOutlet UIImageView *imageTitle; //Картинка загаловка
@property (weak, nonatomic) IBOutlet UIImageView *topBarView; //Верхний бар
@property (weak, nonatomic) IBOutlet UIImageView *downBarView; //Нижний бар
@property (weak, nonatomic) IBOutlet UIView *whiteBarView;

@end

@implementation OnlineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Ресайзы
    
    CGRect frameWhiteBarView = self.whiteBarView.frame; //Берем размер фрейма верхнего бара
    frameWhiteBarView.size.width=self.view.bounds.size.width; // Растянуть в размер экрана
    self.whiteBarView.frame = frameWhiteBarView;//присвоение нового размера
    
    CGRect frameTopBarView = [self.topBarView frame];
    frameTopBarView.size.width = self.view.bounds.size.width;
    
    [self.topBarView setFrame:frameTopBarView];
    
    CGRect frameDownBarView = [self.downBarView frame];
    frameDownBarView.size.width = self.view.bounds.size.width;
    
    [self.downBarView setFrame:frameDownBarView];
    
    self.downBarView.frame =CGRectMake(0, self.view.bounds.size.height-83, self.view.bounds.size.width, 83);
    
    
    
    self.createFormButton.center = CGPointMake(self.view.center.x, self.view.center.y -15);
    self.buttonPTS.center = CGPointMake(self.view.center.x, self.view.center.y +65);
    
    self.callButton.frame = CGRectMake(self.view.bounds.size.width-48, self.view.bounds.size.height-49, 45, 46);
    
    
    
    //
    
    
    
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
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"tel:+78007006939"]];
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
