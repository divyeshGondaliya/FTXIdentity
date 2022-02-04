/**
 * @file FMDataManager.h
 * The interface of CyberLink FaceMe Data Manager.
 * CyberLink FaceMe (R) SDK
 * Copyright (C) 2018 CyberLink Corp. All rights reserved.
 * https://www.cyberlink.com
 */
#import <FaceMeSDK/FMDataManagerObject.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * CyberLink Face Data Manager
 * @interface FaceMeDataManager
 */
@interface FMDataManager : NSObject

- (instancetype)init;

#pragma mark - General

/**
 * Initialize FaceMe Data Manager.
 *
 * @param[in] config The configuration for data manager setup.
 * @param[in] featureScheme Retrieve the feature information and the False Acceptance Rate of levels.
 * @param[in] licenseInfo The license information provided by CyberLink. The format of license information is a raw buffer.
 * @return Returns an <code>FM_RETURN</code>. Possible values include, but
 * are not limited to, the following list.
 *  * <code>FM_RETURN_OK</code>: Succeeded.
 *  * <code>FM_RETURN_FAIL</code>: Failed.
 *  * <code>FM_RETURN_INVALID_ARGUMENT</code>: The input argument is invalid.
 *  * <code>FM_RETURN_INCONSISTENT_VERSION</code>: The version of input data structure is not accepted or not filled in.
 *  * <code>FM_RETURN_LICENSE_FAIL</code>: The license is invalid.
 *  * <code>FM_RETURN_LICENSE_EXPIRED</code>: The license is expired.
 */
- (FM_RETURN)initialize:(FMDataManagerConfig *)config
          featurescheme:(FMFaceFeatureScheme *)featureScheme
            licenseInfo:(NSData *)licenseInfo;

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

#pragma mark - Face Data Manager

/**
 * Get confidence threshold of precision level.
 *
 * @param[in] level Represent the False Acceptance Rate level.
 * @return Represents the confidence threshold of a specified precision level.
 */
- (Float32)getPrecisionThreshold:(FM_PRECISION_LEVEL)level;

/**
 * Add a new face collection.
 *
 * @param[in] name An utf-8 encoded string name belongs to the adding face collection.
 * @return Retrieve a new unique identifier represents the added face collection.
 */
- (SInt64)createFaceCollection:(NSString *)name;

/**
 * Delete a specified face collection.
 *
 * @param[in] collectionId An unique identifier represents a specified face collection.
 * @return Returns an <code>FM_RETURN</code>. Possible values include, but
 * are not limited to, the following list.
 *  * <code>FM_RETURN_OK</code>: Succeeded.
 *  * <code>FM_RETURN_NO_INIT</code>: Not initialized yet.
 *  * <code>FM_RETURN_FAIL</code>: Failed.
 *  * <code>FM_RETURN_INDEX_OUT_OF_RANGE</code>: The index is out of range.
 */
- (FM_RETURN)deleteFaceCollection:(SInt64)collectionId;

/**
 * Query face collections.
 *
 * @param[in] start Starting offset of face collection.
 * @param[in] count Set the number of face collection identifiers wanted to retrieve.
 * @return Returns a list of face collection identifiers.
 */
- (nullable FMQueryResult *)queryFaceCollection:(SInt64)start count:(SInt32)count;

/**
 * Query count of face collections.
 *
 * @param[in] start Starting offset of face collection.
 * @param[in] count Set the number of face collection identifiers wanted to retrieve.
 * @return Returns an actual count of the face collection.
 */
- (nullable FMQueryCountResult *)queryFaceCollectionCount:(SInt64)start count:(SInt32)count;

/**
 * Query face collections by name.
 *
 * @param[in] name An utf-8 encoded string name of face collection.
 * @param[in] start starting offset of face collection.
 * @param[in] count Set the number of face collection identifiers wanted to retrieve.
 * @return Returns a list of face collection identifiers.
 */
- (nullable FMQueryResult *)queryFaceCollectionByName:(NSString *)name
                                                start:(SInt64)start
                                                count:(SInt32)count;

/**
 * Query count of face collections by name.
 *
 * @param[in] name An utf-8 encoded string name of face collection.
 * @param[in] start starting offset of face collection.
 * @param[in] count Set the number of face collection identifiers wanted to retrieve.
 * @return Returns an actual count of the face collection.
 */
- (nullable FMQueryCountResult *)queryFaceCollectionCountByName:(NSString *)name
                                                          start:(SInt64)start
                                                          count:(SInt32)count;
/**
 * Set custom data block to the face collection.
 *
 * @param[in] collectionId An unique identifier represents a specified face collection.
 * @param[in] customData The data block of user data.
 * @return Returns an <code>FM_RETURN</code>. Possible values include, but
 * are not limited to, the following list.
 *  * <code>FM_RETURN_OK</code>: Succeeded.
 *  * <code>FM_RETURN_NO_INIT</code>: Not initialized yet.
 *  * <code>FM_RETURN_FAIL</code>: Failed.
 *  * <code>FM_RETURN_INDEX_OUT_OF_RANGE</code>: The index is out of range.
 */
- (FM_RETURN)setFaceCollectionCustomData:(SInt64)collectionId customData:(nullable NSData *)customData;

