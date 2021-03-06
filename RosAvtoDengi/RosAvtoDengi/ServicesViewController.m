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
@property (weak, nonatomic) IBOutlet UIButton *backButton; //Кнопка назад
@property (weak, nonatomic) IBOutlet UIButton *callButton; //Кнопка звонок
@property (weak, nonatomic) IBOutlet UIButton *buttonOnlineView; //Кнопка онлайн заявка
@property (weak, nonatomic) IBOutlet UIImageView *imageTitle; //Картинка заголовка
@property (weak, nonatomic) IBOutlet UIImageView *topBarView; //Верхний бар
@property (weak, nonatomic) IBOutlet UILabel *labelText; //Тест на основном вью
@property (weak, nonatomic) IBOutlet UIImageView *downBarView; //Нижний бар
@property (weak, nonatomic) IBOutlet UIView *whiteBarView;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;

@end

@implementation ServicesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
//    self.mainScrollView.contentSize = CGSizeMake(320, 400);
    
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
    
    
    if(self.view.bounds.size.height == 480.0f){
        
        self.buttonOnlineView.center = CGPointMake(self.view.center.x, 250);
        [self.mainScrollView addSubview:self.buttonOnlineView];
    }else{
        self.buttonOnlineView.center = CGPointMake(self.view.center.x, 430);
    }
    
    self.callButton.frame = CGRectMake(self.view.bounds.size.width-48, self.view.bounds.size.height-49, 45, 46);
    
    
    
    //
    
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
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"tel:+78007006939"]];

}

- (void) buttonOnlineViewAction
{
    OnlineViewController * detail = [self.storyboard
    instantiateViewControllerWithIdentifier:@"onlineViewController"];
    [self.navigationController pushViewController:detail animated:YES];
}


@end
