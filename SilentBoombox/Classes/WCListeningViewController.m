//
//  WCListeningViewController.m
//  SilentBoombox
//
//  Created by Daniel DeCovnick on 2/12/12.
//  Copyright (c) 2012 Softyards Software. All rights reserved.
//

#import "WCListeningViewController.h"
#import "WCUserRestClient.h"
#import "SilentBoomboxAppDelegate.h"
#import "SPSession.h"
#import "SPTrack.h"
#import "SPUser.h"

@implementation WCListeningViewController
@synthesize titleLabel;
@synthesize artistLabel;
@synthesize coverArtView;
@synthesize client;
@synthesize track;
@synthesize boomboxID;

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
    SPSession *session = appDelegate.spotifySession;
    if ([session preloadTrackForPlayback:self.track error:nil])
    {
        [self.client RESTPostBuffered:session.user.canonicalName toBoombox:self.boomboxID];
    }
}

- (void)viewDidUnload
{
    [self setTitleLabel:nil];
    [self setArtistLabel:nil];
    [self setCoverArtView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (void)didPostBuffered
{
    [self.client RESTGetSync:self.boomboxID];
}
- (void)didFindSync:(NSDate *)startDate
{
    SilentBoomboxAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    SPSession *session = appDelegate.spotifySession;
    NSInvocation *inv = [NSInvocation invocationWithMethodSignature:[session methodSignatureForSelector:@selector(playTrack:error:)]];
    [inv setTarget:session];
    [inv setSelector:@selector(playTrack:error:)];
    NSError *err = nil;
    [inv setArgument:(__bridge void *)self.track atIndex:2];
    [inv setArgument:&err atIndex:3];
    [inv performSelector:@selector(invoke) withObject:nil afterDelay:[startDate timeIntervalSinceNow]];
}

@end
