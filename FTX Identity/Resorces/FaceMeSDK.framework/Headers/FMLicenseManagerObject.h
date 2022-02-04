/**
 * @file FMLicenseManagerObject.h
 * The common object for CyberLink FaceMe License Manager.
 * CyberLink FaceMe (R) SDK
 * Copyright (C) 2018 CyberLink Corp. All rights reserved.
 * https://www.cyberlink.com
 */

#import <Foundation/Foundation.h>
#import <FaceMeSDK/FMBaseObject.h>
#import <FaceMeSDK/FMLicenseManagerEnum.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * Contains License Manager Configuration.
 */
@interface FMLicenseManagerConfig : NSObject
/**
 * The application folder path to be used for data saving.
 */
@property (nonatomic, strong) NSString *appDataPath API_AVAILABLE(macos(10.13));

- (instancetype)init;

@end

NS_ASSUME_NONNULL_END
