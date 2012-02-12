//
//  WCMusicSelectViewController.h
//  SilentBoombox
//
//  Created by Daniel DeCovnick on 2/12/12.
//  Copyright (c) 2012 Softyards Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SPSearch;
@class WCUserRestClient;

@interface WCMusicSelectViewController : UIViewController
@property (weak, nonatomic) IBOutlet UISearchBar *searchField;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (strong, readwrite) SPSearch *search;
@property (strong, readwrite) WCUserRestClient *client;
@property (strong, readwrite) NSNumber *boomboxID;
@property (strong, readwrite) NSString *songID;
- (IBAction)searchAndPlay:(id)sender;
- (void)didSetSong;
@end
