//
//  SilentBoomboxAppDelegate.h
//  SilentBoombox
//
//  Created by Daniel DeCovnick on 2/11/12.
//  Copyright 2012 Softyards Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SilentBoomboxAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end

