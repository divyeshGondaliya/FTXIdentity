/**
 * @file FMSpeechBaseObject.h
 * The common object for CyberLink FaceMe SDK.
 * CyberLink FaceMe (R) SDK
 * Copyright (C) 2018 CyberLink Corp. All rights reserved.
 * https://www.cyberlink.com
 */

#import <Foundation/Foundation.h>
#import <FaceMeSDK/FMSpeechBaseEnum.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * Contains threshold values for a certain speech feature extractor based on different False Acceptance Rates(FARs).
 *
 * @interface FMSpeechFeatureScheme
 */
API_AVAILABLE(ios(13.0))
@interface FMSpeechFeatureScheme : NSObject
@property (nonatomic, assign) Float32 threshold_1_1e6;                      //!< The confidence threshold for FAR of 1/1e6.
@property (nonatomic, assign) Float32 threshold_1_1e5;                      //!< The confidence threshold for FAR of 1/1e5.
@property (nonatomic, assign) Float32 threshold_1_1e4;                      //!< The confidence threshold for FAR of 1/1e4.
@property (nonatomic, assign) Float32 threshold_1_1e3;                      //!< The confidence threshold for FAR of 1/1e3.
@property (nonatomic, assign) Float32 threshold_1_1e2;                      //!< The confidence threshold for FAR of 1/1e2.
@property (nonatomic, assign) Float32 threshold_1_1e1;                      //!< The confidence threshold for FAR of 1/1e1.
@property (nonatomic, assign) FM_SPEECH_FEATURE_TYPE featureType;          //!< The type of the speech feature.
@property (nonatomic, assign) FM_SPEECH_FEATURE_SUB_TYPE featureSubType;   //!< The sub type of the speech feature.
@end


/**
 * Contains feature data of a speech.
 *
 * @interface FM_SpeechFeatureData
 */
API_AVAILABLE(ios(13.0))
@interface FMSpeechFeatureData : NSObject
/**
 * Float array of face feature data.
 * Use NSData instead of NSArray for performance concern.
 */
@property (nonatomic, strong) NSData *data;
@end

/**
 * Contains feature data of a speech.
 *
 * @interface FMFaceFeature
 */
API_AVAILABLE(ios(13.0))
@interface FMSpeechFeature : NSObject<NSSecureCoding>
@property (nonatomic, assign) FM_SPEECH_FEATURE_TYPE featureType;           //!< The type of the face feature.
@property (nonatomic, assign) FM_SPEECH_FEATURE_SUB_TYPE featureSubType;    //!< The sub type of the face feature.
@property (nonatomic, strong) FMSpeechFeatureData *featureData;             //!< The feature data of the face feature.
@end

NS_ASSUME_NONNULL_END
