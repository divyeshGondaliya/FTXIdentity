/**
 * @file FMSpeechBaseEnum.h
 * The common speech definition for CyberLink FaceMe SDK.
 * CyberLink FaceMe (R) SDK
 * Copyright (C) 2018 CyberLink Corp. All rights reserved.
 * https://www.cyberlink.com
 */

#import <Foundation/Foundation.h>

/**
 * The level of precision.
 */
typedef NS_ENUM(NSInteger, FM_SPEECH_PRECISION_LEVEL)
{
    /**
     * 1e6
     */
    FM_SPEECH_PRECISION_LEVEL_1E6 = 0,
    /**
     * 1e5
     */
    FM_SPEECH_PRECISION_LEVEL_1E5,
    /**
     * 1e4
     */
    FM_SPEECH_PRECISION_LEVEL_1E4,
    /**
     * 1e3
     */
    FM_SPEECH_PRECISION_LEVEL_1E3,
    /**
     * 1e2
     */
    FM_SPEECH_PRECISION_LEVEL_1E2,
    /**
     * 1e1
     */
    FM_SPEECH_PRECISION_LEVEL_1E1
};

/**
 * Speech feature options.
 */
typedef NS_ENUM(NSInteger, EFM_SPEECH_FEATURE_OPTIONS)
{
    /**
     * None.
     */
    FM_SPEECH_FEATURE_OPTION_NONE = 0,
    /**
     * Extract speech Feature.
     */
    FM_SPEECH_FEATURE_OPTION_FEATURE = (1LL << 1),
    /**
     * Extract speech Text.
     */
    FM_SPEECH_FEATURE_OPTION_TEXT = (1LL << 2),
    /**
     * Extract all.
     */
    FM_SPEECH_FEATURE_OPTION_ALL = 0x7fffffff
} API_AVAILABLE(ios(13.0));

/**
 * Speech feature options.
 */
typedef NSInteger FM_SPEECH_FEATURE_OPTIONS;

/**
 * The type of speech feature.
 */
typedef NS_ENUM(NSInteger, FM_SPEECH_FEATURE_TYPE)
{
    /**
     * None.
     */
    FM_SPEECH_FEATURE_TYPE_NONE = 0,
    /**
     * Standard precision.
     */
    FM_SPEECH_FEATURE_TYPE_STANDARD_PRECISION = 1
} API_AVAILABLE(ios(13.0));

/**
 * The sub type of speech feature.
 */
typedef NS_ENUM(NSInteger, FM_SPEECH_FEATURE_SUB_TYPE)
{
    /**
     * None.
     */
    FM_SPEECH_FEATURE_SUB_TYPE_NONE = 0
} API_AVAILABLE(ios(13.0));

/**
* The type of feature scheme
*/
typedef NS_ENUM(NSInteger, FM_SPEECH_FEATURE_SCHEME_TYPE)
{
	 /**
     * Speech feature.
     */
	FM_SPEECH_FEATURE_SCHEME_TYPE_FEATURE = 0
} API_AVAILABLE(ios(13.0));
