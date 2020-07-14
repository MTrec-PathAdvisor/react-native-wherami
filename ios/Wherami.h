#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>
#import <LBSOfflineSDK/LBSOfflineSDK.h>

@interface Wherami : RCTEventEmitter <RCTBridgeModule,LocationEngineDelegate>

@end