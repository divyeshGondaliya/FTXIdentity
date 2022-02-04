/**
 * @file FMECardRecognizerEnum.h
 * The common definition for CyberLink FaceMe e-Card Recognizer.
 * CyberLink FaceMe (R) SDK
 * Copyright (C) 2018 CyberLink Corp. All rights reserved.
 * https://www.cyberlink.com
 */

#import <FaceMeSDK/FMBaseEnum.h>
#import <Foundation/Foundation.h>

/**
 * e-Passport read event.
 */
typedef NS_ENUM(NSInteger, FM_ECARD_READ_EVENT)
{
    FM_ECARD_READ_EVENT_UNKNOWN = 0,
    FM_ECARD_READ_EVENT_READ_DATA_PROGRESS = 1,
    FM_ECARD_READ_EVENT_SUCCESSFUL = 2,
    FM_ECARD_READ_EVENT_READ_PIN_IGNORED = 3
};

/**
 * e-Card scan options.
 */
typedef NS_ENUM(NSInteger, EFM_ECARD_SCAN_OPTIONS)
{
    /**
     * None.
     */
    FM_ECARD_SCAN_OPTION_NONE = 0,
    /**
     *  Scan face image.
     */
    FM_ECARD_SCAN_OPTION_FACE_IMAGE = (1LL << 1),
    /**
     * Scan all.
     */
    FM_ECARD_SCAN_OPTION_ALL  = 0x7fffffff,
};

/**
 * e-Card scan options.
 */
typedef NSInteger FM_ECARD_SCAN_OPTIONS;

/**
 * e-Card read options.
 */
typedef NS_ENUM(NSInteger, EFM_ECARD_READ_OPTIONS)
{
    /**
     * None.
     */
    FM_ECARD_READ_OPTION_NONE = 0,
    /**
     *  Read face image.
     */
    FM_ECARD_READ_OPTION_FACE_IMAGE = (1LL << 1),
    /**
     *  Read Async.
     */
    FM_ECARD_READ_OPTION_ASNYC = (1LL << 2),
    /**
     * Read all.
     */
    FM_ECARD_READ_OPTION_ALL  = 0x7fffffff,
};

/**
 * e-Card read options.
 */
typedef NSInteger FM_ECARD_READ_OPTIONS;

/*
 case needPIN
 case incorrectPIN(Int)
 case incorrectPINFormat
 case enteredPINWasIgnored
 */
/**
 * e-Card read error.
 */
typedef NS_ENUM(NSInteger, FM_ECARD_READ_ERROR)
{
    FM_ECARD_READ_ERROR_UNKNOWN = 0,
    FM_ECARD_READ_ERROR_NFC_NOT_SUPPORT = 1,
    FM_ECARD_READ_ERROR_NFC_INVALID = 2,
    FM_ECARD_READ_ERROR_NEED_PIN = 3,
    FM_ECARD_READ_ERROR_INCORRECT_PIN = 4,
    FM_ECARD_READ_ERROR_INCORRECT_PIN_FORMAT = 5
};

/**
 * e-Card model.
 */
extern NSString *const FM_ECARD_ERROR_DOMAIN;

/**
 * e-Card model.
 */
extern NSString *const FM_ECARD_CARD_MODEL_TYPE_JAPANESE_DRIVERS_LICENSE;

/**
 * e-Card read arguments.
 */
extern NSString *const FM_ECARD_READ_ARGS_PIN_1;
extern NSString *const FM_ECARD_READ_ARGS_PIN_2;

