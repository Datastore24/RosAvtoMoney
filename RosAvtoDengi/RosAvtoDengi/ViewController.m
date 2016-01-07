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
@property (weak, nonatomic) IBOutlet UIButton * buttonServices;
@property (weak, nonatomic) IBOutlet UIButton *buttonOnline;
@property (weak, nonatomic) IBOutlet UIButton *buttonFilials;
@property (weak, nonatomic) IBOutlet UIButton *callButton;
@property (weak, nonatomic) IBOutlet UIImageView *mainView;


@property (nonatomic, strong) AKPickerView *pickerView;
@property (nonatomic, strong) NSArray *titles;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Ресайзы
    
    CGRect frameView = self.mainView.frame; //Берем размер фрейма верхнего бара
    frameView.size.width=self.view.bounds.size.width; // Растянуть в размер экрана
    frameView.size.height=self.view.bounds.size.height-15; // Растянуть в размер экрана + 5
    self.mainView.frame = frameView;//присвоение нового размера
    
    self.buttonServices.center = CGPointMake(self.view.center.x, self.view.center.y -90);
    
    self.buttonOnline.center = CGPointMake(self.view.center.x, self.view.center.y);
    
    self.buttonFilials.center = CGPointMake(self.view.center.x, self.view.center.y+90);
    
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
            self.pickerView = [[AKPickerView alloc] initWithFrame:CGRectMake(0, 80, self.view.bounds.size.width, 40)];
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
