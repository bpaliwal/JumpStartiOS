//
//  EBSelfieViewController.m
//  SaturdayApp
//
//  Created by Jeffrey Bergier on 4/19/14.
//  Copyright (c) 2014 BharatJeffSimer. All rights reserved.
//

#import "EBSelfieViewController.h"
#import "EBNameViewController.h"
#import <QuartzCore/QuartzCore.h>

//#import "selfie1.jpg"

@interface EBSelfieViewController ()
@property NSUInteger count;
@property (weak, nonatomic) NSTimer *selfieChangeImageTimer;
@property (weak, nonatomic) IBOutlet UIImageView *selfieImageView;
- (IBAction)didTakePicture:(id)sender;
- (IBAction)didChoosePicture:(id)sender;
- (IBAction)didSkipPicture:(id)sender;

@end

@implementation EBSelfieViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Take a Selfie";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [_selfieImageView setImage:[UIImage imageNamed:@"selfie1.jpg"]];
    
    self.count = 0;
    
    _selfieChangeImageTimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(changeSelfieImageView) userInfo:nil repeats:YES];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didTakePicture:(id)sender {
    NSLog(@"Taking Picture with Front Camera");
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    pickerController.delegate = self;
    pickerController.allowsEditing = YES;
    pickerController.sourceType = UIImagePickerControllerCameraDeviceFront;
    [self presentViewController:pickerController animated:YES completion:nil];
}

- (IBAction)didChoosePicture:(id)sender {
    NSLog(@"Choosing Picture from Library");
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    pickerController.delegate = self;
    pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:pickerController animated:YES completion:nil];
}

- (IBAction)didSkipPicture:(id)sender {
    NSLog(@"Skipping Selfie");
    EBNameViewController *nameViewController = [[EBNameViewController alloc] init];
    [self.navigationController pushViewController:nameViewController animated:YES];

    [_selfieChangeImageTimer invalidate];
}

- (void)changeSelfieImageView {
    if (self.count==0){
        [_selfieImageView setImage:[UIImage imageNamed:@"selfie6.jpg"]];
        self.count = 1;
    } else if (self.count==1){
        [_selfieImageView setImage:[UIImage imageNamed:@"selfie2.jpg"]];
        self.count = 2;
    } else if (self.count==2){
        [_selfieImageView setImage:[UIImage imageNamed:@"selfie3.jpg"]];
        self.count = 3;
    } else if (self.count==3){
        [_selfieImageView setImage:[UIImage imageNamed:@"selfie4.jpg"]];
        self.count = 4;
    } else if (self.count==4){
        [_selfieImageView setImage:[UIImage imageNamed:@"selfie5.jpg"]];
        self.count = 5;
    } else if (self.count==5){
        [_selfieImageView setImage:[UIImage imageNamed:@"selfie1.jpg"]];
        self.count = 0;
    } else {
        NSLog(@"Counting is not working");
    }

}
@end
