//
//  FotoViewController.m
//  RosAvtoDengi
//
//  Created by Viktor on 27.12.15.
//  Copyright © 2015 Viktor. All rights reserved.
//

#import "FotoViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "PostFotoViewController.h"

@interface FotoViewController ()
@property (weak, nonatomic) IBOutlet UIButton *buttonCreateFoto;
@property (weak, nonatomic) IBOutlet UIView *frameFotoCapture;
@property (strong, nonatomic) UIImage * fotoImage;



@end

@implementation FotoViewController
{
    AVCaptureSession *session;
    AVCaptureStillImageOutput *stillImageOutput;
}

- (void)viewDidLoad {
    [super viewDidLoad];

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
            self.fotoImage = [UIImage imageWithData:imageData];
            self.imageView.image = self.fotoImage;
        }
        
    }];
    
//    PostFotoViewController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"PostFotoViewController"];
//    [self.navigationController pushViewController:detail animated:YES];
}

@end
