/*
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 *
 * CyberLink FaceMe (R) SDK
 * Copyright (c) CyberLink Corp. All rights reserved.
 * https://www.cyberlink.com
 */

#import <Foundation/Foundation.h>
#import <FaceMeSDK/FMBaseEnum.h>

/**
 * The mode for user action detection.
 *
 * @enum EFM_USER_ACTION
 */
typedef NS_ENUM(NSInteger, EFM_USER_ACTION)
{
    FM_UA_DETECT_NONE = 0,            //!< None.
    FM_UA_DETECT_BLINK_EYES,        //!< Blink eye detection.
    FM_UA_DETECT_TURN_HEAD,        //!< Turn head detection.
    FM_UA_DETECT_SMILE,            //!< Smile detection.
    FM_UA_DETECT_OPEN_MOUTH,        //!< Open mouth detection.
    FM_UA_DETECT_NOD_HEAD,            //!< Nod head detection.
    FM_UA_DETECT_LIFT_EYE_BROWS,    //!< Lift eye brows detection.
    FM_UA_DETECT_CENTER,            //!< Detect if the face is in the center of the image.
};

/**
 * config user action.
 *
 * @see EFM_USER_ACTION
 */
typedef NSInteger FM_USER_ACTION;

/**
 * config preference.
 *
 * @enum EFM_UA_PREFERENCE
 */
typedef NS_ENUM(NSInteger, EFM_UA_PREFERENCE)
{
    FM_UA_PREFER_NONE = 0,                        //!< None.
    FM_UA_PREFER_HARDWARE_DETECTION = (1 << 1),    //!< Prefers GPU hardware acceleration on face detection.
    FM_UA_PREFER_FAST_DETECTION = (1 << 2),        //!< Prefers non-DNN algorithm for faster face detection speed.
    FM_UA_PREFER_INTEL_MOVIDIUS_VPU_DETECTION = (1 << 5),   //!< Prefers Intel Movidius VPU acceleration on detection.
};

/**
 * config preference.
 *
 * @see EFM_UA_PREFERENCE
 */
typedef NSInteger FM_UA_PREFERENCE;
