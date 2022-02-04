/**
 * @file FMDataManagerbject.h
 * The common object for CyberLink FaceMe Data Manager.
 * CyberLink FaceMe (R) SDK
 * Copyright (C) 2018 CyberLink Corp. All rights reserved.
 * https://www.cyberlink.com
 */

#import <FaceMeSDK/FMBaseObject.h>
#import <FaceMeSDK/FMDataManagerEnum.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * Contains Data Manager Configuration.
 *
 * @interface FMDataManagerConfig
 */
@interface FMDataManagerConfig : NSObject
/**
 * The application folder path to be used for data saving.
 */
@property (nonatomic, strong) NSString *appDataPath API_AVAILABLE(macos(10.13));
@property (nonatomic, assign) BOOL dataEncryption;
@property (nonatomic, strong) NSData *password;

- (instancetype)init;

@end


/**
 * Contains Similar Face result.
 *
 * @interface FMSimilarFaceResult
 */
@interface FMSimilarFaceResult : NSObject
@property (nonatomic, assign) SInt64 collectionId;        //!< The unique identifier of the collection.
@property (nonatomic, assign) SInt64 faceId;                //!< The unique identifier of the face.
@property (nonatomic, assign) Float32 confidence;            //!< The confidence between 0.0 and 1.0 of the face.
@end

/**
 * Contains Query result.
 *
 * @interface FMQueryResult
 */
@interface FMQueryResult : NSObject
@property (nonatomic, strong) NSArray<NSNumber *> *queryIds;   //!< The list of face collection or face identifiers.
@property (nonatomic, assign) SInt64 next;                //!< Next offset of face collection. Returns -1 when EOF is reached.
@end

/**
 * Contains Query Count result.
 *
 * @interface FMQueryCountResult
 */
@interface FMQueryCountResult : NSObject
@property (nonatomic, assign) SInt32 count;               //!< The actual count of face collection or face identifiers.
@property (nonatomic, assign) SInt64 next;                //!< Next offset of face collection. Returns -1 when EOF is reached.
@end

NS_ASSUME_NONNULL_END
