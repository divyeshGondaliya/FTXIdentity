/**
 * @file FMSpeechRecognizer.h
 * The interface of CyberLink FaceMe Speech Recognizer.
 * CyberLink FaceMe (R) SDK
 * Copyright (C) 2018 CyberLink Corp. All rights reserved.
 * https://www.cyberlink.com
 */
#import <FaceMeSDK/FMBaseEnum.h>
#import <FaceMeSDK/FMSpeechRecognizerObject.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * CyberLink Face Speech Recognizer
 * @interface FMSpeechRecognizer
 */
API_AVAILABLE(ios(13.0))
@interface FMSpeechRecognizer : NSObject

- (instancetype)init;

#pragma mark - General

/**
 * Initialize FaceMe Speech Recognizer.
 *
 * @param[in] config The configuration for speech recognizer setup.
 * @param[in] licenseInfo The license information provided by CyberLink. The format of license information is a raw buffer.
 * @return Returns an <code>FM_RETURN</code>. Possible values include, but
 * are not limited to, the following list.
 *  * <code>FM_RETURN_OK</code>: Succeeded.
 *  * <code>FM_RETURN_FAIL</code>: Failed.
 *  * <code>FM_RETURN_INVALID_ARGUMENT</code>: The input argument is invalid.
 *  * <code>FM_RETURN_INCONSISTENT_VERSION</code>: The version of input data structure is not accepted or not filled in.
 *  * <code>FM_RETURN_LICENSE_FAIL</code>: The license is invalid.
 *  * <code>FM_RETURN_LICENSE_EXPIRED</code>: The license is expired.
 *  * <code>FM_RETURN_LICENSE_NOT_SUPPORT</code>: The license feature is not supported.
 */
- (FM_RETURN)initialize:(FMSpeechRecognizerConfig *)config licenseInfo:(NSData *)licenseInfo;

/**
 * Finalize FaceMe SDK and release corresponding resources.
 *
 * @return Returns an <code>FM_RETURN</code>. Possible values include, but
 * are not limited to, the following list.
 *  * <code>FM_RETURN_OK</code>: Succeeded.
 *  * <code>FM_RETURN_NO_INIT</code>: Not initialized yet.
 *  * <code>FM_RETURN_FAIL</code>: Failed.
 */
- (FM_RETURN)finalize;

/**
 * Retrieve speech feature scheme and model threshold values.
 *
 * @param[in] schemeType The specified type of feature scheme.
 * @return Returns the scheme information and the False Acceptance Rate of levels.
 */
- (nullable FMSpeechFeatureScheme *)getSpeechFeatureScheme:(FM_SPEECH_FEATURE_SCHEME_TYPE)schemeType;

/**
 * Set property.
 *
 * @param[in] propertyId An utf-8 encoded string of property identifier.
 * @param[in] value The specified type of reference variant value by property identifier.
 * @return Returns an <code>FM_RETURN</code>. Possible values include, but
 * are not limited to, the following list.
 *  * <code>FM_RETURN_OK</code>: Succeeded.
 *  * <code>FM_RETURN_INVALID_ARGUMENT</code>: The property identifier is not found.
 */
- (FM_RETURN)setProperty:(NSString *)propertyId value:(NSObject *)value;

/**
 * Get property.
 *
 * @param[in] propertyId An utf-8 encoded string of property identifier.
 * @return Returns the specified type of reference variant value by property identifier.
 */
- (nullable NSObject *)getProperty:(NSString *)propertyId;

#pragma mark - Speech Compare

/**
 * Compare the similarity between two speechs.
 *
 * @param[in] speechFeatureA Represents the feature vector of the first speech.
 * @param[in] speechFeatureB Represents the feature vector of the second speech.
 * @return Returns the similarity confidence ranged from 0.0 to 1.0 between two speech.
 */
- (Float32)compareSpeechFeature:(FMSpeechFeature *)speechFeatureA faceFeatureB:(FMSpeechFeature *)speechFeatureB;

@end

NS_ASSUME_NONNULL_END
