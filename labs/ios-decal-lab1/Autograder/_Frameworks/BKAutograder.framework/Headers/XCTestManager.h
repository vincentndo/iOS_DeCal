//
//  XCTestManager.h
//  BKAutograder
//
//  Created by Chris Zielinski on 1/18/18.
//  Copyright © 2018 iOS Development DeCal @ UC Berkeley. All rights reserved.
//

#import "XCTestManagerIDEServerDelegate.h"
#import "CDStructures.h"

@class XCIDESession, XCTestManagerIDEServer;

@interface XCTestManager : NSObject <XCTestManagerIDEServerDelegate, NSXPCListenerDelegate>
{
    NSString *_clientIdentifier;
    NSString *_clientPath;
    XCIDESession *_controlSession;
    XCTestManagerIDEServer *_server;
    NSXPCListener *_testBundleConnectionListener;
    NSMutableDictionary *_sessionsByIdentifier;
    NSMutableArray *_unidentifiedSessions;
    NSMutableArray *_testSessions;
    NSMutableDictionary *_pendingTestConnectionRequests;
}

+ (id)sharedTestManager;
@property(retain) NSMutableDictionary *pendingTestConnectionRequests; // @synthesize pendingTestConnectionRequests=_pendingTestConnectionRequests;
@property(retain) NSMutableArray *testSessions; // @synthesize testSessions=_testSessions;
@property(retain) NSMutableArray *unidentifiedSessions; // @synthesize unidentifiedSessions=_unidentifiedSessions;
@property(retain) NSMutableDictionary *sessionsByIdentifier; // @synthesize sessionsByIdentifier=_sessionsByIdentifier;
@property(retain) NSXPCListener *testBundleConnectionListener; // @synthesize testBundleConnectionListener=_testBundleConnectionListener;
@property(retain) XCTestManagerIDEServer *server; // @synthesize server=_server;
@property(retain, nonatomic) XCIDESession *controlSession; // @synthesize controlSession=_controlSession;
@property(retain) NSString *clientPath; // @synthesize clientPath=_clientPath;
@property(retain) NSString *clientIdentifier; // @synthesize clientIdentifier=_clientIdentifier;
- (void)_considerExiting:(id)arg1;
- (void)closeTestSession:(id)arg1;
- (void)closeIDESession:(id)arg1;
- (_Bool)allowUITestControlForPID:(int)arg1;
- (void)_handleRequestForSessionWithIdentifier:(id)arg1;
- (void)requestSocketForSessionIdentifier:(id)arg1 reply:(CDUnknownBlockType)arg2;
- (_Bool)listener:(id)arg1 shouldAcceptNewConnection:(id)arg2;
- (void)setIDESession:(id)arg1 forIdentifier:(id)arg2;
- (void)serverReceivedIDESession:(id)arg1;
- (void)run;
- (id)init;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned int hash;
@property(readonly) Class superclass;

@end
