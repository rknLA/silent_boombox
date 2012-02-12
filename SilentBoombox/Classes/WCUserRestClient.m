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
    [[RKClient sharedClient] get:@"/sync"
                     queryParams:[NSDictionary dictionaryWithObject:boomboxID
                                                             forKey:@"boombox_id"]
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
            NSLog(@"We should have a dictionary here: \n%@", boombox_result);
        } else if ([[request resourcePath] isEqualToString:@"/sync"]) {
            
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
