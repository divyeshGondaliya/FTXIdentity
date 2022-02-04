/**
 * @file FMLivenessDetector.h
 * The interface of CyberLink FaceMe License Manager.
 * CyberLink FaceMe (R) SDK
 * Copyright (C) 2018 CyberLink Corp. All rights reserved.
 * https://www.cyberlink.com
 */
#import <CoreImage/CoreImage.h>
#import <FaceMeSDK/FMLivenessDetectorObject.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * CyberLink Face Liveness Detector
 * @interface FaceMeLicenseManager
 */
@interface FMLivenessDetector : NSObject

- (instancetype)init;

#pragma mark - General

/**
 * Initialize FaceMe LivenessDetector.
 *
 * @param[in] config The configuration for livenessDetector setup.
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
- (FM_RETURN)initialize:(FMLivenessDetectorConfig *)config licenseInfo:(NSData *)licenseInfo;

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

/**
 * Function for setting liveness option in future.
 * setDetectionOption
 *
 * @param[in] detectionOption the option of liveness detection.
 * @param[in] value assigned to option.
 * @return Returns the specified type of reference variant value by property identifier.
 */
- (FM_RETURN)setDetectionOption:(FM_LIVENESS_DETECTION_OPTION)detectionOption value:(UInt32)value;

/**
 * Function for setting liveness option in future.
 * getDetectionOption
 *
 * @param[in] detectionOption the option of liveness detection.
 * @return Returns value assigned to option.
 */
- (UInt32)getDetectionOption:(FM_LIVENESS_DETECTION_OPTION)detectionOption;

#pragma mark - License


- (FM_RETURN)detect:(FMLivenessDetectConfig *)detectConfig
              image:(CIImage *)image
           depthMap:(FMDepthMap *)depthMap
       boundingBoxs:(NSArray<FMRectangle *> *)boundingBoxs
         numOfFaces:(UInt32)numOfFaces
    livenessResults:(NSArray<FMFaceLivenessResult*> *_Nonnull*_Nonnull)livenessResults;
    // using NSArray, because livenessResult need to save multiple result when numOfFaces>1 
    // change object pointer to pointer of object pointer, otherwise content of livenessResults won't remain after return to caller

@end

NS_ASSUME_NONNULL_END
