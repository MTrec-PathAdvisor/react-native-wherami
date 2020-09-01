//
//  LBSBeacon.h
//  LBSOfflineSDK
//
//  Created by HU Siyan on 26/9/2019.
//  Copyright © 2019 HU Siyan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LBSBeacon : NSObject

@property (nonatomic, strong) NSString *uuid;
@property (nonatomic, assign) NSInteger major, minor;

@property (nonatomic, assign) CGPoint location;
@property (nonatomic, strong) NSString *levelId;

- (NSString *)key;

@end

NS_ASSUME_NONNULL_END
