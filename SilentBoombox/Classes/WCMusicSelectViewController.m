//
//  WCMusicSelectViewController.m
//  SilentBoombox
//
//  Created by Daniel DeCovnick on 2/12/12.
//  Copyright (c) 2012 Softyards Software. All rights reserved.
//

#import "WCMusicSelectViewController.h"
#import "SilentBoomboxAppDelegate.h"
#import "SPSearch.h"
#import "SPTrack.h"
#import "SPSession.h"
#import "WCUserRestClient.h"
#import "WCListeningViewController.h"

@implementation WCMusicSelectViewController
@synthesize searchField;
@synthesize playButton;
@synthesize search;
@synthesize boomboxID;
@synthesize songID;
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
    self.client = [[WCUserRestClient alloc] initWithDelegate:self];
}

- (void)viewDidUnload
{
    [self setSearchField:nil];
    [self setPlayButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)searchAndPlay:(id)sender {
    SilentBoomboxAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    SPSession *session = appDelegate.spotifySession;
    NSString *query = searchField.text;
    self.search = [SPSearch searchWithSearchQuery:query inSession:session];
    [self.search addObserver:self forKeyPath:@"searchInProgress" options:0 context:nil];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([object isEqual:self.search])
    {
        if ([keyPath isEqualToString:@"searchInProgress"])
        {
            if (!self.search.searchInProgress)
            {
                NSArray *trackResults = self.search.tracks;
                if (trackResults.count == 0)
                {
                    return;
                }
                else
                {
                    SPTrack *targetTrack = [trackResults objectAtIndex:0];
                    NSURL *url = [targetTrack spotifyURL];
                    NSString *urlAsString = [url absoluteString];
                    [self.client RESTPostSong:urlAsString toBoombox:self.boomboxID];
                    self.songID = urlAsString;
                }
            }
        }
    }
}
- (void)didSetSong
{
    SilentBoomboxAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    SPSession *session = appDelegate.spotifySession;
    WCListeningViewController *viewController = [[WCListeningViewController alloc] initWithNibName:@"WCListeningViewController" bundle:nil];
    viewController.boomboxID = self.boomboxID;
    viewController.track = [session trackForURL:[NSURL URLWithString:self.songID]];
    [self.navigationController pushViewController:viewController animated:YES];
}
@end
