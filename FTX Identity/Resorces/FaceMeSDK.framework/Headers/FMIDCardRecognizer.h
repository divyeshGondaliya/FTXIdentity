/**
 * @file FMIDCardRecognizer.h
 * The interface of CyberLink FaceMe ID Card Recognizer.
 * CyberLink FaceMe (R) SDK
 * Copyright (c) CyberLink Corp. All rights reserved.
 * https://www.cyberlink.com
 */
#import <CoreImage/CoreImage.h>
#import <FaceMeSDK/FMRecognizer.h>
#import <FaceMeSDK/FMIDCardRecognizerObject.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * CyberLink Face IDCard Recognizer
 * @interface FMIDCardRecognizer
 */
@interface FMIDCardRecognizer : NSObject

- (instancetype)init;

#pragma mark - General

/**
 * Initialize FaceMe IDCardRecognizer.
 *
 * @param[in] config The configuration for IDCardRecognizer setup.
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
- (FM_RETURN)initialize:(FMIDCardRecognizerConfig *)config licenseInfo:(NSData *)licenseInfo;

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


#pragma mark - Detect

/**
* Reset Liveness status of ID Card.
*
* @return Returns an <code>FM_RETURN</code>. Possible values include, but
* are not limited to, the following list.
*  * <code>FM_RETURN_OK</code>: Succeeded.
*  * <code>FR_RETURN_NO_INIT</code>: not initialized yet.
*/
- (FM_RETURN)resetStatus;

/**
* Detect ID Card.
*
* @param[in] detectConfig Providing configuration to improve the detection.
* @param[in] image The image to detect ID card.
* @param[in,out] detectionResult The information of detection result.
* @param[out] deskewImage An object of deskew image. Caller should release this object after use.
* @return Returns an <code>FM_RETURN</code>. Possible values include, but
* are not limited to, the following list.
*  * <code>FM_RETURN_OK</code>: Succeeded.
*  * <code>FM_RETURN_FAIL</code>: Failed.
*  * <code>FM_RETURN_NOT_FOUND</code>: ID Card is not detected.
*  * <code>FM_RETURN_INVALID_ARGUMENT</code>: The input argument is invalid.
*  * <code>FM_RETURN_INCONSISTENT_VERSION</code>: The version of input data structure is not accepted or not filled in.
*/
- (FM_RETURN)detect:(FMIDCardDetectConfig *)detectConfig
              image:(CIImage *)image
    detectionResult:(FMIDCardDetectResult *_Nonnull*_Nonnull)detectionResult
        deskewImage:(CIImage *_Nonnull*_Nullable)deskewImage;

/**
 * Scan ID Card text information.
 *
 * @param[in] scanConfig   Providing configuration to scan text from ID card.
 * @param[in] image        The image of the ID card to scan text.
 * @param[in,out] result   The information of the scan result.
 * @param[out] deskewImage An object of deskew image. Caller should release this object after use.
 *
 * @return Returns an <code>FR_RETURN</code>. Possible values include, but
 * are not limited to, the following list.
 *  * <code>FM_RETURN_OK</code>: Succeeded.
 *  * <code>FM_RETURN_FAIL</code>: Failed.
 *  * <code>FM_RETURN_NOT_FOUND</code>: ID Card is not detected.
 *  * <code>FM_RETURN_INVALID_ARGUMENT</code>: The input argument is invalid.
 *  * <code>FM_RETURN_INCONSISTENT_VERSION</code>: The version of input data structure is not accepted or not filled in.
 */
- (FM_RETURN)scan:(FMIDCardScanConfig *)scanConfig
            image:(CIImage *)image
           result:(FMIDCardScanResult *_Nonnull*_Nullable)result
      deskewImage:(CIImage *_Nonnull*_Nullable)deskewImage API_AVAILABLE(ios(13.0)); 

/**
* Verify the similarity between real face and face from ID card.
*
* @param[in] faceImage Represents the image of the real face.
* @param[in] idCardFaceImage Represents the image of the face from ID card.
* @return Returns the similarity confidence ranged from 0.0 to 1.0.
*/
- (Float32) verifyFace:(CIImage *_Nonnull)faceImage
       idCardFaceImage:(CIImage *_Nonnull)idCardFaceImage;

@end

NS_ASSUME_NONNULL_END
