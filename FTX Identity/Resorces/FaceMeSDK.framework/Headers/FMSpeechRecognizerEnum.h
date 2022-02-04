/**
 * @file FMRecognizerEnum.h
 * The common definition for CyberLink FaceMe Recognizer.
 * CyberLink FaceMe (R) SDK
 * Copyright (C) 2018 CyberLink Corp. All rights reserved.
 * https://www.cyberlink.com
 */

#import <FaceMeSDK/FMSpeechBaseEnum.h>
#import <Foundation/Foundation.h>

/**
 * speech config preference.
 *
 * @enum EFM_SPEECH_PREFERENCE
 */
typedef NS_ENUM(NSInteger, EFM_SPEECH_PREFERENCE) {
    FM_SPEECH_PREFERENCE_NONE = 0,                          //!< None.
    FM_SPEECH_PREFERENCE_HARDWARE_EXTRACTION = (1 << 1),    //!< Prefers GPU hardware acceleration on speech extraction.
} API_AVAILABLE(ios(13.0));

/**
 * speech config preference.
 *
 * @see EFM_SPEECH_PREFERENCE
 */
typedef NSInteger FM_SPEECH_PREFERENCE;

/*
 * Speed level for extraction model.
 *
 * @enum FM_SPEECH_EXTRACTION_MODEL_SPEED_LEVEL
 */
typedef NS_ENUM(NSInteger, FM_SPEECH_EXTRACTION_MODEL_SPEED_LEVEL)
{
    FM_SPEECH_EXTRACTION_MODEL_SPEED_LEVEL_DEFAULT = 0,        //!< Default.
    FM_SPEECH_EXTRACTION_MODEL_SPEED_LEVEL_STANDARD,           //!< Standard.
} API_AVAILABLE(ios(13.0));
