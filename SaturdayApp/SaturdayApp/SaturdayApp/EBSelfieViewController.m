//
//  EBSelfieViewController.m
//  SaturdayApp
//
//  Created by Jeffrey Bergier on 4/19/14.
//  Copyright (c) 2014 BharatJeffSimer. All rights reserved.
//

#import "EBSelfieViewController.h"
#import "EBNameViewController.h"
#import "JCRBlurView.h"
#import <QuartzCore/QuartzCore.h>
#import <MobileCoreServices/MobileCoreServices.h>

//#import "selfie1.jpg"

@interface EBSelfieViewController ()
@property NSUInteger count;
@property (weak, nonatomic) NSTimer *selfieChangeImageTimer;
@property (strong, nonatomic) IBOutlet UIView *selfieTextView;
@property (weak, nonatomic) IBOutlet UIButton *selfieTakePictureButton;
@property (weak, nonatomic) IBOutlet UIButton *selfieChoosePictureButton;
@property (weak, nonatomic) IBOutlet UIImageView *selfieImageView;
@property (weak, nonatomic) IBOutlet UIButton *selfieSkipPictureButton;
@property (weak, nonatomic) IBOutlet UILabel *selfieTextLabel;
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
    
    // Setting things up for the loop of images
    self.count = 0;
    [_selfieImageView setImage:[UIImage imageNamed:@"selfie1.jpg"]];
    _selfieChangeImageTimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(changeSelfieImageView) userInfo:nil repeats:YES];
    
    //Getting the screen height so it can be used to place items
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    
    //Adding the Blur View to the screen
    JCRBlurView *blurView = [JCRBlurView new];
    [blurView setFrame:CGRectMake(0.0f, screenBounds.size.height-140.0f, 320.0f,140.0f)];
    [self.view addSubview:blurView];
    [blurView setBlurTintColor:nil];
    
    //Adding the buttons on top of the blur view
    [_selfieTextView setFrame:CGRectMake(0.0f,428.0f,320.0f,140.0f)];
    [self.view addSubview:_selfieTextView];
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        //There is not a camera on this so we need to change the buttons around.
        self.selfieTakePictureButton.alpha = 0;
        self.selfieChoosePictureButton.frame = CGRectMake(self.view.frame.origin.x + 80, self.view.frame.origin.y + 63, self.selfieChoosePictureButton.frame.size.width, self.selfieChoosePictureButton.frame.size.height);
        [_selfieChoosePictureButton.titleLabel setFont:[UIFont boldSystemFontOfSize:17]];
        self.selfieSkipPictureButton.frame = CGRectMake(self.view.frame.origin.x + 80, self.view.frame.origin.y + 106, self.selfieSkipPictureButton.frame.size.width, self.selfieSkipPictureButton.frame.size.height);
        
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didTakePicture:(id)sender {
    if ([[_selfieTakePictureButton currentTitle] isEqual:@"Continue to Next Step"]) {
        //NSLog(@"Continuing to next step");
        [_selfieChangeImageTimer invalidate];
        EBNameViewController *nameViewController = [[EBNameViewController alloc] init];
        [self.navigationController pushViewController:nameViewController animated:YES];
    } else {
        NSLog(@"Taking Picture with Front Camera");
        UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
        pickerController.delegate = self;
        pickerController.allowsEditing = YES;
        pickerController.sourceType = UIImagePickerControllerCameraDeviceFront;
        [self presentViewController:pickerController animated:YES completion:nil];
    }
}

- (IBAction)didChoosePicture:(id)sender {
    //NSLog(@"Choosing Picture from Library");
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    pickerController.delegate = self;
    pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:pickerController animated:YES completion:nil];
}

- (IBAction)didSkipPicture:(id)sender {
    //NSLog(@"Skipping Selfie");
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

// For responding to the user accepting a newly-captured picture or movie
- (void) imagePickerController: (UIImagePickerController *) picker didFinishPickingMediaWithInfo: (NSDictionary *) info {
    
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    UIImage *originalImage, *editedImage, *imageToSave;
    
    // Handle a still image capture
    if (CFStringCompare ((CFStringRef) mediaType, kUTTypeImage, 0) == kCFCompareEqualTo) {
        
        editedImage = (UIImage *) [info objectForKey: UIImagePickerControllerEditedImage];
        originalImage = (UIImage *) [info objectForKey: UIImagePickerControllerOriginalImage];
        
        if (editedImage) {
            imageToSave = editedImage;
        } else {
            imageToSave = originalImage;
        }
        
        // Save the new image (original or edited) to the Documents Folder
        NSString  *imagePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/chosenSelfie.jpg"];
        [UIImageJPEGRepresentation(imageToSave, 1.0) writeToFile:imagePath atomically:YES];
        
    }
    
    // Handle a movie capture
    if (CFStringCompare ((CFStringRef) mediaType, kUTTypeMovie, 0) == kCFCompareEqualTo) {
        NSLog(@"You chose a movie. Sorry, we're not that cool yet");
    }
    
    //Load the saved image from disk into Image View
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString* path = [documentsDirectory stringByAppendingPathComponent: [NSString stringWithString: @"chosenSelfie.jpg"] ];
    UIImage* image = [UIImage imageWithContentsOfFile:path];
    [_selfieImageView setImage: image];
    
    //change buttons and dismiss the image picker
    [self changeButtonText];
    [self reappearButtonText];
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void)changeButtonText {
    self.selfieChoosePictureButton.frame = CGRectMake(self.view.frame.origin.x + 80, self.view.frame.origin.y + 106, self.selfieChoosePictureButton.frame.size.width, self.selfieChoosePictureButton.frame.size.height);
    [_selfieChoosePictureButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    //self.selfieTakePictureButton.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + 66, self.selfieTakePictureButton.frame.size.width, self.selfieTakePictureButton.frame.size.height);
    [UIView animateWithDuration:.5
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.selfieTextLabel.alpha = 0;
                         self.selfieTakePictureButton.alpha = 0;
                         self.selfieSkipPictureButton.alpha = 0;
                         self.selfieChoosePictureButton.alpha = 0;
                     }
                     completion:nil];
    
    [_selfieTakePictureButton setTitle:@"Continue to Next Step" forState:UIControlStateNormal];
    [_selfieChoosePictureButton setTitle:@"Choose Again" forState:UIControlStateNormal];
    [_selfieTextLabel setText:@"Nice Shot! You look damn good!"];
    [_selfieChangeImageTimer invalidate];
}

-(void)reappearButtonText {
    [UIView animateWithDuration:.5
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.selfieTakePictureButton.alpha = 1;
                         self.selfieTextLabel.alpha = 1;
                         self.selfieChoosePictureButton.alpha = 1;
                     }
                     completion:nil];
    [_selfieChangeImageTimer invalidate];
}

@end