extern NSString *const FM_ECARD_INFO_NAME; ///< (NSString *) .
extern NSString *const FM_ECARD_INFO_NICK_NAME; ///< (NSString *) .
extern NSString *const FM_ECARD_INFO_COMMON_NAME; ///< (NSString *) Optional.
extern NSString *const FM_ECARD_INFO_UNIFORM_NAME; ///< (NSString *) .
extern NSString *const FM_ECARD_INFO_DATE_OF_BIRTH; ///< (NSDate *) .
extern NSString *const FM_ECARD_INFO_ADDRESS; ///< (NSString *) .
extern NSString *const FM_ECARD_INFO_DATE_OF_ISSUE; ///< (NSDate *) .
extern NSString *const FM_ECARD_INFO_REFERENCE_NUMBER; ///< (NSString *) .
extern NSString *const FM_ECARD_INFO_COLOR; ///< (NSString *) .
extern NSString *const FM_ECARD_INFO_DATE_OF_EXPIRY; ///< (NSDate *) .
extern NSString *const FM_ECARD_INFO_CONDITION_1; ///< (NSString *) Optional.
extern NSString *const FM_ECARD_INFO_CONDITION_2; ///< (NSString *) Optional.
extern NSString *const FM_ECARD_INFO_CONDITION_3; ///< (NSString *) Optional.
extern NSString *const FM_ECARD_INFO_CONDITION_4; ///< (NSString *) Optional.
extern NSString *const FM_ECARD_INFO_ISSUING_OF_AUTHORITY; ///< (NSString *) .
extern NSString *const FM_ECARD_INFO_DOCUMENT_NUMBER; ///< (NSString *) .
extern NSString *const FM_ECARD_INFO_DATE_OF_MOTORCYCLE_LICENSE; ///< (NSDate *) Optional.
extern NSString *const FM_ECARD_INFO_DATE_OF_OTHER_LICENSE; ///< (NSDate *) .
extern NSString *const FM_ECARD_INFO_DATE_OF_CLASS2_LICENSE; ///< (NSDate *) .
extern NSString *const FM_ECARD_INFO_DATE_OF_HEAVY_VEHICLE_LICENSE; ///< (NSDate *) .
extern NSString *const FM_ECARD_INFO_DATE_OF_ORDINARY_VEHICLE_LICENSE; ///< (NSDate *) .
extern NSString *const FM_ECARD_INFO_DATE_OF_HEAVY_SPECIAL_VEHICLE_LICENSE; ///< (NSDate *) .
extern NSString *const FM_ECARD_INFO_DATE_OF_HEAVY_MOTORCYCLE_LICENSE; ///< (NSDate *) .
extern NSString *const FM_ECARD_INFO_DATE_OF_ORDINARY_MOTORCYCLE_LICENSE; ///< (NSDate *) .
extern NSString *const FM_ECARD_INFO_DATE_OF_SMALL_SPECIAL_VEHICLE_LICENSE; ///< (NSDate *) .
extern NSString *const FM_ECARD_INFO_DATE_OF_MOPED_LICENSE; ///< (NSDate *) .
extern NSString *const FM_ECARD_INFO_DATE_OF_TRAILER_LICENSE; ///< (NSDate *) .
extern NSString *const FM_ECARD_INFO_DATE_OF_CLASS2_HEAVY_VEHICLE_LICENSE; ///< (NSDate *) .
extern NSString *const FM_ECARD_INFO_DATE_OF_CLASS2_ORDINARY_VEHICLE_LICENSE; ///< (NSDate *) .
extern NSString *const FM_ECARD_INFO_DATE_OF_CLASS2_HEAVY_SPECIAL_VEHICLE_LICENSE; ///< (NSDate *) .
extern NSString *const FM_ECARD_INFO_DATE_OF_CLASS2_TRAILER_LICENSE; ///< (NSDate *) .
extern NSString *const FM_ECARD_INFO_DATE_OF_MEDIUM_VEHICLE_LICENSE; ///< (NSDate *) .
extern NSString *const FM_ECARD_INFO_DATE_OF_CLASS2_MEDIUM_VEHICLE_LICENSE; ///< (NSDate *) .
extern NSString *const FM_ECARD_INFO_DATE_OF_SEMI_MEDIUM_VEHICLE_LICENSE; ///< (NSDate *) .

extern NSString *const FM_ECARD_INFO_REGISTERED_DOMICILE; ///< (NSString *) .

extern NSString *const FM_ECARD_INFO_FACE_IMAGE; ///< (CIImage *) .
