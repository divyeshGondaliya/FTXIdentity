/**
 * @file FMBaseEnum.h
 * The common definition for CyberLink FaceMe SDK.
 * CyberLink FaceMe (R) SDK
 * Copyright (C) 2018 CyberLink Corp. All rights reserved.
 * https://www.cyberlink.com
 */

#import <Foundation/Foundation.h>

/**
 * Status return code.
 */
typedef NS_ENUM(NSInteger, FM_RETURN)
{
    /**
     * Async operation.
     */
    FM_RETURN_ASYNC = 2,
    /**
     * False.
     */
    FM_RETURN_FALSE = 1,
    /**
     * Succeeded.
     */
    FM_RETURN_OK = 0,
    /**
     * Failed.
     */
    FM_RETURN_FAIL = -1,
    /**
     * Out of memory error.
     */
    FM_RETURN_OUT_OF_MEMORY = -2,
    /**
     * Not implement error.
     */
    FM_RETURN_NOT_IMPLEMENT = -3,
    /**
     * Invalid argument error.
     */
    FM_RETURN_INVALID_ARGUMENT = -4,
    /**
     * Index out of range error.
     */
    FM_RETURN_INDEX_OUT_OF_RANGE = -5,
    /**
     * Unexpected error.
     */
    FM_RETURN_UNEXPECTED = -6,
    /**
     * Inconsistent data structure version error.
     */
    FM_RETURN_INCONSISTENT_VERSION = -7,
    /**
     * Not initialize error.
     */
    FM_RETURN_NOT_INIT = -8,
    /**
     * Configuration error.
     */
    FM_RETURN_CONFIG_ERROR = -9,
    /**
     * Not found error.
     */
    FM_RETURN_NOT_FOUND = -10,
    /**
     * Not support error.
     */
    FM_RETURN_NOT_SUPPORT = -11,
    
    /**
     * Feature size mismatch.
     */
    FM_RETURN_FEATURE_SIZE_MISMATCH = -30,
    /**
     * Database access error.
     */
    FM_RETURN_DATABASE_ERROR = -31,
    /**
    * Feature extract incomplete for add.
    */
    FM_RETURN_FEATURE_INCOMPLETE = -32,
    /**
    * Collection count in database is exceeded.
    */
    FM_RETURN_DATABASE_COLLECTION_EXCEEDED = -33,
    /**
    * Database password is not match certain rules.
    */
    FM_RETURN_DATABASE_ENCRYPTION_INVALID_SETTING = -34,
    /**
    * Database password is incorrect.
    */
    FM_RETURN_DATABASE_ENCRYPTION_INCORRECT_PASSWORD = -35,
    /**
    * Database cannot change to enable/disable encryption setting when any record exists.
    */
    FM_RETURN_DATABASE_ENCRYPTION_INVALID_DATABASE_DATA = -36,
    
    /**
     * Unknown license server.
     */
    FM_RETURN_UNKNOWN_HOST = -40,
    /**
     * Network issue while communicate with license server.
     */
    FM_RETURN_NETWORK_ERROR = -41,
    /**
     * License is failed.
     */
    FM_RETURN_LICENSE_FAIL = -42,
    /**
     * License is expired.
     */
    FM_RETURN_LICENSE_EXPIRED = -43,
    /**
     * License activation is exceeded.
     */
    FM_RETURN_LICENSE_ACTIVATION_EXCEEDED = -44,
    /**
     * License feature is not support.
     */
    FM_RETURN_LICENSE_NOT_SUPPORT = -45,
    /**
     * License hardware is constrained.
     */
    FM_RETURN_LICENSE_CONSTRAIN_HARDWARE = -46,
    /**
     * License server error.
     */
    FM_RETURN_LICENSE_SERVER_ERROR = -47,
    /**
     * License package name is restricted.
     */
    FM_RETURN_LICENSE_INVALID_PACKAGE_NAME = -48,
    
    /**
     * License key is incorrect.
    */
    FM_RETURN_LICENSE_INCORRECT_KEY = -49,
    
    /**
     * FaceMe runtime files are not complete.
     */
    FM_RETURN_RUNTIME_FILE_NOT_COMPLETE = -50,
    /**
     * Inference engine is not support.
     */
    FM_RETURN_INFERENCE_ENGINE_NOT_SUPPORT = -51,
    /**
     * License is not authorized on current platform.
    */
    FM_RETURN_LICENSE_INCORRECT_PLATFORM = -60,
    /**
     * License period does not start yet.
     */
    FM_RETURN_LICENSE_PERIOD_NOT_START = - 61,
    
    /**
     * Camera initialize failed.
     */
    FM_RETURN_CAMERA_INIT_FAIL = -150,
    /**
     * Audio recorder initialize failed.
     */
    FM_RETURN_AUDIO_INIT_FAIL = -151,
    /**
     * Camera permission denied.
     */
    FM_RETURN_CAMERA_PERMISSION_DENIED = -152,
    /**
     * Audio permission denied.
     */
    FM_RETURN_AUDIO_PERMISSION_DENIED = -153,
};

