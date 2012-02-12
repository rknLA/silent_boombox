//
//  SilentBoomboxAppDelegate.h
//  SilentBoombox
//
//  Created by Daniel DeCovnick on 2/11/12.
//  Copyright 2012 Softyards Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SPSession;

@interface SilentBoomboxAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
}

@property (nonatomic, strong) IBOutlet UIWindow *window;
@property (nonatomic, strong) IBOutlet UINavigationController *navigationController;
@property (nonatomic, strong) SPSession *spotifySession;
@end

