//
//  CreateFormViewController.m
//  RosAvtoDengi
//
//  Created by Viktor on 26.12.15.
//  Copyright © 2015 Viktor. All rights reserved.
//

#import "CreateFormViewController.h"
#import <AKPickerView/AKPickerView.h>

#import "APIClass.h"

static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;

@interface CreateFormViewController () <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *buttonBack; //Кнопка назад
@property (weak, nonatomic) IBOutlet UIButton *buttonPushAplication; //Кнопка отсправить завку
@property (weak, nonatomic) IBOutlet UIImageView *imageTitle; //Картинка заголовка
@property (weak, nonatomic) IBOutlet UIButton *callButton; //Кнопка звонить
@property (weak, nonatomic) IBOutlet UIImageView *topBarView; //Верхний бар
@property (weak, nonatomic) IBOutlet UIImageView *downBarView; //Нижний бар

//Текст филды идут по очереди-----
@property (weak, nonatomic) IBOutlet UITextField *textField1;
@property (weak, nonatomic) IBOutlet UITextField *textField2;
@property (weak, nonatomic) IBOutlet UITextField *textField4;
@property (weak, nonatomic) IBOutlet UITextField *textField5;
@property (weak, nonatomic) IBOutlet UITextField *textField6;
@property (weak, nonatomic) IBOutlet UITextField *textField7;
@property (weak, nonatomic) IBOutlet UITextField *textField8;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;

@property (strong, nonatomic) IBOutlet UIPickerView *mainPickerView; //Пикер вью
@property (strong, nonatomic) NSString * stringTown;

@property (nonatomic, strong) NSArray * testArray;

@property (weak, nonatomic) IBOutlet UIView *whiteBarView;



@end

@implementation CreateFormViewController
CGFloat animatedDistance;

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
    
    [self.callButton addTarget:self action:@selector(callButtonAction)
forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    if(self.view.bounds.size.height == 480.0f){
        
        self.buttonPushAplication.center = CGPointMake(self.view.center.x, 260);
        self.mainScrollView.frame =CGRectMake(0, 190, self.view.bounds.size.width, self.view.bounds.size.height-270);
        [self.mainScrollView addSubview:self.buttonPushAplication];
    }else{
        self.buttonPushAplication.center = CGPointMake(self.view.center.x, 260);
        self.mainScrollView.frame =CGRectMake(0, 190, self.view.bounds.size.width, self.view.bounds.size.height-270);
    }
    
 
    self.callButton.frame = CGRectMake(self.view.bounds.size.width-48, self.view.bounds.size.height-49, 45, 46);
    
    
    
    //
    
//    self.mainScrollView.contentSize = CGSizeMake(self.view.bounds.size.width, 500);

    
    
    
    self.testArray = [NSArray arrayWithObjects:
                       @"Ставрополь",
                       @"Сочи",
                       @"Архангельск",
                       @"Краснодар",  nil];

    [self.buttonBack addTarget:self action:@selector(buttonBackAction)
              forControlEvents:UIControlEventTouchUpInside];
    [self.buttonPushAplication addTarget:self action:@selector(buttonPushAplicationAction)
                        forControlEvents:UIControlEventTouchUpInside];
    
    //Создаем Label
    
    UILabel * labelFIO = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 40, 20)];
    labelFIO.text = @"Ф.И.О.";
    labelFIO.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    [self.mainScrollView addSubview:labelFIO];
    self.textField1.frame = CGRectMake(60, 10, 240, 20);
    
    UILabel * labelDateBithday = [[UILabel alloc] initWithFrame:CGRectMake(10, 35, 90, 20)];
    labelDateBithday.text = @"Дата рождения";
    labelDateBithday.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    [self.mainScrollView addSubview:labelDateBithday];
    self.textField2.frame = CGRectMake(110, 35, 190, 20);
    
    UILabel * labelYouRegion = [[UILabel alloc] initWithFrame:CGRectMake(10, 60, 70, 20)];
    labelYouRegion.text = @"Ваш регион";
    labelYouRegion.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    [self.mainScrollView addSubview:labelYouRegion];
    self.mainPickerView.frame = CGRectMake(130, 48, 130, 45);
    [self.mainPickerView selectRow:self.testArray.count - 1 inComponent:0 animated:YES];
    
    UILabel * labelModelTS = [[UILabel alloc] initWithFrame:CGRectMake(10, 75, 70, 40)];
    labelModelTS.text = @"Модель ТС";
    labelModelTS.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    [self.mainScrollView addSubview:labelModelTS];
    self.textField4.frame = CGRectMake(90, 85, 210, 20);
    
    UILabel * labelMarkaTS = [[UILabel alloc] initWithFrame:CGRectMake(10, 110, 70, 20)];
    labelMarkaTS.text = @"Марка ТС";
    labelMarkaTS.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    [self.mainScrollView addSubview:labelMarkaTS];
    self.textField5.frame = CGRectMake(90, 110, 210, 20);
    
    UILabel * labelYearCreate = [[UILabel alloc] initWithFrame:CGRectMake(10, 135, 90, 20)];
    labelYearCreate.text = @"Год выпуска ТС";
    labelYearCreate.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    [self.mainScrollView addSubview:labelYearCreate];
    self.textField6.frame = CGRectMake(110, 135, 190, 20);
    
    UILabel * labelNumberTel = [[UILabel alloc] initWithFrame:CGRectMake(10, 160, 70, 20)];
    labelNumberTel.text = @"Номер тел.";
    labelNumberTel.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    [self.mainScrollView addSubview:labelNumberTel];
    self.textField7.frame = CGRectMake(90, 160, 210, 20);
    
    UILabel * labelSum = [[UILabel alloc] initWithFrame:CGRectMake(10, 185, 90, 20)];
    labelSum.text = @"Сумма займа";
    labelSum.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    [self.mainScrollView addSubview:labelSum];
    self.textField8.frame = CGRectMake(110, 185, 190, 20);

    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (void) buttonBackAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) buttonPushAplicationAction
{

    //Выдергиваем данные из PickerView
    NSUInteger selectedRow = [self.mainPickerView selectedRowInComponent:0];
    NSString * title = [[self.mainPickerView delegate] pickerView:self.mainPickerView titleForRow:selectedRow forComponent:0];
    
    //
    
    
    NSDictionary* params = [[NSDictionary alloc] initWithObjectsAndKeys:
                            self.textField1.text, @"fio",
                            self.textField2.text, @"birthday",
                            title,@"region",
                            self.textField4.text, @"model",
                            self.textField5.text, @"marka",
                            self.textField6.text, @"year",
                            self.textField7.text, @"phone",
                            self.textField8.text, @"summ",
           
                            nil];
    [self postApiOrder:params];
    
}

