//
//  WCSyncStartWaitingViewController.h
//  SilentBoombox
//
//  Created by Daniel DeCovnick on 2/12/12.
//  Copyright (c) 2012 Softyards Software. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WCUserRestClient;

@interface WCSyncStartWaitingViewController : UIViewController

- (id)initWithListeners:(NSArray *)listeners;

@property (strong, nonatomic) NSArray *listeners;

@property (nonatomic, weak) IBOutlet UILabel *userLabel;
@property (nonatomic, weak) IBOutlet UILabel *waitingLabel;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *loadingWheel;
@property (strong, readwrite) WCUserRestClient *client;
-(void)didFindBoombox:(NSNumber *)boombox_id withSongId:(NSString *)song_id;

@end
