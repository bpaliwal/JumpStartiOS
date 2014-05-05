//
//  EBNameViewController.m
//  SaturdayApp
//
//  Created by Jeffrey Bergier on 4/19/14.
//  Copyright (c) 2014 BharatJeffSimer. All rights reserved.
//

#import "EBNameViewController.h"
#import <Parse/Parse.h>
#import "EBLocationViewController.h"

@interface EBNameViewController ()

//SS: Track input changed
- (void)textInputChanged:(NSNotification *)note;
- (BOOL)shouldEnableViewBroadcastButton;
- (void)processUserInformation;




@end

@implementation EBNameViewController

// SS: specify synthesis, since custom getters are used in the if field in shouldEnable function below.
@synthesize viewBroadcastButton;
@synthesize userNameField;






- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //SS: enter user name and enable view broadcast button
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textInputChanged:) name:UITextFieldTextDidChangeNotification object:userNameField];
    
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// SS: track text change
- (void)textInputChanged:(NSNotification *)note{
    viewBroadcastButton.enabled=[self shouldEnableViewBroadcastButton];
}


//SS: Enable View Broadcast

- (BOOL)shouldEnableViewBroadcastButton {
    BOOL enableViewBroadcastButton = NO;
    if (userNameField.text !=nil &&
        userNameField.text.length > 0){
        enableViewBroadcastButton = YES;
    }
    return enableViewBroadcastButton;
}
    

- (void)processUserInformation
    {
        NSString *username=userNameField.text;
        
    }

    

    
    
- (IBAction)viewBroadcast:(id)sender {
  [self processUserInformation];
    }
@end