- (void)postApiOrder:(NSDictionary*) params
{
   
    
    APIClass* api = [APIClass new]; //создаем API
    [api postDataToServerWithParams:params
                             method:@"action=send_form"
                    complitionBlock:^(id response) {
                        NSDictionary* dict = (NSDictionary*)response;
                        NSLog(@"%@",dict);
                        if ([[dict objectForKey:@"error"] integerValue] == 0) {
                            [self.navigationController popViewControllerAnimated:YES];
                        }
                        else {
                            NSLog(@"ERROR");
                        }
                    }];
}



#pragma mark - UITextFieldDelegate ViewDelegate Methods

-(BOOL)textFieldShouldReturn:(UITextField *) returnKeyborad {  // метод делегата, который убирает клавиатуру, когда пользоатель завершил ввод текста и нажал клавишу "ввод"
    [returnKeyborad resignFirstResponder];
    
    
    return YES;
}

#pragma mark - Методы поднимающие ViewController, при открытии клавиатуры

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    CGRect textFieldRect =
    [self.view.window convertRect:textField.bounds fromView:textField];
    CGRect viewRect =
    [self.view.window convertRect:self.view.bounds fromView:self.view];
    CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
    CGFloat numerator =
    midline - viewRect.origin.y
    - MINIMUM_SCROLL_FRACTION * viewRect.size.height;
    CGFloat denominator =
    (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION)
    * viewRect.size.height;
    CGFloat heightFraction = numerator / denominator;
    if (heightFraction < 0.0)
    {
        heightFraction = 0.0;
    }
    else if (heightFraction > 1.0)
    {
        heightFraction = 1.0;
    }
    UIInterfaceOrientation orientation =
    [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait ||
        orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
    }
    else
    {
        animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
    }
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y -= animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
}

- (void)textFieldDidEndEditing:(UITextField *)textfield{
    
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y += animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView
numberOfRowsInComponent:(NSInteger)component
{
    return self.testArray.count;
}

- (NSString *)pickerView:(UIPickerView *)thePickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    return [self.testArray objectAtIndex:row];
}

- (UIView*)pickerView:(UIPickerView*)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView*)view
{
    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, pickerView.frame.size.width, 20)];
    
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:15];
    label.text = [NSString stringWithFormat:@" %@", self.testArray[row]];
    label.textAlignment = NSTextAlignmentCenter;
    
    [[self.mainPickerView.subviews objectAtIndex:1] setHidden:YES];
    [[self.mainPickerView.subviews objectAtIndex:2] setHidden:YES];

    return label;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (row == 0) {
        self.stringTown = @"Ставрополь";
    }
    else if (row == 1) {
        
        self.stringTown = @"Сочи";
    }
    else if (row == 2) {
        self.stringTown = @"Архангельск";
    }
    else if (row == 3) {
        self.stringTown = @"Краснодар";
    }
    else
    {
        self.stringTown = @"Ошибка ввода";
    }
    
    NSLog(@"%@", self.stringTown);
    
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 28;
}


- (void) callButtonAction
{
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"tel:+78007006939"]];
}

@end