/**
 * Pixel format.
 */
typedef NS_ENUM(NSInteger, FM_PIXEL_FORMAT)
{
    /**
     * Unknown.
     */
    FM_PIXEL_FORMAT_UNKNOWN = 0,
    /**
     * BGRA 32-bit pixel format.
     */
    FM_PIXEL_FORMAT_BGRA,
    /**
     * RGBA 32-bit pixel format.
     */
    FM_PIXEL_FORMAT_RGBA,
    /**
     * BGR 24-bit pixel format.
     */
    FM_PIXEL_FORMAT_BGR,
    /**
     * RGB 24-bit pxel format.
     */
    FM_PIXEL_FORMAT_RGB
};

/**
 * The type of emotion.
 */
typedef NS_ENUM(NSInteger, FM_EMOTION)
{
    /**
     * Unknown.
     */
    FM_EMOTION_UNKNOWN = 0,
    /**
     * Happy.
     */
    FM_EMOTION_HAPPY,
    /**
     * Surprised.
     */
    FM_EMOTION_SURPRISED,
    /**
     * Sad.
     */
    FM_EMOTION_SAD,
    /**
     * Angry.
     */
    FM_EMOTION_ANGRY,
    /**
     * Neutral.
     */
    FM_EMOTION_NEUTRAL,
};

/**
 * The type of gender.
 */
typedef NS_ENUM(NSInteger, FM_GENDER)
{
    /**
     * Unknown.
     */
    FM_GENDER_UNKNOWN = 0,
    /**
     * Male.
     */
    FM_GENDER_MALE,
    /**
     * Female.
     */
    FM_GENDER_FEMALE
};

/**
 * The type of feature Landmark.
 */
typedef NS_ENUM(NSInteger, FM_LANDMARK)
{
    /**
     * Feature point of left eye.
     */
    FM_LANDMARK_EYE_LEFT = 0,
    /**
     * Feature point of right eye.
     */
    FM_LANDMARK_EYE_RIGHT,
    /**
     * Feature point of nose.
     */
    FM_LANDMARK_EYE_NOSE,
    /**
     * Feature point of left mouth.
     */
    FM_LANDMARK_EYE_MOUTH_LEFT,
    /**
     * Feature point of right mouth.
     */
    FM_LANDMARK_EYE_MOUTH_RIGHT
};

/**
 * The level of precision.
 */
typedef NS_ENUM(NSInteger, FM_PRECISION_LEVEL)
{
    /**
     * 1e6
     */
    FM_PRECISION_LEVEL_1E6 = 0,
    /**
     * 1e5
     */
    FM_PRECISION_LEVEL_1E5,
    /**
     * 1e4
     */
    FM_PRECISION_LEVEL_1E4,
    /**
     * 1e3
     */
    FM_PRECISION_LEVEL_1E3,
    /**
     * 1e2
     */
    FM_PRECISION_LEVEL_1E2
};

/**
 * Face feature options.
 */
typedef NS_ENUM(NSInteger, EFM_FEATURE_OPTIONS)
{
    /**
     * None.
     */
    FM_FEATURE_OPTION_NONE = 0,
    /**
     * Extract bounding box.
     */
    FM_FEATURE_OPTION_BOUNDING_BOX = (1LL << 1),
    /**
     * Extract feature landmark.
     */
    FM_FEATURE_OPTION_FEATURE_LANDMARK = (1LL << 2),
    /**
     * Extract face feature.
     */
    FM_FEATURE_OPTION_FEATURE = (1LL << 3),
    /**
     * Extract emotion.
     */
    FM_FEATURE_OPTION_EMOTION = (1LL << 4),
    /**
     * Extract age.
     */
    FM_FEATURE_OPTION_AGE = (1LL << 5),
    /**
     * Extract gender.
     */
    FM_FEATURE_OPTION_GENDER = (1LL << 6),
    /**
     * Extract pose.
     */
    FM_FEATURE_OPTION_POSE = (1LL << 7),
    /**
     * Extract Occlusion.
     */
    FM_FEATURE_OPTION_OCCLUSION = (1LL << 0),
    /**
     * Extract Masked Feature.
     */
    FM_FEATURE_OPTION_MASKED_FEATURE = (1LL << 8),
    /**
     *  Extract Full Feature.
     */
    FM_FEATURE_OPTION_FULL_FEATURE = ((1LL << 3) | (1LL << 8)),
    /**
     * Extract all.
     */
    FM_FEATURE_OPTION_ALL = 0x7fffffff,
};