/**
 * Get user data block from the face collection.
 *
 * @param[in] collectionId An unique identifier represents a specified face collection.
 * @return Returns an object of data blob of user data.
 */
- (nullable NSData *)getFaceCollectionCustomData:(SInt64)collectionId;

/**
 * Get collection name from the face collection.
 *
 * @param[in] collectionId An unique identifier represents a specified face collection.
 * @return Returns an utf-8 encoded string name object.
 */
- (nullable NSString *)getFaceCollectionName:(SInt64)collectionId;

/**
 * Set the name of the face collection.
 *
 * @param[in] collectionId An unique identifier represents a specified face collection.
 * @param[in] name An utf-8 encoded string name of the collection.
 * @return Returns an <code>FM_RETURN</code>. Possible values include, but
 * are not limited to, the following list.
 *  * <code>FM_RETURN_OK</code>: Succeeded.
 *  * <code>FM_RETURN_NO_INIT</code>: Not initialized yet.
 *  * <code>FM_RETURN_FAIL</code>: Failed.
 *  * <code>FM_RETURN_INDEX_OUT_OF_RANGE</code>: The index is out of range.
 */
- (FM_RETURN)setFaceCollectionName:(SInt64)collectionId name:(NSString *)name;

/**
 * Search similar faces from a face collection.
 *
 * @param[in] confidenceThreshold A confidence threshold between 0.0 and 1.0.
 * @param[in] collectionId An unique identifier represents a specified face collection. Search from all face collections when the value is -1.
 * @param[in] faceFeature The feature vector of the face to be searched.
 * @param[in] maxNumOfCandidates Set the maximum number of similar faces wanted to retrieved.
 * @return Returns the list of similar faces.
 */
- (nullable NSArray<FMSimilarFaceResult *> *)searchSimilarFace:(Float32)confidenceThreshold
                                                  collectionId:(SInt64)collectionId
                                                   faceFeature:(FMFaceFeature *)faceFeature
                                            maxNumOfCandidates:(SInt32)maxNumOfCandidates;

/**
 * Add a new face to the face collection.
 *
 * @param[in] collectionId An unique identifier represents a specified face collection.
 * @param[in] faceFeature The face feature of the new face.
 * @return Returns a new unique identifier represents the added face.
 */
- (SInt64)addFace:(SInt64)collectionId faceFeature:(FMFaceFeature *)faceFeature;

/**
 * Delete a specified face.
 *
 * @param[in] faceId An unique identifier represents a specified face.
 * @return Returns an <code>FM_RETURN</code>. Possible values include, but
 * are not limited to, the following list.
 *  * <code>FM_RETURN_OK</code>: Succeeded.
 *  * <code>FM_RETURN_NO_INIT</code>: Not initialized yet.
 *  * <code>FM_RETURN_FAIL</code>: Failed.
 *  * <code>FM_RETURN_INDEX_OUT_OF_RANGE</code>: The index is out of range.
 */
- (FM_RETURN)deleteFace:(SInt64)faceId;

/**
 * Query faces from a face collection.
 *
 * @param[in] collectionId An unique identifier represents a specified collection.
 * @param[in] start starting offset of face.
 * @param[in] count Set the number of face identifiers wanted to retrieve.
 * @return Returns a list of face identifiers.
 */
- (nullable FMQueryResult *)queryFace:(SInt64)collectionId
                                start:(SInt64)start
                                count:(SInt32)count;

/**
 * Query count of faces from a face collection.
 *
 * @param[in] collectionId An unique identifier represents a specified collection.
 * @param[in] start starting offset of face.
 * @param[in] count Set the number of face identifiers wanted to retrieve.
 * @return Returns a list of face identifiers.
 */
- (nullable FMQueryCountResult *)queryFaceCount:(SInt64)collectionId
                                          start:(SInt64)start
                                          count:(SInt32)count;

/**
 * Get the face collection from  a face.
 *
 * @param[in] faceId An unique identifier represents a specified face.
 * @return Returns a face collection identifier associate with the speciftied face.
 */
- (SInt64)getFaceCollectionFromFace:(SInt64)faceId;

/**
 * Set custom data block to the face.
 *
 * @param[in] faceId An unique identifier represents a specified face.
 * @param[in] customData The data block of custom data.
 * @return Returns an <code>FM_RETURN</code>. Possible values include, but
 * are not limited to, the following list.
 *  * <code>FM_RETURN_OK</code>: Succeeded.
 *  * <code>FM_RETURN_NO_INIT</code>: Not initialized yet.
 *  * <code>FM_RETURN_FAIL</code>: Failed.
 *  * <code>FM_RETURN_INDEX_OUT_OF_RANGE</code>: The index is out of range.
 */
- (FM_RETURN)setFaceCustomData:(SInt64)faceId customData:(nullable NSData *)customData;

/**
 * Get custom data block from the face.
 *
 * @param[in] faceId An unique identifier represents a specified face.
 * @return Returns an object of data blob of custom data.
 */
- (nullable NSData *)getFaceCustomData:(SInt64)faceId;

/**
 * Get a feature vector from a face.
 *
 * @param[in] faceId An unique identifier represents a specified face.
 * @return Returns the feature vector of the specified face.
 */
- (nullable FMFaceFeature *)getFaceFeature:(SInt64)faceId;
@end

NS_ASSUME_NONNULL_END
