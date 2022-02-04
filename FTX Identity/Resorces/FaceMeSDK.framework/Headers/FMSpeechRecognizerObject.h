/**
 * @file FMRecognizerObject.h
 * The common object for CyberLink FaceMe Recognizer.
 * CyberLink FaceMe (R) SDK
 * Copyright (C) 2018 CyberLink Corp. All rights reserved.
 * https://www.cyberlink.com
 */

#import <Foundation/Foundation.h>
#import <FaceMeSDK/FMSpeechBaseObject.h>
#import <FaceMeSDK/FMSpeechRecognizerEnum.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * Contains Speech Recognizer Configuration.
 *
 * @interface FMSpeechRecognizerConfig
 */
API_AVAILABLE(ios(13.0))
@interface FMSpeechRecognizerConfig : NSObject
/**
 * The application folder path to be used for data saving.
 */
@property (nonatomic, strong) NSString *appDataPath API_AVAILABLE(macos(10.13));
@property (nonatomic, assign) FM_SPEECH_PREFERENCE preference;                            //!< @see FM_SPEECH_PREFERENCE .
@property (nonatomic, assign) FM_SPEECH_EXTRACTION_MODEL_SPEED_LEVEL extractionModelSpeedLevel;    //!< @see FM_SPEECH_EXTRACTION_MODEL_SPEED_LEVEL .
@property (nonatomic, nullable, strong) NSString *langCode;       //!< The ISO639-2 language code for speech to text.
- (instancetype)init;

@end

/**
 * Contains attributes of a speech.
 *
 * @interface FMFaceAttribute
 */
API_AVAILABLE(ios(13.0))
@interface FMSpeechAttribute : NSObject
@property (nonatomic, assign) FM_SPEECH_FEATURE_OPTIONS options;    //!< The options of extracted feature.
@property (nonatomic, assign) Float32 textConfidence;               //!< The confidence of text.
@end

NS_ASSUME_NONNULL_END
