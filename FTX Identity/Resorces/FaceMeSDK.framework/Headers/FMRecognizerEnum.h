/**
 * @file FMRecognizerEnum.h
 * The common definition for CyberLink FaceMe Recognizer.
 * CyberLink FaceMe (R) SDK
 * Copyright (C) 2018 CyberLink Corp. All rights reserved.
 * https://www.cyberlink.com
 */

#import <FaceMeSDK/FMBaseEnum.h>
#import <Foundation/Foundation.h>


extern NSString *const FM_RECOGNIZER_PROPERTY_ID_GET_HARDWARE_ENABLED;

/**
 * config preference.
 *
 * @enum EFM_PREFERENCE
 */
typedef NS_ENUM(NSInteger, EFM_PREFERENCE) {
    FM_PREFER_NONE = 0,                        //!< None.
    FM_PREFER_HARDWARE_DETECTION = (1 << 1),    //!< Prefers GPU hardware acceleration on face detection.
    FM_PREFER_FAST_DETECTION = (1 << 2),        //!< Prefers non-DNN algorithm for faster face detection speed.
    FM_PREFER_HARDWARE_EXTRACTION = (1 << 3),    //!< Prefers GPU hardware acceleration on face extraction.
    FM_PREFER_FAST_EXTRACTION = (1 << 4),        //!< Reserved for future use.
};

/**
 * config preference.
 *
 * @see EFM_PREFERENCE
 */
typedef NSInteger FM_PREFERENCE;
/**
 * The config option of face extraction.
 *
 * @enum FM_EXTRACTION_OPTION
 */
typedef NS_ENUM(NSInteger, FM_EXTRACTION_OPTION) {
    FM_EXTRACTION_OPTION_MINFACEWIDTH = 0,            //!< (Deprecated!!) Option of minimum face width.
    FM_EXTRACTION_OPTION_MAXFACEWIDTH,                //!< (Deprecated!!) Option of maximum face width.
    FM_EXTRACTION_OPTION_DETECTION_SPEED_LEVEL,        //!< Option of speed level for face detection.
    FM_EXTRACTION_OPTION_DETECTION_OUTPUT_ORDER,    //!< Option of output order for face detection.
    FM_EXTRACTION_OPTION_DETECTION_MODE,            //!< Option of detection mode.
    FM_EXTRACTION_OPTION_TRACKING_MODE,                //!< Option of tracking mode.
    FM_EXTRACTION_OPTION_FAST_DETECTION_PERIOD        //!< Option of fast detection period in millisecond.
};

/**
 * The mode of face recognizer.
 *
 * @enum FM_RECOGNIZER_MODE
 */
typedef NS_ENUM(NSInteger, FM_RECOGNIZER_MODE) {
    FM_RECOGNIZER_MODE_IMAGE = 0,    //!< face recognizer mode for Image.
    FM_RECOGNIZER_MODE_VIDEO = 1    //!< face recognizer mode for Video.
};

/**
 * The mode for face detection
 *
 * @enum FM_DETECTION_MODE
 */
typedef NS_ENUM(NSInteger, FM_DETECTION_MODE) {
    FM_DETECTION_MODE_NORMAL = 0,        //!< Normal detection
    FM_DETECTION_MODE_FAST                //!< Fast detection
};



/**
 * The mode for face tracking
 *
 * @enum FM_TRACKING_MODE
 */
typedef NS_ENUM(NSInteger, FM_TRACKING_MODE) {
    FM_TRACKING_MODE_NORMAL = 0,        //!< Normal tracking
    FM_TRACKING_MODE_FAST,                //!< Fast tracking
    FM_TRACKING_MODE_MOTION,            //!< Motion tracking
};

/**
 * Speed level for detection.
 *
 * @enum FM_DETECTION_SPEED_LEVEL
 */
typedef NS_ENUM(NSInteger, FM_DETECTION_SPEED_LEVEL) {
    FM_DETECTION_SPEED_LEVEL_DEFAULT = 0,    //!< Default.
    FM_DETECTION_SPEED_LEVEL_STANDARD,        //!< Standard.
    FM_DETECTION_SPEED_LEVEL_HIGH,            //!< High.
    FM_DETECTION_SPEED_LEVEL_ULTRA_HIGH        //!< Ultra-High.
};

/**
 * Output order for detection.
 *
 * @enum EFR_DETECTION_OUTPUT_ORDER
 */
typedef NS_ENUM(NSInteger, FM_DETECTION_OUTPUT_ORDER)
{
    FM_DETECTION_OUTPUT_ORDER_NO_ORDER = 0,        //!< No order.
    FM_DETECTION_OUTPUT_ORDER_CONFIDENCE,        //!< Confidence.
    FM_DETECTION_OUTPUT_ORDER_FACE_WIDTH        //!< Face width.
};

/**
 * Speed level for detection model.
 *
 * @enum EFR_DETECTION_MODEL_SPEED_LEVEL
 */
typedef NS_ENUM(NSInteger, FM_DETECTION_MODEL_SPEED_LEVEL)
{
    FM_DETECTION_MODEL_SPEED_LEVEL_DEFAULT = 0        //!< Default.
};

/*
 * Speed level for extraction model.
 *
 * @enum EFR_EXTRACTION_MODEL_SPEED_LEVEL
 */
typedef NS_ENUM(NSInteger, FM_EXTRACTION_MODEL_SPEED_LEVEL)
{
    FM_EXTRACTION_MODEL_SPEED_LEVEL_DEFAULT = 0,        //!< Default.
    FM_EXTRACTION_MODEL_SPEED_LEVEL_STANDARD,           //!< Standard.
    FM_EXTRACTION_MODEL_SPEED_LEVEL_HIGH,               //!< High.
    FM_EXTRACTION_MODEL_SPEED_LEVEL_ULTRA_HIGH,         //!< Ultra-High.
    FM_EXTRACTION_MODEL_SPEED_LEVEL_HIGH_ASIAN,         //!< High for Asian.
    FM_EXTRACTION_MODEL_SPEED_LEVEL_VERY_HIGH,          //!< Very-High.
    FM_EXTRACTION_MODEL_SPEED_LEVEL_H3,                 //!< High3
    FM_EXTRACTION_MODEL_SPEED_LEVEL_UH3,                //!< Ultra-High 3.
    FM_EXTRACTION_MODEL_SPEED_LEVEL_UH3_M,              //!< Ultra-High 3 with mask.
    FM_EXTRACTION_MODEL_SPEED_LEVEL_VH_M,               //!< Very-High with mask.
    FM_EXTRACTION_MODEL_SPEED_LEVEL_H5,                 //!< High5.
    FM_EXTRACTION_MODEL_SPEED_LEVEL_VH5,             //!< Very-High 5.
    FM_EXTRACTION_MODEL_SPEED_LEVEL_VH5_M,             //!< Very-High 5 with mask.
    FM_EXTRACTION_MODEL_SPEED_LEVEL_H6,                //!< 6th generation of High.
    FM_EXTRACTION_MODEL_SPEED_LEVEL_UH6,             //!< 6th generation of Ultra-High.
    FM_EXTRACTION_MODEL_SPEED_LEVEL_UH6_M,             //!< 6th generation of Ultra-High with mask.
    FM_EXTRACTION_MODEL_SPEED_LEVEL_VH6,             //!< 6th generation of Very-High.
    FM_EXTRACTION_MODEL_SPEED_LEVEL_VH6_M             //!< 6th generation of Very-High with mask.
};
