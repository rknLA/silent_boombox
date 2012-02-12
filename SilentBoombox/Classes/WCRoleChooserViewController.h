//
//  WCRoleChooserViewController.h
//  SilentBoombox
//
//  Created by Daniel DeCovnick on 2/11/12.
//  Copyright (c) 2012 Softyards Software. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WCUserRestClient;

@interface WCRoleChooserViewController : UIViewController
- (IBAction)pickedDJ:(id)sender;
- (IBAction)pickedListener:(id)sender;
@property (strong, readwrite) WCUserRestClient *client;
- (void)didCreateBoomboxWithId:(NSNumber *)boomboxID;
@end
