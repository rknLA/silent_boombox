//
//  WCSyncStartWaitingViewController.h
//  SilentBoombox
//
//  Created by Daniel DeCovnick on 2/12/12.
//  Copyright (c) 2012 Softyards Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WCSyncStartWaitingViewController : UIViewController
- (id)initWithListeners:(NSArray *)listeners;
@property (strong, nonatomic) NSArray *listeners;
@end
