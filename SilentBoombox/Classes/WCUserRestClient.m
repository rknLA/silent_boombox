//
//  WCUserRestClient.m
//  SilentBoombox
//
//  Created by Kevin Nelson on 2/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WCUserRestClient.h"

@implementation WCUserRestClient

@synthesize restClient, delegate, lastGetBoomboxQueryString, lastSyncQueryNumber;

-(id)initWithDelegate: (id)_delegate {
    self = [super init];
    if (self != nil) {
        restClient = [RKClient clientWithBaseURL:@"http://0.0.0.0:8080/"];
        self.delegate = _delegate;
    }
    
    return self;
}


-(void)RESTPostBoombox:(NSString *)spotifyUserID {
    [[RKClient sharedClient] post:@"/boombox"
                           params:[NSDictionary dictionaryWithObject:spotifyUserID
                                                              forKey:@"spotify_id"]
                         delegate:self];
}
-(void)RESTPostListener:(NSString *)spotifyUserID toBoombox:(NSNumber *)boomboxID {
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:spotifyUserID, @"spotify_id",
                            boomboxID, @"boombox_id", nil];
    [[RKClient sharedClient] post:@"/listener"
                           params:params
                         delegate:self];
}
-(void)RESTPostSong:(NSString *)spotifySongID toBoombox:(NSNumber *)boomboxID {
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:spotifySongID, @"spotify_song_id",
                            boomboxID, @"boombox_id", nil];
    [[RKClient sharedClient] post:@"/song"
                           params:params
                         delegate:self];
}
-(void)RESTGetBoombox:(NSString *)spotifyUserID {
    lastGetBoomboxQueryString = spotifyUserID;
    
    [[RKClient sharedClient] get:@"/boombox"
                     queryParams:[NSDictionary dictionaryWithObject:spotifyUserID
                                                              forKey:@"spotify_id"]
                         delegate:self];
}
-(void)RESTPostBuffered:(NSString *)spotifyUserID toBoombox:(NSNumber *)boomboxID {
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:spotifyUserID, @"spotify_id",
                            boomboxID, @"boombox_id", nil];
    [[RKClient sharedClient] post:@"/buffered"
                           params:params
                         delegate:self];
}
-(void)RESTGetSync:(NSNumber *)boomboxID {
    lastSyncQueryNumber = boomboxID;
    
    //do time stuff here
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
                   
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:boomboxID, @"boombox_id",
                            now, @"current_time", nil];
    [[RKClient sharedClient] get:@"/sync"
                     queryParams:params
                        delegate:self];
}

- (void)request:(RKRequest*)request didLoadResponse:(RKResponse*)response {
    if (![response isJSON]) {
        NSLog(@"well that's a weird response... \n%@", [response contentType]);
        return;
    }
    
    if ([request isGET]) {
        if ([[request resourcePath] isEqualToString:@"/boombox"]) {
            NSDictionary* boombox_result = [response parsedBody:nil];
            
            if ([[boombox_result allValues] containsObject:[NSNull null]])
            {
                [self performSelector:@selector(RESTGetBoombox:) withObject:lastGetBoomboxQueryString afterDelay:2.0f];
                return;
            }
            
//            [delegate didFindBoombox:[boombox_result objectForKey:@"boombox_id"] withSongId:[boombox_result objectForKey:@"spotify_song_id"]];
            
        } else if ([[request resourcePath] isEqualToString:@"/sync"]) {
            if ([[response bodyAsString] isEqualToString:@""]) {
                [self performSelector:@selector(RESTGetSync:) withObject:lastSyncQueryNumber afterDelay:1.0f];
                return;
            }
                
                
            NSDictionary* sync_result = [response parsedBody:nil];
            
//            [delegate didFindSync:[sync_result objectForKey:@"sync_time"];
        }
    } else if ([request isPOST]) {
        if ([[request resourcePath] isEqualToString:@"/boombox"]) {
            //didCreateBoomboxWithID
            NSDictionary* boombox_result = [response parsedBody:nil];

//            [delegate didCreateBoomboxWithId:[boombox_result objectForKey:@"boombox_id"]];
            
        } else if ([[request resourcePath] isEqualToString:@"/listener"]) {
            if ([response isOK]) {
//                [delegate didAddListener];
            } else if ([response isClientError]) {
//                [delegate didFailToAddListener];
            } else {
                NSLog(@"A bigger problem has occurred.  Consider checking outside to see if it's the apocalypse.");
            }
        } else if ([[request resourcePath] isEqualToString:@"/song"]) {
            if (![response isOK]) {
                NSLog(@"Problem adding song.  Check the server code.");
            }
        } else if ([[request resourcePath] isEqualToString:@"/buffered"]) {
            if ([response isOK]) {
//                [delegate didPostBuffered];
            } else {
                NSLog(@"I got 99 problems and a /buffered is one.");
            }
        }
    } //else you've got a problem.
    
}  

@end
