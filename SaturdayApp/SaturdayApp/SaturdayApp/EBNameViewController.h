//
//  EBNameViewController.h
//  SaturdayApp
//
//  Created by Jeffrey Bergier on 4/19/14.
//  Copyright (c) 2014 BharatJeffSimer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EBNameViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UIButton *viewBroadcastButton;

- (IBAction)viewBroadcast:(id)sender;





@end
