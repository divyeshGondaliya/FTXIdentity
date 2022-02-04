/*
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 *
 * CyberLink FaceMe (R) SDK
 * Copyright (c) CyberLink Corp. All rights reserved.
 * https://www.cyberlink.com
 */

#import <Foundation/Foundation.h>
#import <FaceMeSDK/FMBaseObject.h>
#import <FaceMeSDK/FMQualityDetectorEnum.h>

#ifndef FMQualityDetectorObject_h
#define FMQualityDetectorObject_h

/**
 * Contains Quality Detector Configuration.
 *
 * @interface FMQualityDetectorConfig
 */
@interface FMQualityDetectorConfig : NSObject
/**
 * The application folder path to be used for data saving.
 */
@property (nonatomic, strong) NSString *appDataPath API_AVAILABLE(macos(10.13));
@property (nonatomic, assign) FM_QC_PREFERENCE preference;  //!< @see EFR_QC_PREFERENCE.

- (instancetype)init;

@end

/**
 * Contains LivenessDetect Configuration.
 *
 * @interface FMLivenessDetectConfig
 */
@interface FMQualityDetectConfig : NSObject
@property (nonatomic, assign) FM_QUALITY_ISSUE_OPTIONS detectType;  //!< The detect type.
@property (nonatomic, assign) FM_QUALITY_CHECK_MODE checkMode;        //!< The mode of photo quality check.
@property (nonatomic, assign) FM_BLUR_QUALITY_MODE blurDetectMode;    //!< Different detect config for blur detection
@property (nonatomic, assign) SInt32 overExposureThreshold;          //!< The threshold of over exposure.
@property (nonatomic, assign) SInt32 underExposureThreshold;         //!< The threshold of under exposure.

@property (nonatomic, assign) SInt32 faceCount;                     //!< Count of faces. When faceCount > 0, faceInfos, faceLandmarks and poses cannot be nullptr.
@property (nonatomic, strong) NSArray <FMFaceInfo *> *faceInfos;                 //!< The face information for analyzed.
@property (nonatomic, strong) NSArray <FMFaceLandmark *> *faceLandmarks;         //!< The feature landmarks for analzed.
@property (nonatomic, strong) NSArray <FMPose *> *poses;                         //!< The face poses for analyzed.

- (instancetype)init;
@end

/**
 * Contains results of photo quality check.
 *
 * @interface FMQualityDetectResult
 */
@interface FMQualityDetectResult : NSObject
@property (nonatomic, assign) FM_QUALITY_ISSUE_OPTIONS issue;                    //!< The detect result.
@property (nonatomic, assign) Float32 blur;                                     //!< The value of blurriness.
@property (nonatomic, assign) Float32 exposure;                                 //!< The value of exposure.
@property (nonatomic, assign) SInt32 faceSize;                              //!< The face size. (pixel)
@property (nonatomic, strong) FMPose* wrongAngle;                             //!< The wrong face angle.
@property (nonatomic, assign) FM_OCCLUSION_FAIL_REASON occlusionReason;       //!< @see EFM_OCCLUSION_FAIL_REASON.
@property (nonatomic, assign) FM_GADGET_DETECT_REASON gadgetReason;       //!< @see EFM_GADGET_DETECT_REASON.

- (instancetype)init;
@end

#endif /* FMQualityDetectorObject_h */