/**
 * Face feature options.
 */
typedef NSInteger FM_FEATURE_OPTIONS;

/**
 * The type of face feature.
 */
typedef NS_ENUM(NSInteger, FM_FEATURE_TYPE)
{
    /**
     * None.
     */
    FM_FEATURE_TYPE_NONE = 0,
    /**
     * Standard precision.
     */
    FM_FEATURE_TYPE_STANDARD_PRECISION = 1,
    /**
     * High precision.
     */
    FM_FEATURE_TYPE_HIGH_PRECISION = 2,
    /**
     * Ultra-High precision.
     */
    FM_FEATURE_TYPE_ULTRA_HIGH_PRECISION = 3,
    /**
     * Very-High precision.
     */
    FM_FEATURE_TYPE_VERY_HIGH_PRECISION = 4,
    /**
     * Ultra-High precision 3.
     */
    FM_FEATURE_TYPE_UH3 = 5,
    /**
     * High precision 3.
     */
    FM_FEATURE_TYPE_H3 = 6,
    /**
     * Very-High presicion 5.
     */
    FM_FEATURE_TYPE_VH5 = 8,
    /**
     * High precision 5.
     */
    FM_FEATURE_TYPE_H5 = 9,
    /**
     * Very-High presicion 6.
     */
    FM_FEATURE_TYPE_VH6 = 11,
    /**
     * High precision 6.
     */
    FM_FEATURE_TYPE_H6 = 12,
};

/**
 * The sub type of face feature.
 */
typedef NS_ENUM(NSInteger, FM_FEATURE_SUB_TYPE)
{
    /**
     * None.
     */
    FM_FEATURE_SUB_TYPE_NONE = 0,
    /**
     * Asian.
     */
    FM_FEATURE_SUB_TYPE_ASIAN = 1,
    /**
     * Mask.
    */
    FM_FEATURE_SUB_TYPE_MASK = 2
};

/**
 * The type of metadata of face feature.
 *
 * @enum EFR_FEATURE_METADATA_TYPE
 */
typedef NS_ENUM(NSInteger, FM_FEATURE_METADATA_TYPE)
{
    FM_FEATURE_METADATA_TYPE_NONE = 0,    //!< None.
    FM_FEATURE_METADATA_TYPE_MASK = 1    //!< Mask.
};

/**
 * Face occlusion status.
 */
typedef NS_ENUM(NSInteger, EFM_OCCLUSION_STATUS)
{
    /**
     * None.
     */
    FM_OCCLUSION_STATUS_NONE = 0,                        //!< None.
    /**
     * Left Eye Occluded..
     */
    FM_OCCLUSION_STATUS_LEFT_EYE = (1LL << 0),            //!< Left Eye Occluded.
    /**
     * Right Eye Occluded.
     */
    FM_OCCLUSION_STATUS_RIGHT_EYE = (1LL << 1),            //!< Right Eye Occluded.
    /**
     * Nose Occluded.
     */
    FM_OCCLUSION_STATUS_NOSE = (1LL << 2),                //!< Nose Occluded.
    /**
     * Mouth Occluded.
     */
    FM_OCCLUSION_STATUS_MOUTH = (1LL << 3),                //!< Mouth Occluded.
    /**
     * Mask detected.
     */
    FM_OCCLUSION_STATUS_MASK = (1LL << 4)                //!< Mask detected.
};

/**
 * Face occlusion status.
 *
*/
typedef int32_t FM_OCCLUSION_STATUS;

#if !defined(__FACEME_BASE_OBHECT_H__)
#define __FACEME_BASE_OBHECT_H__
#define FM_OPT(option) ((NSInteger)(option))
#define FM_SUCCEEDED(hr) (((FM_RETURN)(hr)) >= 0)
#define FM_FAILED(hr) (((FM_RETURN)(hr)) < 0)
#endif // __FACEME_BASE_OBHECT_H__
