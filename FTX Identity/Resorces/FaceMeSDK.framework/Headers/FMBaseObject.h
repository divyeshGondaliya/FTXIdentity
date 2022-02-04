/**
 * @file FMBaseObject.h
 * The common object for CyberLink FaceMe SDK.
 * CyberLink FaceMe (R) SDK
 * Copyright (C) 2018 CyberLink Corp. All rights reserved.
 * https://www.cyberlink.com
 */

#import <Foundation/Foundation.h>
#import <FaceMeSDK/FMBaseEnum.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * Contains point information in an XY coordinate.
 *
 * @interface FMPoint
 */
@interface FMPoint : NSObject
@property (nonatomic, assign) SInt16 x; //!< X.
@property (nonatomic, assign) SInt16 y; //!< Y.
@end

/**
 * Contains two points of a rectangle in the XY coordinate.
 *
 * @interface FMRectangle
 */
@interface FMRectangle : NSObject
@property (nonatomic, strong) FMPoint *topLeft; //!< The point of left-top corner.
@property (nonatomic, strong) FMPoint *bottomRight; //!< The point of right-bottom corner.
@end

/**
 * Contains feature points of a face.
 *
 * @interface FMFaceLandmark
 */
@interface FMFaceLandmark : NSObject
@property (nonatomic, strong) NSArray<FMPoint *> *featurePoints;  //!< The feature points.
@end

/**
 * Contains pose of a face.
 *
 * @interface FMPose
 */
@interface FMPose : NSObject
@property (nonatomic, assign) Float32 yaw;  //!< Yaw.
@property (nonatomic, assign) Float32 pitch;    //!< Pitch.
@property (nonatomic, assign) Float32 roll; //!< Roll.
@end

/**
 * Contains feature data of a face.
 *
 * @interface FMFeatureData
 */
@interface FMFeatureData : NSObject
/**
 * Float array of face feature data.
 * Use NSData instead of NSArray for performance concern.
 */
@property (nonatomic, strong) NSData *data;
@end

/**
 * Contains sensor information of a device.
 *
 * @interface FMSensorInfo
 */
@interface FMSensorInfo : NSObject
@property (nonatomic, assign) long ts; //!< timestamp
@property (nonatomic, assign) Float32 accelerometerX;  //!< X-axis acceleration in G's (gravitational force).
@property (nonatomic, assign) Float32 accelerometerY;    //!< Y-axis acceleration in G's (gravitational force).
@property (nonatomic, assign) Float32 accelerometerZ; //!< Z-axis acceleration in G's (gravitational force).
@property (nonatomic, assign) Float32 lux; //!< ambient light luminous flux.
@property (nonatomic, assign) Float32 iso; //!< camera ISO value.
@end

/**
 * Contains threshold values for a certain face feature extractor based on different False Acceptance Rates(FARs).
 *
 * @interface FMFaceFeatureScheme
 */
@interface FMFaceFeatureScheme : NSObject
@property (nonatomic, assign) Float32 threshold_1_1e6;              //!< The confidence threshold for FAR of 1/1e6.
@property (nonatomic, assign) Float32 threshold_1_1e5;              //!< The confidence threshold for FAR of 1/1e5.
@property (nonatomic, assign) Float32 threshold_1_1e4;              //!< The confidence threshold for FAR of 1/1e4.
@property (nonatomic, assign) Float32 threshold_1_1e3;              //!< The confidence threshold for FAR of 1/1e3.
@property (nonatomic, assign) Float32 threshold_1_1e2;              //!< The confidence threshold for FAR of 1/1e2.
@property (nonatomic, assign) FM_FEATURE_TYPE featureType;          //!< The type of the face feature.
@property (nonatomic, assign) FM_FEATURE_SUB_TYPE featureSubType;   //!< The sub type of the face feature.
@property (nonatomic, assign) FM_FEATURE_METADATA_TYPE metadataType;   //!< The type of metadata of the face feature.
@property (nonatomic, assign) UInt32 metadataSize;                  //!< The size of the metadata.
@property (nonatomic, strong) NSArray<NSNumber *> *metadata;        //!< The custom metadata.
@end

/**
 * Contains information of a face.
 *
 * @interface FMFaceInfo
 */
@interface FMFaceInfo : NSObject
@property (nonatomic, assign) FM_FEATURE_OPTIONS options;
@property (nonatomic, assign) Float32 confidence;
@property (nonatomic, strong) FMRectangle *boundingBox;
@property (nonatomic, assign) FM_OCCLUSION_STATUS occlusion;
@end

/**
 * Contains attributes of a face.
 *
 * @interface FMFaceAttribute
 */
@interface FMFaceAttribute : NSObject
@property (nonatomic, assign) FM_FEATURE_OPTIONS options;   //!< The options of extracted feature.
@property (nonatomic, assign) Float32 age;  //!< The age of the face.
@property (nonatomic, assign) FM_EMOTION emotion;   //!< The emotion of the face.
@property (nonatomic, assign) FM_GENDER gender; //!< The gender of the face.
@property (nonatomic, strong) FMPose *pose; //!< The pose of the face.
@end

/**
 * Contains feature data of a face.
 *
 * @interface FMFaceFeature
 */
@interface FMFaceFeature : NSObject
@property (nonatomic, assign) FM_FEATURE_TYPE featureType;  //!< The type of the face feature.
@property (nonatomic, assign) FM_FEATURE_SUB_TYPE featureSubType;   //!< The sub type of the face feature.
@property (nonatomic, strong) FMFeatureData *featureData;   //!< The feature data of the face feature.
@end

NS_ASSUME_NONNULL_END
