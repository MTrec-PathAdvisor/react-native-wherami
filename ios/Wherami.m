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
    dispatch_async(dispatch_get_main_queue(), ^{
        [LocationEngine engine];
        [[LocationEngine engine] setDelegate:self];
        [[LocationEngine engine] authorityNotify:self];
    });
//    [LocationEngine engine];
    
    // sendEvent(reactContext, "onReady", null);
    [self sendEventWithName:@"onReady" body:nil];
    
};
                  
RCT_EXPORT_METHOD(start)
{
    NSLog(@"ios:start engine");
    // [LocationEngine engine];
    // [[LocationEngine engine] setDelegate:self];
    // [[LocationEngine engine] authorityNotify:self];
    dispatch_async(dispatch_get_main_queue(), ^{

        [[LocationEngine engine] turnOnPosition];
    });
    [self sendEventWithName:@"onEngineStarted" body:nil];
    // sendEvent(reactContext, "onEngineStarted", null);
    
};
                  
RCT_EXPORT_METHOD(stop)
{
    NSLog(@"ios:stop engine");
    dispatch_async(dispatch_get_main_queue(), ^{
        [[LocationEngine engine] turnOffPosition];
    });
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
        [self sendEventWithName:@"onLocationUpdate" body:@{@"location":[NSNull null]}];
        return;
    }else{
        NSNumber *x=[NSNumber numberWithFloat:history.location.x];
        NSNumber *y=[NSNumber numberWithFloat:history.location.y];
        NSNumber *radius=[NSNumber numberWithFloat:0.0];
        NSDictionary * locationMap =@{
                             @"x" : x,
                             @"y" : y,
                             @"areaId" : history.level,
                             @"radius": radius
                             };
        NSLog(@"loc update: %@",locationMap.description);
        [self sendEventWithName:@"onLocationUpdate" body:@{@"location":locationMap}];
        
    }
    
};

@end
