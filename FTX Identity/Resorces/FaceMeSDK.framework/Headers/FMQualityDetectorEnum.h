/*
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 *
 * CyberLink FaceMe (R) SDK
 * Copyright (c) CyberLink Corp. All rights reserved.
 * https://www.cyberlink.com
 */


#ifndef FMQualityDetectorEnum_h
#define FMQualityDetectorEnum_h


/**
 * Photo quality issue options.
 *
 * @enum EFM_QUALITY_ISSUE_OPTIONS
 */
typedef NS_ENUM(NSInteger, EFM_QUALITY_ISSUE_OPTIONS)
{
    FM_QUALITY_ISSUE_OPTION_NONE = 0,                           //!< None.
    FM_QUALITY_ISSUE_OPTION_UNDERSIZED = 1,                     //!< Check if the face is too small.
    FM_QUALITY_ISSUE_OPTION_OCCLUDED = (1LL << 1),              //!< Check if the face is occluded.
    FM_QUALITY_ISSUE_OPTION_BLUR = (1LL << 2),                  //!< Check if the photo is blurred.
    FM_QUALITY_ISSUE_OPTION_EXPOSURE = (1LL << 3),              //!< Check lighting.
    FM_QUALITY_ISSUE_OPTION_EYE_CLOSED = (1LL << 4),            //!< Check if eyes are closed.
    FM_QUALITY_ISSUE_OPTION_WRONG_ANGLE = (1LL << 5),           //!< Check face angle.
    FM_QUALITY_ISSUE_OPTION_GRAYSCALE = (1LL << 6),             //!< Check if the image is grayscale.
    FM_QUALITY_ISSUE_OPTION_GADGET_DETECTED = (1LL << 7),       //!< Check if the image contains gadgets, such as glasses.
    FM_QUALITY_ISSUE_OPTION_ALL = INT32_MAX                     //!< Check all.
};

/**
 * The detect type of photo quality check.
 *
 * @see EFM_QUALITY_ISSUE_OPTIONS
 */
typedef NSInteger FM_QUALITY_ISSUE_OPTIONS;

/**
 * The mode of blur detection for different sources.
 *
 * @enum EFM_BLUR_QUALITY_MODE
 */
typedef NS_ENUM(NSInteger,  EFM_BLUR_QUALITY_MODE)
{
    FM_BLUR_CAMERA_MODE = 0,    //!< Image.
    FM_BLUR_WEBCAM_MODE         //!< Video.
};

/**
 * The mode of blur detection for different sources.
 *
 * @see EFM_BLUR_QUALITY_MODE
 */
typedef NSInteger FM_BLUR_QUALITY_MODE;

/**
 * The mode of photo quality check.
 *
 * @enum EFM_QUALITY_CHECK_MODE
 */
typedef NS_ENUM(NSInteger, EFM_QUALITY_CHECK_MODE)
{
    FM_QUALITY_CHECK_MODE_ONE_FAILURE = 0,  //!< Return when one detect type fails.
    FM_QUALITY_CHECK_MODE_ALL_FAILURE   //!< Return when all detect types are checked.
};

/**
 * The mode of photo quality check.
 *
 * @see EFM_QUALITY_CHECK_MODE
 */
typedef NSInteger FM_QUALITY_CHECK_MODE;

/**
 * The fail case of facial occlusion.
 *
 * @enum EFM_OCCLUSION_FAIL_REASON
 */
typedef NS_ENUM(NSInteger, EFM_OCCLUSION_FAIL_REASON)
{
    FM_OCCLUSION_NONE = 0,                  //!< None.
    FM_OCCLUSION_UNKNOWN = (1LL << 1),      //!< The face is not suitable for occlusion detection.
    FM_OCCLUSION_LEFTEYE = (1LL << 2),      //!< The face is occluded by left eye.
    FM_OCCLUSION_RIGHTEYE = (1LL << 3),     //!< The face is occluded by right eye.
    FM_OCCLUSION_NOSE = (1LL << 4),         //!< The face is occluded by nose.
    FM_OCCLUSION_MOUTH = (1LL << 5),        //!< The face is occluded by mouth.
    FM_OCCLUSION_MASK = (1LL << 6),         //!< The face is occluded by mask.
    FM_OCCLUSION_LEFTEYEBROW = (1LL << 7),  //!< The left eyebrow is occluded.
    FM_OCCLUSION_RIGHTEYEBROW = (1LL << 8), //!< The right eyebrow is occluded.
};

/**
 * The fail case of facial occlusion.
 *
 * @see EFM_OCCLUSION_FAIL_REASON
 */
typedef NSInteger FM_OCCLUSION_FAIL_REASON;

/**
 * The case of gadget detection.
 *
 * @enum EFM_GADGET_DETECT_REASON
 */
typedef NS_ENUM(NSInteger, EFM_GADGET_DETECT_REASON)
{
    FM_GADGET_NONE = 0,                 //!< None.
    FM_GADGET_EYEGLASSES = (1LL << 1),  //!< The eye glasses were detected.
};

/**
 * The case of gadget detection.
 *
 * @see EFM_GADGET_DETECT_REASON
 */
typedef NSInteger FM_GADGET_DETECT_REASON;

/**
 * config preference.
 *
 * @enum EFM_QC_PREFERENCE
 */
typedef NS_ENUM(NSInteger,  EFM_QC_PREFERENCE)
{
    FM_QC_PREFER_NONE = 0,                                    //!< None.
    FM_QC_PREFER_HARDWARE_DETECTION = (1 << 1),                //!< Prefers GPU hardware acceleration on quality detection.
    FM_QC_PREFER_FAST_DETECTION = (1 << 2),                    //!< (Deprecated) Prefers non-DNN algorithm for faster quality detection speed.
    FM_QC_PREFER_INTEL_MOVIDIUS_VPU_DETECTION = (1 << 5),   //!< Prefers Intel Movidius VPU acceleration on quality detection.
};

/**
 * config preference.
 *
 * @see EFM_QC_PREFERENCE
 */
typedef NSInteger FM_QC_PREFERENCE;

#endif /* FMQualityDetectorEnum_h */
