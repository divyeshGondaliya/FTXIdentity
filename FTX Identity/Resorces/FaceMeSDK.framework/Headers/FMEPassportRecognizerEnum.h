/**
 * @file FMEPassportRecognizerEnum.h
 * The common definition for CyberLink FaceMe e-Passport Recognizer.
 * CyberLink FaceMe (R) SDK
 * Copyright (C) 2018 CyberLink Corp. All rights reserved.
 * https://www.cyberlink.com
 */

#import <FaceMeSDK/FMBaseEnum.h>
#import <Foundation/Foundation.h>

/**
 * e-Passport read event.
 */
typedef NS_ENUM(NSInteger, FM_EPASSPORT_READ_EVENT)
{
    FM_EPASSPORT_READ_EVENT_UNKNOWN = 0,
    FM_EPASSPORT_READ_EVENT_REQUEST_PRESENT_PASSPORT = 1,
    FM_EPASSPORT_READ_EVENT_AUTHENTICATING_WITH_PASSPORT = 2,
    FM_EPASSPORT_READ_EVENT_READ_DATA_PROGRESS = 3,
    FM_EPASSPORT_READ_EVENT_SUCCESSFUL = 4
} API_AVAILABLE(ios(13.0));

/**
 * e-Passport read error.
 */
typedef NS_ENUM(NSInteger, FM_TAG_ERROR)
{
    FM_TAG_ERROR_UNKNOWN = -1,
    FM_TAG_ERROR_RESPONSE_ERROR = 0,
    FM_TAG_ERROR_INVALID_RESPONSE = 1,
    FM_TAG_ERROR_UNEXPECTED = 2,
    FM_TAG_ERROR_NFC_NOT_SUPPORT = 3,
    FM_TAG_ERROR_NO_CONNECTED_TAG = 4,
    FM_TAG_ERROR_D087_MALFORMED = 5,
    FM_TAG_ERROR_INVALID_RESPONSE_CHECKSUM = 6,
    FM_TAG_ERROR_MISSING_MANDATORY_FIELDS = 7,
    FM_TAG_ERROR_CANNOT_DECODE_ASN1_LENGTH = 8,
    FM_TAG_ERROR_INVALID_ASN1_VALUE = 9,
    FM_TAG_ERROR_UNABLE_TO_PROTECT_APDU = 10,
    FM_TAG_ERROR_UNABLE_TO_UNPROTECT_APDU = 11,
    FM_TAG_ERROR_UNSUPPORTED_DATA_GROUP = 12,
    FM_TAG_ERROR_DATA_GROUP_NOT_READ = 13,
    FM_TAG_ERROR_UNKNOWN_TAG = 14,
    FM_TAG_ERROR_IMAGE_FORMAT = 15,
    FM_TAG_ERROR_NOT_IMPLEMENTED = 16,
    FM_TAG_ERROR_TAG_NOT_VALID = 17,
    FM_TAG_ERROR_CONNECTION_ERROR = 18,
    FM_TAG_ERROR_USER_CANCELED = 19,
    FM_TAG_ERROR_INVALID_MRZKEY = 20,
    FM_TAG_ERROR_MORE_THAN_ONE_TAG_FOUND = 21,
    FM_TAG_ERROR_INVALID_HASH_ALGORITHM_SPECIFIED = 22
} API_AVAILABLE(ios(13.0));
    
/**
 * e-Passport scan options.
 */
typedef NS_ENUM(NSInteger, EFM_EPASSPORT_SCAN_OPTIONS)
{
    /**
     * None.
     */
    FM_EPASSPORT_SCAN_OPTION_NONE = 0,
    /**
     *  Scan face image.
     */
    FM_EPASSPORT_SCAN_OPTION_FACE_IMAGE = (1LL << 1),
    /**
     * Scan all.
     */
    FM_EPASSPORT_SCAN_OPTION_ALL  = 0x7fffffff,
} API_AVAILABLE(ios(13.0));

/**
 * e-Passport scan options.
 */
typedef NSInteger FM_EPASSPORT_SCAN_OPTIONS;

/**
 * e-Passport read options.
 */
typedef NS_ENUM(NSInteger, EFM_EPASSPORT_READ_OPTIONS)
{
    /**
     * None.
     */
    FM_EPASSPORT_READ_OPTION_NONE = 0,
    /**
     *  Read face image.
     */
    FM_EPASSPORT_READ_OPTION_FACE_IMAGE = (1LL << 1),
    /**
     *  Read Async.
     */
    FM_EPASSPORT_READ_OPTION_ASNYC = (1LL << 2),
    /**
     * Read all.
     */
    FM_EPASSPORT_READ_OPTION_ALL  = 0x7fffffff,
} API_AVAILABLE(ios(13.0));

/**
 * e-Passport read options.
 */
typedef NSInteger FM_EPASSPORT_READ_OPTIONS;
