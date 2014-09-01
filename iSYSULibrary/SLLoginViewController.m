//
//  SLLoginViewController.m
//  iSYSULibrary
//
//  Created by Alaysh on 9/1/14.
//  Copyright (c) 2014 Alaysh. All rights reserved.
//

#import "SLLoginViewController.h"
#import "UIColor+ApplicationColor.h"

@interface SLLoginViewController ()

@end

@implementation SLLoginViewController

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
    [self configureAppearence];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureAppearence
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.usernameField.alpha = 0.0;
    self.passwordField.alpha = 0.0;
    self.loginButton.alpha = 0.0;
    self.usernameField.textColor = [UIColor lightGrayColor];
    self.passwordField.textColor = [UIColor lightGrayColor];
    
    [UIView animateWithDuration:0.7 delay:0.0 options:UIViewAnimationOptionCurveEaseIn  animations:^{
        self.usernameField.alpha = 1.0;
        self.passwordField.alpha = 1.0;
        self.loginButton.alpha = 0.9;
    } completion:nil];
    
    [self.usernameField addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    [self.passwordField addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    [self textFieldDidChange];
}

- (void)textFieldDidChange
{
    if ([self.usernameField.text isEqualToString:@""] || [self.passwordField.text isEqualToString:@""]) {
        self.loginButton.enabled = false;
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.loginButton.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
        } completion:nil];
    }
    else {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.loginButton.backgroundColor = [UIColor applicationGreenColor];
        } completion:nil];
        self.loginButton.enabled = true;
    }
}

- (IBAction)loginButtonClicked:(id)sender
{
    [self backgroundClicked:nil];
}

- (IBAction)backgroundClicked:(id)sender
{
    [self.usernameField resignFirstResponder];
    [self.passwordField resignFirstResponder];
}

@end
