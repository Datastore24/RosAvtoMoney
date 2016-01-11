//
//  FotoViewController.m
//  RosAvtoDengi
//
//  Created by Viktor on 27.12.15.
//  Copyright © 2015 Viktor. All rights reserved.
//

#import "FotoViewController.h"
#import <AVFoundation/AVFoundation.h>

#import <AFHTTPRequestOperation.h>
#import <AFHTTPRequestOperationManager.h>

@interface FotoViewController ()
@property (weak, nonatomic) IBOutlet UIButton *buttonCreateFoto; //Кнопка содать фото
@property (weak, nonatomic) IBOutlet UIView *frameFotoCapture; //Вью камеры
@property (strong, nonatomic) UIImage * fotoImage;
@property (weak, nonatomic) IBOutlet UIImageView *imageView; //Картинка снятого фото
@property (weak, nonatomic) IBOutlet UIButton *createFotoButton; //Кнопка переснять
@property (weak, nonatomic) IBOutlet UIButton *postButton; //Кнопка отправить
@property (weak, nonatomic) IBOutlet UIButton *callButton; //Кнопка звонить
@property (weak, nonatomic) IBOutlet UIImageView *topBarView; //Верхний бар
@property (weak, nonatomic) IBOutlet UIImageView *downBarButton; //Нижний бар
@property (weak, nonatomic) IBOutlet UIView *whiteBarView;



@end

@implementation FotoViewController
{
    AVCaptureSession *session;
    AVCaptureStillImageOutput *stillImageOutput;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Ресайзы
    
    CGRect frameWhiteBarView = self.whiteBarView.frame; //Берем размер фрейма верхнего бара
    frameWhiteBarView.size.width=self.view.bounds.size.width; // Растянуть в размер экрана
    self.whiteBarView.frame = frameWhiteBarView;//присвоение нового размера
    
    CGRect frameTopBarView = [self.topBarView frame];
    frameTopBarView.size.width = self.view.bounds.size.width;
    
    [self.topBarView setFrame:frameTopBarView];
    
    CGRect frameDownBarView = [self.downBarButton frame];
    frameDownBarView.size.width = self.view.bounds.size.width;
    
    [self.downBarButton setFrame:frameDownBarView];
    
    self.downBarButton.frame =CGRectMake(0, self.view.bounds.size.height-83, self.view.bounds.size.width, 83);
    
    
    
    self.buttonCreateFoto.center = CGPointMake(self.view.center.x, self.view.bounds.size.height-120);
    
    self.callButton.frame = CGRectMake(self.view.bounds.size.width-48, self.view.bounds.size.height-49, 45, 46);
    
    
    
    //
    
    
    
    self.createFotoButton.alpha = 0.f;
    [self.createFotoButton addTarget:self action:@selector(createFotoButtonAction)
                    forControlEvents:UIControlEventTouchUpInside];
    
    self.postButton.alpha = 0.f;
    [self.postButton addTarget:self action:@selector(postButtonAction)
              forControlEvents:UIControlEventTouchUpInside];
    self.buttonCreateFoto.backgroundColor = [UIColor yellowColor];
    
    if(self.view.bounds.size.height == 480.0f){
            self.imageView.frame = CGRectMake(20, 117, self.view.bounds.size.width, 150); //ТУТ ИСПРАВИТЬ ЗНАЧЕНИЕ ПОСЛЕДНЕЕ
    }else{
            self.imageView.frame = CGRectMake(20, 117, self.view.bounds.size.width, 280);
    }
    
    
    self.imageView.alpha = 0.f;
    self.frameFotoCapture.alpha = 1.f;

    [self.buttonCreateFoto addTarget:self action:@selector(buttonCreateFotoAction)
              forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewWillAppear:(BOOL)animated {
    session = [[AVCaptureSession alloc] init];
    [session setSessionPreset:AVCaptureSessionPresetPhoto];
    
    AVCaptureDevice *inputDevise = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error;
    AVCaptureDeviceInput *deviseInput = [AVCaptureDeviceInput deviceInputWithDevice:inputDevise error:&error];
    
    if ([session canAddInput:deviseInput]) {
        [session addInput:deviseInput];
    }
    
    AVCaptureVideoPreviewLayer * previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
    [previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    CALayer * rootLayer = [[self view] layer];
    [rootLayer setMasksToBounds:YES];
    CGRect frame = self.frameFotoCapture.frame;
    
    [previewLayer setFrame:frame];
    [rootLayer insertSublayer:previewLayer atIndex:0];
    
    
    stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    NSDictionary * outputSetings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG, AVVideoCodecKey, nil];
    [stillImageOutput setOutputSettings:outputSetings];
    [session addOutput:stillImageOutput];
    
    [session startRunning];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) buttonBackAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) buttonCreateFotoAction
{
    AVCaptureConnection *videoConnection = nil;
    
    for (AVCaptureConnection * connection in stillImageOutput.connections) {
        for (AVCaptureInputPort * port in [connection inputPorts]) {
            if ([[port mediaType] isEqual:AVMediaTypeVideo]) {
                videoConnection = connection;
                break;
                
            }
        }
        if (videoConnection) {
            break;
        }
    }
    
    [stillImageOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        if (imageDataSampleBuffer != NULL) {
            NSData * imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
            self.buttonCreateFoto.backgroundColor = [UIColor clearColor];
            self.fotoImage = [UIImage imageWithData:imageData];
            self.imageView.image = self.fotoImage;
            [self uploadImage:self.fotoImage];
        }
        
    }];
    
    self.frameFotoCapture.alpha = 0.f;
    self.imageView.alpha = 1.f;
    self.createFotoButton.alpha = 1.f;
    self.postButton.alpha = 1.f;
    self.buttonCreateFoto.alpha = 0.f;
    
}

- (void) createFotoButtonAction
{
    self.frameFotoCapture.alpha = 1.f;
    self.imageView.alpha = 0.f;
    self.createFotoButton.alpha = 0.f;
    self.postButton.alpha = 0.f;
    self.buttonCreateFoto.alpha = 1.f;
     self.buttonCreateFoto.backgroundColor = [UIColor yellowColor];
}

- (void) postButtonAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)uploadImage: (UIImage *) imageData
{
    
    NSString *stringUrl = [ NSString stringWithFormat:@"http://itdolgopa.ru/ios/RosAvtoDengi/uploader.php"];
    NSData *imageLoad = UIImageJPEGRepresentation(imageData,0.2);
    
    
    NSDictionary *parameters  = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"id", nil];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:stringUrl parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     {
         [formData appendPartWithFileData:imageLoad name:@"userfile" fileName:@"photo.jpg" mimeType:@"image/jpeg"];
         
     } success:^(AFHTTPRequestOperation *operation, id responseObject) {
         NSLog(@"Success: %@ ***** %@", operation.responseString, responseObject);
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@ ***** %@", operation.responseString, error);
     }];
}

@end
