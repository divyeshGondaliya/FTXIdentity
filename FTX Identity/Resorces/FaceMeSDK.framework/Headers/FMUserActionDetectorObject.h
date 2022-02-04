/*
* DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
*
* CyberLink FaceMe (R) SDK
* Copyright (c) CyberLink Corp. All rights reserved.
* https://www.cyberlink.com
*/

#import <Foundation/Foundation.h>
#import <CoreImage/CoreImage.h>
#import <FaceMeSDK/FMBaseObject.h>
#import <FaceMeSDK/FMUserActionDetectorEnum.h>

/**
 * Contains User Action Detector Configuration.
 *
 * @interface FMUserActionDetectorConfig
 */
@interface FMUserActionDetectorConfig : NSObject
/**
 * The application folder path to be used for data saving.
 */
@property (nonatomic, strong) NSString *appDataPath API_AVAILABLE(macos(10.13));
@property (nonatomic, assign) FM_UA_PREFERENCE preference;          //!< @see FM_UA_PREFERENCE .
@property (nonatomic, strong) FMFaceFeatureScheme* featureScheme;

- (instancetype)init;

@end

/**
 * Contains Detect Configuration.
 *
 * @interface FMUserActionDetectConfig
 */
@interface FMUserActionDetectConfig : NSObject
@property (nonatomic, assign) Float32 confidenceThreshold;              //!< The threshold of the confidence.
@property (nonatomic, strong) FMRectangle* region;                       //!< The region to be analyzed.
@property (nonatomic, strong) FMFaceInfo *faceInfo;                     //!< The face information for analyzed.
@property (nonatomic, strong) FMFaceAttribute *faceAttribute;           //!< The face attribute for analyzed.
@property (nonatomic, strong) FMFaceFeature *faceFeature;               //!< The feature vector of the face to be analyzed.
@property (nonatomic, strong) CIImage *image;                           //!< The image to detect action.

- (instancetype)init;
@end
