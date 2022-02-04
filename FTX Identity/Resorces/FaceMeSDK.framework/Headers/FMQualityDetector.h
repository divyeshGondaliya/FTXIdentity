/*
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 *
 * CyberLink FaceMe (R) SDK
 * Copyright (c) CyberLink Corp. All rights reserved.
 * https://www.cyberlink.com
 */

#import <CoreImage/CoreImage.h>
#import <FaceMeSDK/FMQualityDetectorObject.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMQualityDetector : NSObject

- (instancetype)init;

// General
/**
 * Initialize FaceMe Quality Detector.
 *
 * @param[in] config The configuration for quality detector setup.
 * @param[in] licenseInfo The license information provided by CyberLink. The format of license information is a raw buffer.
 * @return Returns an <code>FR_RETURN</code>. Possible values include, but
 * are not limited to, the following list.
 *  * <code>FR_RETURN_OK</code>: Succeeded.
 *  * <code>FR_RETURN_FAIL</code>: Failed.
 *  * <code>FR_RETURN_INVALID_ARGUMENT</code>: The input argument is invalid.
 *  * <code>FR_RETURN_INCONSISTENT_VERSION</code>: The version of input data structure is not accepted or not filled in.
 *  * <code>FR_RETURN_LICENSE_FAIL</code>: The license is invalid.
 *  * <code>FR_RETURN_LICENSE_EXPIRED</code>: The license is expired.
 */
- (FM_RETURN)Initialize:(nullable FMQualityDetectorConfig*)config licenseInfo:(nullable NSData*)licenseInfo;

/**
 * Finalize FaceMe SDK and release corresponding resources.
 *
 * @return Returns an <code>FR_RETURN</code>. Possible values include, but
 * are not limited to, the following list.
 *  * <code>FR_RETURN_OK</code>: Succeeded.
 *  * <code>FR_RETURN_NO_INIT</code>: Not initialized yet.
 *  * <code>FR_RETURN_FAIL</code>: Failed.
 */
- (FM_RETURN)finalize;

/**
 * Set property.
 *
 * @param[in] propertyId An utf-8 encoded string of property identifier.
 * @param[in] value The specified type of reference variant value by property identifier.
 * @return Returns an <code>FR_RETURN</code>. Possible values include, but
 * are not limited to, the following list.
 *  * <code>FR_RETURN_OK</code>: Succeeded.
 *  * <code>FR_RETURN_INVALID_ARGUMENT</code>: The property identifier is not found.
 */
- (FM_RETURN)setProperty:(nullable NSString *)propertyId value:(nullable NSObject*)value;

/**
 * Get property.
 *
 * @param[in] propertyId An utf-8 encoded string of property identifier.
 * @return Returns an <code>FR_RETURN</code>. Possible values include, but
 * are not limited to, the following list.
 *  * <code>FR_RETURN_OK</code>: Succeeded.
 *  * <code>FR_RETURN_INVALID_ARGUMENT</code>: The property identifier is not found.
 */
- (nullable NSObject *)getProperty:(nullable NSString*)propertyId;

/**
 * Check image quality.
 *
 * @param[in] detectConfig Configuration for detection.
 * @param[in] image An image to be processed.
 * @param[out] result Retrieve the result that if there is any quality issue be detected.
 * @return Returns an <code>FR_RETURN</code>. Possible values include, but
 * are not limited to, the following list.
 *  * <code>FR_RETURN_OK</code>: Succeeded.
 *  * <code>FR_RETURN_FALSE</code>: Detecting is in progress.
 *  * <code>FR_RETURN_NO_INIT</code>: Not initialized yet.
 *  * <code>FR_RETURN_FAIL</code>: Failed.
 *  * <code>FR_RETURN_INVALID_ARGUMENT</code>: The input argument is invalid.
 */
- (FM_RETURN)detect:(FMQualityDetectConfig*)detectConfig image:(nullable CIImage*)image result:(NSArray<FMQualityDetectResult*> *_Nonnull *_Nonnull)result;

@end

NS_ASSUME_NONNULL_END
