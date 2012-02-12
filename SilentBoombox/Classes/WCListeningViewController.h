//
//  WCListeningViewController.h
//  SilentBoombox
//
//  Created by Daniel DeCovnick on 2/12/12.
//  Copyright (c) 2012 Softyards Software. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WCUserRestClient;
@class SPTrack;

@interface WCListeningViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *artistLabel;
@property (weak, nonatomic) IBOutlet UIImageView *coverArtView;
@property (strong, nonatomic) WCUserRestClient *client;
@property (strong, nonatomic) SPTrack *track;
@property (strong, nonatomic) NSNumber *boomboxID;
- (void)didFindSync:(NSDate *)startDate;
- (void)didPostBuffered;
@end
