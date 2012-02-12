//
//  WCAddListenersViewController.h
//  SilentBoombox
//
//  Created by Daniel DeCovnick on 2/11/12.
//  Copyright (c) 2012 Softyards Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WCUserRestClient;

@interface WCAddListenersViewController : UIViewController
{
    NSMutableArray *listeners;
    __weak IBOutlet UITextField *listenerIdField;
    __weak IBOutlet UITableView *mTableView;
}
- (IBAction)doneTouched:(id)sender;
- (IBAction)addListener:(id)sender;
@property (nonatomic, strong, readwrite) WCUserRestClient *client;
@property (nonatomic, strong, readwrite) NSNumber *boomboxID;
- (void)didAddListener;
- (void)didFailToAddListener;
@end
