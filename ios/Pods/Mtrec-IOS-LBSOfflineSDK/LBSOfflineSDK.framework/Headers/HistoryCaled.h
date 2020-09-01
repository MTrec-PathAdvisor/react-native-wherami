//
//  HistoryCaled.h
//  LBSOfflineSDK
//
//  Created by HU Siyan on 26/9/2019.
//  Copyright © 2019 HU Siyan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HistoryCaled : NSObject

@property (nonatomic, assign) CGPoint location;
@property (nonatomic, assign) NSString *level;
@property (nonatomic, assign) long long timestamp;

@end

NS_ASSUME_NONNULL_END
