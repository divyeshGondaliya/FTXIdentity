/**
 * @file FMECardRecognizerObject.h
 * The common object for CyberLink FaceMe e-Card Recognizer.
 * CyberLink FaceMe (R) SDK
 * Copyright (c) CyberLink Corp. All rights reserved.
 * https://www.cyberlink.com
 */

#import <Foundation/Foundation.h>
#import <CoreImage/CoreImage.h>
#import <FaceMeSDK/FMECardRecognizerEnum.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * Contains E-Passport Recognizer Configuration.
 *
 * @interface FMECardRecognizerConfig
 */
@interface FMECardRecognizerConfig : NSObject
/**
 * The application folder path to be used for data saving.
 */
@property (nonatomic, strong) NSString *appDataPath API_AVAILABLE(macos(10.13));
@property (nonatomic, strong) NSString *cardModel;

- (instancetype)init;

@end

/**
 * Contains config of e-Card scan.
 *
 * @interface FMECardScanConfig
 */
@interface FMECardScanConfig : NSObject
@property (nonatomic, assign) FM_ECARD_SCAN_OPTIONS scanOptions;           //!< The bitwise combination of the detection options. @see FM_ECARD_SCAN_OPTIONS
@property (nullable, nonatomic, strong) NSDictionary *args; //!< Arguments for scan.
@property (nonatomic, assign) BOOL discontinuity;
- (instancetype)init;
@end

/**
 * Contains scan result of e-Card.
 */
typedef NSDictionary FMECardScanResult;


/**
 * Contains config of e-Card NFC read.
 *
 * @interface FMECardReadConfig
 */
@interface FMECardReadConfig : NSObject
@property (nonatomic, assign) FM_ECARD_READ_OPTIONS readOptions;           //!< The bitwise combination of the read options. @see FM_ECARD_READ_OPTIONS
@property (nullable, nonatomic, strong) NSDictionary *args; //!< Arguments for read.
- (instancetype)init;
@end

/**
 * Contains read result of e-Card.
 */
typedef NSDictionary FMECardReadResult;

typedef NSString *_Nullable(^FMECardProgressBlock)(FM_ECARD_READ_EVENT event, NSInteger progress, NSString*_Nullable arg);
typedef void(^FMECardCompletionBlock)(FMECardReadResult *_Nullable readResult, NSError *_Nullable error );

NS_ASSUME_NONNULL_END
