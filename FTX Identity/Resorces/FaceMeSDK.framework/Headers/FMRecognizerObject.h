/**
 * @file FMRecognizerObject.h
 * The common object for CyberLink FaceMe Recognizer.
 * CyberLink FaceMe (R) SDK
 * Copyright (C) 2018 CyberLink Corp. All rights reserved.
 * https://www.cyberlink.com
 */

#import <Foundation/Foundation.h>
#import <FaceMeSDK/FMBaseObject.h>
#import <FaceMeSDK/FMRecognizerEnum.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * Contains Recognizer Configuration.
 *
 * @interface FMRecognizerConfig
 */
@interface FMRecognizerConfig : NSObject
/**
 * The application folder path to be used for data saving.
 */
@property (nonatomic, strong) NSString *appDataPath API_AVAILABLE(macos(10.13));
@property (nonatomic, assign) FM_PREFERENCE preference;                                     //!< @see FM_PREFERENCE .
@property (nonatomic, assign) FM_DETECTION_MODEL_SPEED_LEVEL detectionModelSpeedLevel;      //!< @see FM_DETECTION_MODEL_SPEED_LEVEL .
@property (nonatomic, assign) SInt32 maxDetectionThreads;                                   //!< The maximum number of threads to be used for face detection.
@property (nonatomic, assign) FM_EXTRACTION_MODEL_SPEED_LEVEL extractionModelSpeedLevel;    //!< @see FM_EXTRACTION_MODEL_SPEED_LEVEL .
@property (nonatomic, assign) SInt32 maxExtractionThreads;                                  //!< The maximum number of threads to be used for face extraction.
@property (nonatomic, assign) FM_RECOGNIZER_MODE mode;                                      //!< @see FM_RECOGNIZER_MODE .
@property (nonatomic, assign) SInt32 maxFrameWidth;                                         //!< The maximum width of frame.
@property (nonatomic, assign) SInt32 maxFrameHeight;                                        //!< The maximum height of frame.
@property (nonatomic, assign) Float32 minFaceWidthRatio;                                    //!< The minimum ratio of the width of the face to the width of the image.

- (instancetype)init;

@end

/**
 * Contains Extraction Configuration.
 *
 * @interface FMExtractConfig
 */
@interface FMExtractConfig : NSObject
@property (nonatomic, assign) FM_FEATURE_OPTIONS extractOptions;        //!< The bitwise combination of the feature options. @see FM_FEATURE_OPTIONS

- (instancetype)init;
@end

NS_ASSUME_NONNULL_END
