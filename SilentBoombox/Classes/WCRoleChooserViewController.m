//
//  WCRoleChooserViewController.m
//  SilentBoombox
//
//  Created by Daniel DeCovnick on 2/11/12.
//  Copyright (c) 2012 Softyards Software. All rights reserved.
//

#import "WCRoleChooserViewController.h"
#import "WCAddListenersViewController.h"
#import "WCUserRestClient.h"
#import "SilentBoomboxAppDelegate.h"
#import "SPSession.h"
#import "SPUser.h"

@implementation WCRoleChooserViewController
@synthesize client;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)pickedDJ:(id)sender {
    //request POST /boombox
    
    
    
    WCAddListenersViewController *addListenersViewController = [[WCAddListenersViewController alloc] initWithNibName:@"WCAddListenersViewController" bundle:nil];
    [self.navigationController pushViewController:addListenersViewController animated:YES];
}

- (IBAction)pickedListener:(id)sender {
    self.client = [[WCUserRestClient alloc] initWithDelegate:self];
    SilentBoomboxAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    [client RESTGetBoombox:appDelegate.spotifySession.user.canonicalName];
}
@end
