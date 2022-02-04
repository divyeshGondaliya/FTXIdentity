/**
 * @file FMLivenessDetectorEnum.h
 * The common definition for CyberLink FaceMe Data Manager.
 * CyberLink FaceMe (R) SDK
 * Copyright (C) 2018 CyberLink Corp. All rights reserved.
 * https://www.cyberlink.com
 */

#import <FaceMeSDK/FMBaseEnum.h>
#import <Foundation/Foundation.h>

/**
 * config preference.
 *
 * @enum FR_LIVENESS_DETECTION_MODE
 */
typedef NS_ENUM(NSInteger, FM_LIVENESS_DETECTION_MODE) {
    FM_LIVENESS_DETECTION_MODE_DEPTH = 0,            //!< Liveness detection by depth information
    //FM_LIVENESS_DETECTION_MODE_RGB_WITHBG = 1,        //!< Liveness detection by RGB with background
};



/**
 * config preference.
 *
 * @enum FM_DEPTH_MAP_FORMAT
 */
typedef NS_ENUM(NSInteger, FM_DEPTH_MAP_FORMAT) {
    FM_DEPTH_MAP_FORMAT_UNKNOWN = 0,    //!< Unknown.
    FM_DEPTH_MAP_FORMAT_16UC1,          //!< 16-bit unsigned format.
};


/**
 * config preference.
 *
 * @enum FR_FACE_LIVENESS_STATUS
 */
typedef NS_ENUM(NSInteger, FM_FACE_LIVENESS_STATUS) {
    FM_FACE_IS_LIVE_UNKNOWN = 0,    //!< Unknown.
    FM_FACE_IS_LIVENESS = 1,        //!< Liveness.
    FM_FACE_IS_SPOOFING = 2,        //!< Spoofing.
    FM_FACE_IS_INVALID_ANGLE = 3,    //!< Invalid Angle.
    FM_FACE_IS_TOO_FAR = 4,            //!< Too Far.
    FM_FACE_IS_TOO_NEAR = 5            //!< Too Near.
};

/**
 * option for future funtion
 *
 * @enum FM_LIVENESS_DETECTION_OPTION
 */
typedef NS_ENUM(NSInteger, FM_LIVENESS_DETECTION_OPTION) {
    FM_LIVENESS_DETECTION_OPTION_TRACKING_MODE = 0,
    FM_LIVENESS_DETECTION_OPTION_SINGLE_FACE_MOTION_TRACKING_SPEED_LEVEL = 1
};


/**
 * option value for future funtion
 *
 * @enum FM_LIVENESS_TRACKING_MODE
 */
typedef NS_ENUM(NSInteger, FM_LIVENESS_TRACKING_MODE) {
    FM_LIVENESS_TRACKING_MODE_NORMAL = 0,               //!< Without tracking
    FM_LIVENESS_TRACKING_MODE_MOTION = 1,               //!< With tracking probility
    FM_LIVENESS_TRACKING_MODE_SINGLE_FACE_MOTION = 2    //!< With tracking probility for single id
};

typedef NS_ENUM(NSInteger, FM_LIVENESS_SINGLE_FACE_MOTION_SPEED_LEVEL) {
    FM_LIVENESS_SINGLE_FACE_MOTION_TRACKING_FAST = 0,    //!< Fast speed level
    FM_LIVENESS_SINGLE_FACE_MOTION_TRACKING_PRECISE = 1  //!< Precise speed level
};
