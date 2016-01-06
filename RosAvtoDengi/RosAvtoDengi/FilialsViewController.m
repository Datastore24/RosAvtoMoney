//
//  FilialsViewController.m
//  RosAvtoDengi
//
//  Created by Viktor on 26.12.15.
//  Copyright © 2015 Viktor. All rights reserved.
//

#import "FilialsViewController.h"

@interface FilialsViewController () <UIPickerViewDataSource, UIPickerViewDelegate, GMSMapViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *callButton;
@property (weak, nonatomic) IBOutlet UIPickerView *mainPickerView;
@property (strong, nonatomic) NSArray *testArray;
@property (strong, nonatomic) GMSMapView * mainMap;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *mainView;

@end

@implementation FilialsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mainView.layer.cornerRadius = 3.f;
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:45.03409306485644
                                                            longitude:39.01480807533264
                                                                 zoom:19];
    self.mainMap = [GMSMapView mapWithFrame:self.mainView.bounds camera:camera];
    self.mainMap.myLocationEnabled = YES;
    self.mainMap.settings.rotateGestures = NO;
    self.mainMap.settings.allowScrollGesturesDuringRotateOrZoom = YES;
    self.mainMap.delegate = self;
    [self.mainView addSubview:self.mainMap];
    
    // Creates a marker in the center of the map.
    GMSMarker *markerSochi = [[GMSMarker alloc] init];
    markerSochi.position = CLLocationCoordinate2DMake(43.595936839919375, 39.73032295703888);
    markerSochi.title = @"ул. Горького, д.64";
    markerSochi.snippet = @"8 (928) 233-04-05 с 9.00 до 20.00\nСб-Вс: с 10.00 до 20.00";
    markerSochi.map = self.mainMap;
    
    // Creates a marker in the center of the map.
    GMSMarker *markerStavropol = [[GMSMarker alloc] init];
    markerStavropol.position = CLLocationCoordinate2DMake(45.04995602742864, 41.98354482650757);
    markerStavropol.title = @"ул. Голенева, д.30/1";
    markerStavropol.snippet = @"8 (938) 334-87-79 с 9.00 до 20.00\nСб-Вс: с 10.00 до 20.00";
    markerStavropol.map = self.mainMap;
    
    // Creates a marker in the center of the map.
    GMSMarker *markerKrasnodar = [[GMSMarker alloc] init];
    markerKrasnodar.position = CLLocationCoordinate2DMake(45.03409306485644, 39.01480807533264);
    markerKrasnodar.title = @"ул. Северная, д.604А";
    markerKrasnodar.snippet = @"8 (921) 086-19-84 с 8.00 до 20.00\nСб-Вс: с 10.00 до 20.00";
    markerKrasnodar.map = self.mainMap;
    
    // Creates a marker in the center of the map.
    GMSMarker *markerArhangelsk = [[GMSMarker alloc] init];
    markerArhangelsk.position = CLLocationCoordinate2DMake(64.53489978516203, 40.56622266769409);
    markerArhangelsk.title = @"проспект Обводный канал, 5";
    markerArhangelsk.snippet = @"8 (928) 037-61-90 с 8.00 до 20.00\nСб-Вс: с 10.00 до 20.00";
    markerArhangelsk.map = self.mainMap;
    
    self.testArray = [NSArray arrayWithObjects:
                      @"Ставрополь",
                      @"Сочи",
                      @"Архангельск",
                      @"Краснодар",  nil];
    
    
    [self.backButton addTarget:self action:@selector(backButtonAction)
              forControlEvents:UIControlEventTouchUpInside];
    [self.callButton addTarget:self action:@selector(callButtonAction)
              forControlEvents:UIControlEventTouchUpInside];
    
    [self.mainPickerView selectRow:self.testArray.count - 1 inComponent:0 animated:YES];

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
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"tel:+79652767762"]];
}

- (void) buttonZoomInAction
{
    GMSCameraUpdate *zoomCamera = [GMSCameraUpdate zoomBy:1];
    [self.mainMap animateWithCameraUpdate:zoomCamera];
}

- (void) buttonZoomOutAction
{
    GMSCameraUpdate *zoomCamera = [GMSCameraUpdate zoomBy:-1];
    [self.mainMap animateWithCameraUpdate:zoomCamera];
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
        [self.mainMap animateToLocation:CLLocationCoordinate2DMake(45.04995602742864, 41.98354482650757)];
        [self.mainMap animateToZoom:17];
    }
    else if (row == 1) {
        
        [self.mainMap animateToLocation:CLLocationCoordinate2DMake(43.595936839919375, 39.73032295703888)];
        [self.mainMap animateToZoom:17];
    }
    else if (row == 2) {
        [self.mainMap animateToLocation:CLLocationCoordinate2DMake(64.53489978516203, 40.56622266769409)];
        [self.mainMap animateToZoom:16];
    }
    else if (row == 3) {
        [self.mainMap animateToLocation:CLLocationCoordinate2DMake(45.03409306485644, 39.01490807533264)];
//        [self.mainMap animateToViewingAngle:45];
        [self.mainMap animateToZoom:19];
    }
    else
    {
        
    }

}
@end
