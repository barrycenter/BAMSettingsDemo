//
//  RootViewController.m
//  BAMSettingsDemo
//
//  Created by Barry Murphy on 4/13/11.
//
//  If you use this software in your project, a credit for Barry Murphy
//  and a link to http://barrycenter.com would be appreciated.
//
//  --------------------------------
//  Simplified BSD License (FreeBSD)
//  --------------------------------
//
//  Copyright 2011 Barry Murphy. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are
//  permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of
//     conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list
//     of conditions and the following disclaimer in the documentation and/or other materials
//     provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY BARRY MURPHY "AS IS" AND ANY EXPRESS OR IMPLIED
//  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
//  FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL BARRY MURPHY OR
//  CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
//  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
//  SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
//  ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
//  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
//  ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
//  The views and conclusions contained in the software and documentation are those of the
//  authors and should not be interpreted as representing official policies, either expressed
//  or implied, of Barry Murphy.
//

#import "RootViewController.h"
#import "BAMSettings.h"

@implementation RootViewController
@synthesize launchButton;


/*****************************************************************************\
 *                                                                           *
 *                            IMPLEMENTATION NOTE                            *
 *                                                                           *
 *  To implement the BAMSettings in your app, you only need to push it onto  *
 *  an existing navigation controller within your app. Learn how to do this  *
 *  by looking at the buttonPressed: method below. That's everything you'll  *
 *  need to do to use this. The delegate methods are completely optional.    *
 *                                                                           *
\*****************************************************************************/


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Setting the title used by the navigationBar of the current page.
    self.title = @"BAMSettings Demo";
    
    // But I want a different title on the back button.
    self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Launch Screen" style:UIBarButtonItemStyleBordered target:nil action:nil] autorelease];
}

- (void)viewWillAppear:(BOOL)animated {
    // Okay, I'm a control freak and want a different color navigationBar even in a demo app.
    //self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.25f green:0.25f blue:0.25f alpha:1.0f];
    [super viewWillAppear:animated];
}

- (void)viewDidUnload {
    [self setLaunchButton:nil];
    [super viewDidUnload];

    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

- (void)dealloc {
    [launchButton release];
    [super dealloc];
}

#pragma mark - IBAction Methods

- (IBAction)buttonPressed:(id)sender {
    // Load the BAMSettings, set the delegate, push onto the controller and then release. That's all!
    BAMSettings *settings = [[BAMSettings alloc] initWithTitle:@"Settings" propertyListNamed:@"Root"];
    settings.delegate = self;
    [self.navigationController pushViewController:settings animated:YES];
    [settings release];
    
    // This removes my custom navigationBar color from before so the screen looks like Apple's settings app.
    self.navigationController.navigationBar.tintColor = nil;
}

#pragma mark - BAMSettingsDelegate Methods

- (void)settingsDidChangeValueForKey:(NSString *)key {
    NSLog(@"BAMSettingsDelegate settingsViewDidChangeValueForKey:%@ fired", key);
}

- (void)settingsExitedWithChangedValues:(BOOL)didChange {
    NSLog(@"BAMSettingsDelegate settingsViewExitedWithChangedValues:%@ fired", didChange ? @"Yes" : @"No");
}

- (void)settingsNavigatedAwayFromPane:(NSString *)propertyListName withChangedValues:(BOOL)didChange {
    NSLog(@"BAMSettingsDelegate settingsViewNavigatedAwayFromPane:%@ withChangedValues:%@ fired", propertyListName, didChange ? @"Yes" : @"No");
}

@end
