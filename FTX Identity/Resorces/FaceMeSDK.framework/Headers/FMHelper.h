/**
 * @file FMHelper.h
 * The interface of CyberLink FaceMe Helper.
 * CyberLink FaceMe (R) SDK
 * Copyright (c) CyberLink Corp. All rights reserved.
 * https://www.cyberlink.com
 */

#import <FaceMeSDK/FMBaseObject.h>
#import <FaceMeSDK/FMSpeechBaseObject.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMHelper : NSObject

/**
 * Serialize the Face Feature.
 *
 * @param[in] feature A face feature to be serialized.
 * @return Returns an object of data blob of serialized face feature
*/
+ (NSData *)serializeFaceFeature:(FMFaceFeature *)feature;

/**
 * Deserialize the Face Feature.
 *
 * @param[in] featureData The data block of serialized face feature.
 * @return Returns a deserialized face feature.
*/
+ (FMFaceFeature *)deserializeFaceFeature:(NSData *)featureData;

/**
 * Serialize the Speech Feature.
 *
 * @param[in] feature A speech feature to be serialized.
 * @return Returns an object of data blob of serialized speech feature.
*/
+ (NSData *)serializeSpeechFeature:(FMSpeechFeature *)feature API_AVAILABLE(ios(13.0));

/**
 * Deserialize the Speech Feature.
 *
 * @param[in] featureData The data block of serialized speech feature.
 * @return Returns a speech feature of deserialized.
*/
+ (FMSpeechFeature *)deserializeSpeechFeature:(NSData *)featureData API_AVAILABLE(ios(13.0));

@end

NS_ASSUME_NONNULL_END
