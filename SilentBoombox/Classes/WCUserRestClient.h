//
//  WCUserRestClient.h
//  SilentBoombox
//
//  Created by Kevin Nelson on 2/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h> 

@interface WCUserRestClient : NSObject <RKRequestDelegate>

-(void)RESTPostBoombox:(NSString *)spotifyUserID;
-(void)RESTPostListener:(NSString *)spotifyUserID toBoombox:(NSNumber *)boomboxID;
-(void)RESTPostSong:(NSString *)spotifySongID toBoombox:(NSNumber *)boomboxID;
-(void)RESTGetBoombox:(NSString *)spotifyUserID;
-(void)RESTPostBuffered:(NSString *)spotifyUserID toBoombox:(NSNumber *)boomboxID;
-(void)RESTGetSync:(NSNumber *)boomboxID;

@end
