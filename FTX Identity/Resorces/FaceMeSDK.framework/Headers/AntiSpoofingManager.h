/*
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 *
 * CyberLink FaceMe (R) SDK
 * Copyright (c) CyberLink Corp. All rights reserved.
 * https://www.cyberlink.com
 */

#import <Foundation/Foundation.h>

@interface AntiSpoofingManager : NSObject

#pragma mark - Constructor
+ (instancetype)sharedManager;

- (void)initWithLicenseInfo:(NSData *)licenseInfo;
- (BOOL)isInited;
- (NSData *)getLicenseInfo;
- (void)setDumpEnable:(BOOL)enable;

@end
