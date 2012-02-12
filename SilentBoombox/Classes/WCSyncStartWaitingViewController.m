//
//  WCSyncStartWaitingViewController.m
//  SilentBoombox
//
//  Created by Daniel DeCovnick on 2/12/12.
//  Copyright (c) 2012 Softyards Software. All rights reserved.
//

#import "WCSyncStartWaitingViewController.h"
#import "WCUserRestClient.h"
#import "SilentBoomboxAppDelegate.h"
#import "SPSession.h"
#import "SPUser.h"
#import "WCListeningViewController.h"

@implementation WCSyncStartWaitingViewController
@synthesize listeners, userLabel, waitingLabel, loadingWheel, client;

- (id)initWithListeners:(NSArray *)_listeners
{
    self = [self initWithNibName:@"WCSyncStartWaitingViewController" bundle:nil];
    self.listeners = _listeners;
    return self;
}
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
    self.client = [[WCUserRestClient alloc] initWithDelegate:self];
    SilentBoomboxAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    [client RESTGetBoombox:appDelegate.spotifySession.user.canonicalName];
    
    self.userLabel.text = appDelegate.spotifySession.user.canonicalName;
    [self.loadingWheel startAnimating];
    
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

-(void)didFindBoombox:(NSNumber *)boombox_id withSongId:(NSString *)song_id {
    self.waitingLabel.text = @"Buffering...";
    WCListeningViewController *viewController = [[WCListeningViewController alloc] initWithNibName:@"WCListeningViewController" bundle:nil];
    viewController.boomboxID = boombox_id;
    SilentBoomboxAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    viewController.track = [appDelegate.spotifySession trackForURL:[NSURL URLWithString:song_id]];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
