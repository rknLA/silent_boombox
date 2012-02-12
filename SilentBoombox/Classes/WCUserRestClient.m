//
//  WCUserRestClient.m
//  SilentBoombox
//
//  Created by Kevin Nelson on 2/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WCUserRestClient.h"

@implementation WCUserRestClient

- (void)sendRequests {  
    // Perform a simple HTTP GET and call me back with the results  
    [[RKClient sharedClient] get:@"/foo.xml" delegate:self];  
    
    // Send a POST to a remote resource. The dictionary will be transparently  
    // converted into a URL encoded representation and sent along as the request body  
    NSDictionary* params = [NSDictionary dictionaryWithObject:@"RestKit" forKey:@"Sender"];  
    [[RKClient sharedClient] post:@"/other.json" params:params delegate:self];  
    
    // DELETE a remote resource from the server  
    [[RKClient sharedClient] delete:@"/missing_resource.txt" delegate:self];  
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
    
    
    
    if ([request isGET]) {  
        // Handling GET /foo.xml  
        
        if ([response isOK]) {  
            // Success! Let's take a look at the data  
            NSLog(@"Retrieved XML: %@", [response bodyAsString]);  
        }  
        
    } else if ([request isPOST]) {  
        
        // Handling POST /other.json  
        if ([response isJSON]) {  
            NSLog(@"Got a JSON response back from our POST!");  
        }  
        
    } else if ([request isDELETE]) {  
        
        // Handling DELETE /missing_resource.txt  
        if ([response isNotFound]) {  
            NSLog(@"The resource path '%@' was not found.", [request resourcePath]);  
        }  
    }  
}  

@end
