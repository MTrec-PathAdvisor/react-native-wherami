//
//  LocationEngine.h
//  LBSOfflineSDK
//
//  Created by HU Siyan on 26/9/2019.
//  Copyright © 2019 HU Siyan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LocationEngineDelegate <NSObject>
@optional

- (void)didUpdateLocation:(HistoryCaled *)history;

@end

@interface LocationEngine : NSObject

+ (instancetype)engine;
- (void)authorityNotify:(UIViewController *)vc;
- (void)turnOnPosition;
- (void)turnOffPosition;

- (HistoryCaled *)getCurrentPosition;

@property (nonatomic, strong) id <LocationEngineDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
