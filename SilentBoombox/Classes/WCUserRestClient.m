//
//  WCUserRestClient.m
//  SilentBoombox
//
//  Created by Kevin Nelson on 2/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WCUserRestClient.h"

@implementation WCUserRestClient

@synthesize restClient, delegate;

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
            for (NSString *key in boombox_result)
            {
                if ([[boombox_result objectForKey:key] isEqualToString:@"<null>"])
                {
                    [self performSelector:@selector(RESTGetBoombox:) withObject:[(NSDictionary *)[request params] objectForKey:@"spotify_id"] afterDelay:2.0f];
                    return;
                }
            }
            [delegate didFindBoombox:[boombox_result objectForKey:@"boombox_id"] withSongId:[boombox_result objectForKey:@"spotify_song_id"]];
            
        } else if ([[request resourcePath] isEqualToString:@"/sync"]) {
            if ([[response bodyAsString] isEqualToString:@""]) {
                [self performSelector:@selector(RESTGetSync:) withObject:[(NSDictionary *)[request params] objectForKey:@"boombox_id"] afterDelay:1.0f];
                return;
            }
                
                
            NSDictionary* sync_result = [response parsedBody:nil];
            
            [delegate didFindSync:[sync_result objectForKey:@"sync_time"];
        }
    } else if ([request isPOST]) {
        if ([[request resourcePath] isEqualToString:@"/boombox"]) {
            
        } else if ([[request resourcePath] isEqualToString:@"/listener"]) {
            
        } else if ([[request resourcePath] isEqualToString:@"/song"]) {
            
        } else if ([[request resourcePath] isEqualToString:@"/buffered"]) {
            
        }
    } //else you've got a problem.
    
}  

@end
