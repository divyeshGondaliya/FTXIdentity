/**
 * @file FMIDCardRecognizerObject.h
 * The common object for CyberLink FaceMe ID Card Recognizer.
 * CyberLink FaceMe (R) SDK
 * Copyright (c) CyberLink Corp. All rights reserved.
 * https://www.cyberlink.com
 */

#import <Foundation/Foundation.h>
#import <FaceMeSDK/FMBaseObject.h>
#import <FaceMeSDK/FMRecognizerEnum.h>
#import <FaceMeSDK/FMIDCardRecognizerEnum.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * Contains ID Card Recognizer Configuration.
 *
 * @interface FMIDCardRecognizerConfig
 */
@interface FMIDCardRecognizerConfig : NSObject
/**
 * The application folder path to be used for data saving.
 */
@property (nonatomic, strong) NSString *appDataPath API_AVAILABLE(macos(10.13));
@property (nonatomic, assign) FM_PREFERENCE preference;                 //!< @see FM_PREFERENCE .
@property (nonatomic, assign) SInt32 maxFrameWidth;                     //!< The maximum width of frame.
@property (nonatomic, assign) SInt32 maxFrameHeight;                    //!< The maximum height of frame.
@property (nonatomic, assign) UInt32 minFaceWidth;                      //!< (Deprecated!!) The minimum face width.
@property (nonatomic, strong) NSString *cardModel;                      //!< The model string of ID card, represented by utf-8 encoded string.
@property (nonatomic, assign) FM_IDCARD_RECOGNIZER_OPTIONS options;     //!< The bitwise combination of the recognizer options. @see EFM_IDCARD_RECOGNIZER_OPTIONS.
@property (nonatomic, assign) Float32 minFaceWidthRatio;                //!< The minimum ratio of the width of the face to the width of the image.
- (instancetype)init;

@end

/**
 * Contains config of ID Card detection.
 *
 * @interface FMIDCardDetectConfig
 */
@interface FMIDCardDetectConfig : NSObject
@property (nonatomic, assign) FM_IDCARD_DETECT_OPTIONS detectOptions;           //!< The bitwise combination of the detection options. @see FM_IDCARD_DETECT_OPTIONS
@property (nonatomic, assign) FM_IDCARD_SIDE_TYPE sideType;                     //!< The side of ID card. @see FM_FEATURE_OPTIONS
@property (nonatomic, assign) BOOL discontinuity;
- (instancetype)init;
@end

/**
 * Contains detection result of ID card.
 *
 * @interface FMIDCardDetectResult
 */
@interface FMIDCardDetectResult : NSObject
@property (nonatomic, assign) FM_IDCARD_DETECT_OPTIONS detectOptions;       //!< The bitwise combination of the detection options. @see FM_IDCARD_DETECT_OPTIONS
@property (nonatomic, assign) FM_IDCARD_REALNESS_STATUS status;             //!< The realness status of ID card.
@property (nonatomic, strong) NSArray<FMPoint *> *corners;                  //!< The detected four coners of ID card.
@property (nonatomic, assign) SInt32 preferredWidth;                        //!< The preferred width of detected ID card.
@property (nonatomic, assign) SInt32 preferredHeight;                       //!< The preferred height of detected ID card.
@property (nonatomic, strong, nullable) FMRectangle *faceBoundingBox;       //!< The detected face bounding box related to the preferred width and height.
@property (nonatomic, assign) Float32 score;                                //!< The score of the detected result.
- (instancetype)init;
@end

/**
 * Contains configurations of ID Card information scanning.
 */
API_AVAILABLE(ios(13.0))
@interface FMIDCardScanConfig : NSObject
@property (nonatomic, assign) FM_IDCARD_SCAN_OPTIONS scanOptions;       //!< The bitwise combination of the scan options. @see FM_IDCARD_SCAN_OPTIONS
@property (nonatomic, assign) FM_IDCARD_SIDE_TYPE sideType;             //!< The side of ID card. @see FM_FEATURE_OPTIONS
@property (nonatomic, assign) BOOL discontinuity;
@end

/**
 * Contains ID Card scanning result.
 */
API_AVAILABLE(ios(13.0))
@interface FMIDCardScanResult : NSObject

- (FM_IDCARD_SCAN_RESULT_STATUS)GetStatus;
- (NSString *_Nullable)GetString:(NSString *)propertyId;

@end

NS_ASSUME_NONNULL_END
