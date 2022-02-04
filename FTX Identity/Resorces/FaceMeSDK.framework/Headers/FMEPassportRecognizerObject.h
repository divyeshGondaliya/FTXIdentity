/**
 * @file FMEPassportRecognizerObject.h
 * The common object for CyberLink FaceMe e-Passport Recognizer.
 * CyberLink FaceMe (R) SDK
 * Copyright (c) CyberLink Corp. All rights reserved.
 * https://www.cyberlink.com
 */

#import <Foundation/Foundation.h>
#import <CoreImage/CoreImage.h>
#import <FaceMeSDK/FMEPassportRecognizerEnum.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * Contains E-Passport Recognizer Configuration.
 *
 * @interface FMEPassportRecognizerConfig
 */
API_AVAILABLE(ios(13.0))
@interface FMEPassportRecognizerConfig : NSObject
/**
 * The application folder path to be used for data saving.
 */
@property (nonatomic, strong) NSString *appDataPath API_AVAILABLE(macos(10.13));
- (instancetype)init;

@end

/**
 * Contains config of e-Passport scan.
 *
 * @interface FMEPassportScanConfig
 */
API_AVAILABLE(ios(13.0))
@interface FMEPassportScanConfig : NSObject
@property (nonatomic, assign) FM_EPASSPORT_SCAN_OPTIONS scanOptions;           //!< The bitwise combination of the detection options. @see FM_EPASSPORT_SCAN_OPTIONS
@property (nonatomic, assign) BOOL discontinuity;
- (instancetype)init;
@end

/**
 * Contains scan result of e-Passport.
 *
 * @interface FMEPassportDetectResult
 */
API_AVAILABLE(ios(13.0))
@interface FMEPassportScanResult : NSObject
@property (nonatomic, assign) FM_EPASSPORT_SCAN_OPTIONS scanOptions;       //!< The bitwise combination of the scan options. @see FM_EPASSPORT_SCAN_OPTIONS
@property (nonatomic, strong) CIImage *documentImage;
@property (nonatomic, strong) NSString *documentType;
@property (nonatomic, strong) NSString *documentNumber;
@property (nonatomic, strong) NSString *countryCode;
@property (nonatomic, strong) NSString *surname;
@property (nonatomic, strong) NSString *givenNames;
@property (nonatomic, strong) NSString *nationality;
@property (nonatomic, strong) NSString *personalNumber;
@property (nonatomic, strong, nullable) NSDate *dateOfBirth;
@property (nonatomic, strong, nullable) NSString *sex;
@property (nonatomic, strong, nullable) NSDate *dateOfExpiry;
@property (nonatomic, strong, nullable) NSString *personalNumber2;
@property (nonatomic, strong, nullable) CIImage *faceImage;

@end

/**
 * Contains config of e-Passport NFC read.
 *
 * @interface FMEPassportReadConfig
 */
API_AVAILABLE(ios(13.0))
@interface FMEPassportReadConfig : NSObject
@property (nonatomic, assign) FM_EPASSPORT_READ_OPTIONS readOptions;           //!< The bitwise combination of the read options. @see FM_EPASSPORT_READ_OPTIONS
- (instancetype)init;
@end

/**
 * Contains read result of e-Passport.
 *
 * @interface FMEPassportReadResult
 */
API_AVAILABLE(ios(13.0))
@interface FMEPassportReadResult : NSObject
@property (nonatomic, assign) FM_EPASSPORT_READ_OPTIONS readOptions;       //!< The bitwise combination of the read options. @see FM_EPASSPORT_READ_OPTIONS
@property (nonatomic, strong) NSString *documentType;
@property (nonatomic, strong) NSString *documentSubType;
@property (nonatomic, strong) NSString *documentNumber;
@property (nonatomic, strong) NSString *surname;
@property (nonatomic, strong) NSString *givenNames;
@property (nonatomic, strong) NSDate *dateOfBirth;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSDate *dateOfExpiry;
@property (nonatomic, strong) NSString *nationality;
@property (nonatomic, strong) NSString *personalNumber;
@property (nonatomic, strong) NSString *issuingAuthority;
@property (nonatomic, strong) NSString *passportMRZ;
@property (nonatomic, strong, nullable) NSString *placeOfBirth;
@property (nonatomic, strong, nullable) NSString *residenceAddress;
@property (nonatomic, strong, nullable) NSString *phoneNumber;
@property (nonatomic, strong, nullable) CIImage *faceImage;
@end

NS_ASSUME_NONNULL_END
