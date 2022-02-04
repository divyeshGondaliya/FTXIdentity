/**
 * @file FMLivenessDetectorConfig.h
 * The common object for CyberLink FaceMe License Manager.
 * CyberLink FaceMe (R) SDK
 * Copyright (C) 2018 CyberLink Corp. All rights reserved.
 * https://www.cyberlink.com
 */

#import <Foundation/Foundation.h>
#import <FaceMeSDK/FMBaseObject.h>
#import <FaceMeSDK/FMLivenessDetectorEnum.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * Contains Liveness Detector Configuration.
 *
 * @interface FMLivenessDetectorConfig
 */
@interface FMLivenessDetectorConfig : NSObject
/**
 * The application folder path to be used for data saving.
 */
@property (nonatomic, strong) NSString *appDataPath API_AVAILABLE(macos(10.13));
@property (nonatomic, assign) FM_LIVENESS_DETECTION_MODE detectionMode;  //! Face liveness detection mode
@property (nonatomic, strong) NSString *depthCamId;                      //!< The identifier of depth camera, represented by utf-8 encoded string.

- (instancetype)init;

@end

/**
 * Contains LivenessDetect Configuration.
 *
 * @interface FMLivenessDetectConfig
 */
@interface FMLivenessDetectConfig : NSObject
@property (nonatomic, assign) Float32 confidenceThreshold;              //!< The threshold of the confidence.
@property (nonatomic, strong) NSArray <FMFaceFeature *> *features;      //!< The feature vector of the face to be analyzed.
@property (nonatomic, strong) NSArray <FMFaceLandmark *> *landmarks;    //!< The feature points of the face to be analyzed.
@property (nonatomic, strong) NSArray <FMPose *> *poses;                //!< The face pose for analyzed.
@property (nonatomic, assign) bool discontinuity;                       //!< The discontinuity of the input image frames.

- (instancetype)init;
@end


/**
 * Contains DepthMap Info.
 *
 * @interface FMDepthMap
 */
@interface FMDepthMap : NSObject
@property (nonatomic, strong) NSData *data;                          //!< The depth map raw data.
@property (nonatomic, assign) UInt32 width;                         //!< The width of the depth map.
@property (nonatomic, assign) UInt32 height;                        //!< The height of the depth map.
@property (nonatomic, assign) UInt32 stride;                        //!< The line stride of the depth map.
@property (nonatomic, assign) UInt32 channel;                       //!< The channels of a pixel.
@property (nonatomic, assign) UInt32 bytesPerPixel;                 //!< The bytes of a pixel.
@property (nonatomic, assign) FM_DEPTH_MAP_FORMAT depthMapFormat;  //!< The depth map format.


- (instancetype)init;
@end

/**
 * Contains LivenessResult Info.
 *
 * @interface FMFaceLivenessResult
 */
@interface FMFaceLivenessResult : NSObject
@property (nonatomic, assign) FM_FACE_LIVENESS_STATUS status;       //!< Face liveness status.
@property (nonatomic, assign) Float32 probability;                  //!< The probability of the face to be live.

- (instancetype)init;
@end

NS_ASSUME_NONNULL_END
