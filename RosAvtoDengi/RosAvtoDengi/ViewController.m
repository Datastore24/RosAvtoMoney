//
//  ViewController.m
//  RosAvtoDengi
//
//  Created by Viktor on 26.12.15.
//  Copyright © 2015 Viktor. All rights reserved.
//

#import "ViewController.h"
#import "ServicesViewController.h"
#import "OnlineViewController.h"
#import "FilialsViewController.h"
#import <DWBubbleMenuButton/DWBubbleMenuButton.h>
#import <AKPickerView/AKPickerView.h>
#import "UIColor+HexColor.h"

@interface ViewController () <AKPickerViewDataSource, AKPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton * buttonServices; //Кнопка об услуге
@property (weak, nonatomic) IBOutlet UIButton *buttonOnline; //Кнопка онлайн заявка
@property (weak, nonatomic) IBOutlet UIButton *buttonFilials; //Кнопка филиалы
@property (weak, nonatomic) IBOutlet UIButton *callButton; //Кнопка звонок
@property (weak, nonatomic) IBOutlet UIImageView *mainView;
@property (weak, nonatomic) IBOutlet UIImageView *topBarView; //Верхний бар
@property (weak, nonatomic) IBOutlet UIImageView *downBarView; //Нижний бар
@property (weak, nonatomic) IBOutlet UIView *whiteBarView;


@property (nonatomic, strong) AKPickerView *pickerView;
@property (nonatomic, strong) NSArray *titles;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Ресайзы
    
    CGRect frameWhiteBarView = self.whiteBarView.frame; //Берем размер фрейма верхнего бара
    frameWhiteBarView.size.width=self.view.bounds.size.width; // Растянуть в размер экрана
    self.whiteBarView.frame = frameWhiteBarView;//присвоение нового размера
    
    CGRect frameView = self.mainView.frame; //Берем размер фрейма верхнего бара
    frameView.size.width=self.view.bounds.size.width; // Растянуть в размер экрана
    frameView.size.height=self.view.bounds.size.height-15; // Растянуть в размер экрана + 5
    self.mainView.frame = frameView;//присвоение нового размера
    
    CGRect frameTopBarView = [self.topBarView frame];
    frameTopBarView.size.width = self.view.bounds.size.width;
    
    [self.topBarView setFrame:frameTopBarView];
    
    CGRect frameDownBarView = [self.downBarView frame];
    frameDownBarView.size.width = self.view.bounds.size.width;
    
    [self.downBarView setFrame:frameDownBarView];
    
    self.downBarView.frame =CGRectMake(0, self.view.bounds.size.height-83, self.view.bounds.size.width, 83);
    
    
    
    self.buttonServices.center = CGPointMake(self.view.center.x, self.view.center.y -80);
    
    self.buttonOnline.center = CGPointMake(self.view.center.x, self.view.center.y);
    
    self.buttonFilials.center = CGPointMake(self.view.center.x, self.view.center.y+80);
    
    self.callButton.frame = CGRectMake(self.view.bounds.size.width-48, self.view.bounds.size.height-49, 45, 46);
 

    
    //
    
    [self.buttonServices addTarget:self action:@selector(testButtonAcion)
                  forControlEvents:UIControlEventTouchUpInside];
    [self.buttonOnline addTarget:self action:@selector(buttonOnlineAction)
                forControlEvents:UIControlEventTouchUpInside];
    [self.buttonFilials addTarget:self action:@selector(buttonFilialsAction)
                 forControlEvents:UIControlEventTouchUpInside];
    [self.callButton addTarget:self action:@selector(callButtonAction)
                 forControlEvents:UIControlEventTouchUpInside];
    
    
    // Обрати внимание на условия для 4S
    NSLog(@"%f",self.view.bounds.size.height);
    if(self.view.bounds.size.height == 480.0f){
            self.pickerView = [[AKPickerView alloc] initWithFrame:CGRectMake(0, 93, self.view.bounds.size.width, 40)];
    }else{
            self.pickerView = [[AKPickerView alloc] initWithFrame:CGRectMake(0, 120, self.view.bounds.size.width, 40)];
    }
    
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    [self.view addSubview:self.pickerView];
    
    self.pickerView.font = [UIFont fontWithName:@"HelveticaNeue" size:23];
    self.pickerView.highlightedFont = [UIFont fontWithName:@"HelveticaNeue" size:23];
    self.pickerView.interitemSpacing = 30.0;
    self.pickerView.fisheyeFactor = 0.f;
    self.pickerView.pickerViewStyle = AKPickerViewStyleFlat;
    self.pickerView.maskDisabled = false;
    self.pickerView.textColor = [UIColor blackColor];
   
    
    self.titles = @[@"ЗАЙМЫ до 200 тыс. руб.",
                    @"   Под залог ПТС   ",
                    @"АВТО остается у Вас",];
    
    
    [self.pickerView selectItem:1 animated:NO];
    [self.pickerView reloadData];
    
    
    

}

-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)testButtonAcion
{
    ServicesViewController * detail = [self.storyboard
    instantiateViewControllerWithIdentifier:@"servicesViewController"];
    [self.navigationController pushViewController:detail animated:YES];
}

- (void)buttonOnlineAction
{
    OnlineViewController * detail = [self.storyboard
    instantiateViewControllerWithIdentifier:@"onlineViewController"];
    [self.navigationController pushViewController:detail animated:YES];
}


- (void)buttonFilialsAction
{
    FilialsViewController * detail = [self.storyboard
    instantiateViewControllerWithIdentifier:@"filialsViewController"];
    [self.navigationController pushViewController:detail animated:YES];
}

- (void) callButtonAction
{
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"tel:+79885035228"]];
}


#pragma mark - AKPickerViewDataSource

- (NSUInteger)numberOfItemsInPickerView:(AKPickerView *)pickerView
{
    return [self.titles count];
}

/*
 * AKPickerView now support images!
 *
 * Please comment '-pickerView:titleForItem:' entirely
 * and uncomment '-pickerView:imageForItem:' to see how it works.
 *
 */

- (NSString *)pickerView:(AKPickerView *)pickerView titleForItem:(NSInteger)item
{
    return self.titles[item];
}

/*
 - (UIImage *)pickerView:(AKPickerView *)pickerView imageForItem:(NSInteger)item
 {
	return [UIImage imageNamed:self.titles[item]];
 }
 */



@end
