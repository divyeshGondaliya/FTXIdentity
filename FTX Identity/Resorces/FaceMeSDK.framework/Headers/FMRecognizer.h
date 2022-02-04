/**
 * @file FMRecognizer.h
 * The interface of CyberLink FaceMe Recognizer.
 * CyberLink FaceMe (R) SDK
 * Copyright (C) 2018 CyberLink Corp. All rights reserved.
 * https://www.cyberlink.com
 */
#import <CoreImage/CoreImage.h>
#import <FaceMeSDK/FMRecognizerObject.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * CyberLink Face Recognizer
 * @interface FaceMeRecognizer
 */
@interface FMRecognizer : NSObject

- (instancetype)init;

#pragma mark - General

/**
 * Initialize FaceMe Recognizer.
 *
 * @param[in] config The configuration for recognizer setup.
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
- (FM_RETURN)initialize:(FMRecognizerConfig *)config licenseInfo:(NSData *)licenseInfo;

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
 * Retrieve feature scheme and model threshold values.
 *
 * @return Returns the scheme information and the False Acceptance Rate of levels.
 */
- (nullable FMFaceFeatureScheme *)getFeatureScheme;

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
 * Get property.
 *
 * @param[in] propertyId An utf-8 encoded string of property identifier.
 * @param[in] args The specified type of reference variant arguments by property identifier.
 * @return Returns the specified type of reference variant value by property identifier.
 */
- (nullable NSObject *)getProperty:(NSString *)propertyId args:(NSObject *)args;

#pragma mark - Face Recognition
/**
 * Retrieve current setting of face extraction.
 *
 * @param[in] extractionOption The options of extraction: minimum and maximum face width, speed and result order.
 * @return Returns the current setting of the extractionOption.
 */
- (UInt32)getExtractionOption:(FM_EXTRACTION_OPTION)extractionOption;

/**
 * Set prefer setting of face extraction.
 *
 * @param[in] extractionOption The options of extraction: minimum and maximum face width, speed and result order.
 * @param[in] value The assigned setting of the extractionOption.
 * @return Returns an <code>FM_RETURN</code>. Possible values include, but
 * are not limited to, the following list.
 *  * <code>FM_RETURN_OK</code>: Succeeded.
 *  * <code>FM_RETURN_NO_INIT</code>: Not initialized yet.
 *  * <code>FM_RETURN_FAIL</code>: Failed.
 *  * <code>FM_RETURN_INVALID_ARGUMENT</code>: The input argument is invalid.
 */
- (FM_RETURN)setExtractionOption:(FM_EXTRACTION_OPTION)extractionOption value:(UInt32)value;

/**
 * Process face detection and extraction.
 *
 * @param[in] extractConfig For configuring the result. Recognition will be processed if enable one of name, age, emotion, or gender. Otherwise face detection only.
 * @param[in] images The array of images to be processed.
 * @return Returns the array of number of faces in input images. The size of array should be the same as array of images.
 */
- (nullable NSArray<NSNumber *> *)extractFace:(FMExtractConfig *)extractConfig images:(NSArray<CIImage *> *)images;

/**
 * Retrieve the information of a specified face.
 *
 * @param[in] imageIndex The index of a specified image in the list of images, should be less than the number of images, the input argument of @ref extractFace.
 * @param[in] faceIndex The index of face in the list of detected faces of a specified image, should be less than count, the output argument of @ref extractFace.
 * @return Return the face information data of the selected face, the containing data is depends on the extraction configuration when calling @ref extractFace.
 */
- (nullable FMFaceInfo *)getFaceInfo:(UInt32)imageIndex faceIndex:(UInt32)faceIndex;

/**
 * Retrieve the landmark of a specified face.
 *
 * @param[in] imageIndex The index of a specified image in the list of images, should be less than the number of images, the input argument of @ref extractFace.
 * @param[in] faceIndex The index of face in the list of detected faces of a specified image, should be less than count, the output argument of @ref ExtractFace.
 * @return Returns thr face landmark of selected face, the containing data is depends on the extraction configuration when calling @ref extractFace.
 */
- (nullable FMFaceLandmark *)getFaceLandmark:(UInt32)imageIndex faceIndex:(UInt32)faceIndex;

/**
 * Retrieve the attribute of a specified face.
 *
 * @param[in] imageIndex The index of a specified image in the list of images, should be less than the number of images, the input argument of @ref extractFace.
 * @param[in] faceIndex The index of face in the list of detected faces of a specified image, should be less than count, the output argument of @ref extractFace.
 * @return Returns the Face attribute data of the selected face, the containing data is depends on the extraction configuration when calling @ref extractFace.
 */
- (nullable FMFaceAttribute *)getFaceAttribute:(UInt32)imageIndex faceIndex:(UInt32)faceIndex;

/**
 * Retrieve feature data of a specified face.
 *
 * @param[in] imageIndex The index of a specified image in the list of images, should be less than the number of images, the input argument of @ref ExtractFace.
 * @param[in] faceIndex The index of face in the list of detected faces of a specified image, should be less than count, the output argument of @ref ExtractFace.
 * @return Returns the face feature data of the selected face.
 */
- (nullable FMFaceFeature *)getFaceFeature:(UInt32)imageIndex faceIndex:(UInt32)faceIndex;

/**
 * Compare two face templates to generate a comparison confidence value.
 *
 * @param[in] faceFeatureA Represents the face template of the first face.
 * @param[in] faceFeatureB Represents the face template of the second face.
 * @return Returns the comparison confidence value to be used for comparing with pre-defined thresholds (see FMFaceFeatureScheme)
 * To further display the similarity on user interface, please use getSimilarity API
 */
- (Float32)compareFaceFeature:(FMFaceFeature *)faceFeatureA faceFeatureB:(FMFaceFeature *)faceFeatureB;

/**
 * Convert comparison confidence value to similarity.
 *
 * @param[in] confidence The compare confidence value between two faces obtained from compareFaceFeature:faceFeatureB: API
 * @return Returns the similarity ranged from 0.0 to 1.0 between two faces.
 */
- (Float32)getSimilarity:(Float32)confidence;

@end

NS_ASSUME_NONNULL_END
