//
//  LoginViewController.m
//  MyGame2
//
//  Created by phuong on 4/5/17.
//  Copyright © 2017 ppben. All rights reserved.
//

#import "LoginViewController.h"
#import "PlayViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize nameTF;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    PlayViewController *destinationController = segue.destinationViewController;
    destinationController.sentName = nameTF.text;
}
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    if ([nameTF.text isEqualToString:@""]){
        return NO;
    }
    return YES;
}

- (IBAction)dismissKeyboard:(id)sender {
    [self.nameTF resignFirstResponder];
}


@end
