#import "Wherami.h"


@implementation Wherami

bool needPermission=TRUE;

RCT_EXPORT_MODULE()

- (NSArray<NSString *> *)supportedEvents{
    return@[@"onReady",@"onEngineStarted",@"onEngineStopped",@"onLocationUpdate",@"requestPermission",@"message"];
}

RCT_EXPORT_METHOD(checkSelfPermission)
{
  NSLog(@"ios:Check Self Permission");

  if(needPermission){
      NSDictionary* params= @{@"missingPermissions": @"missingPermissions"};
                   
    [self sendEventWithName:@"requestPermission" body:params];
  }else{
      //init sdk
  }
};
    
RCT_EXPORT_METHOD(initializeSDK)
{
    NSLog(@"ios:initialize ios-SDK");
    [LocationEngine engine];
    [[LocationEngine engine] setDelegate:self];
    [[LocationEngine engine] authorityNotify:self];
    // sendEvent(reactContext, "onReady", null);
    [self sendEventWithName:@"onReady" body:nil];
    
};
                  
RCT_EXPORT_METHOD(start)
{
    NSLog(@"ios:start engine");
    [[LocationEngine engine] turnOnPosition];
    [self sendEventWithName:@"onEngineStarted" body:nil];
    // sendEvent(reactContext, "onEngineStarted", null);
    
};
                  
RCT_EXPORT_METHOD(stop)
{
    NSLog(@"ios:stop engine");
    [[LocationEngine engine] turnOffPosition];
    [self sendEventWithName:@"onEngineStopped" body:nil];
    // sendEvent(reactContext, "onEngineStopped", null);
};
    
// - (void) sendEvent:(ReactContext) reactContext :(String *) eventName : @Nullable (WritableMap) params {
//     reactContext.
//             getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
//             .emit(eventName, params);
// }

#pragma mark - LocationEngineDelegate

- (void)didUpdateLocation:(HistoryCaled *)history{
    if (!history) {
        [self sendEventWithName:@"onLocationUpdate" body:@{@"location":nil}];
        return;
    }else{
        NSDictionary * locationMap =@{
                             @"x" : history.location.x,
                             @"y" : history.location.y,
                             @"areaId" : history.level,
                             @"radius": @"location.radius"
                             };
        [self sendEventWithName:@"onLocationUpdate" body:@{@"location":locationMap}];
        
    }
    
};

@end
