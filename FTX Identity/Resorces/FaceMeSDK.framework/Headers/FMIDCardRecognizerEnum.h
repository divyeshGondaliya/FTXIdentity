/**
 * @file FMIDCardRecognizerEnum.h
 * The common definition for CyberLink FaceMe ID Card Recognizer.
 * CyberLink FaceMe (R) SDK
 * Copyright (C) 2018 CyberLink Corp. All rights reserved.
 * https://www.cyberlink.com
 */

#import <FaceMeSDK/FMBaseEnum.h>
#import <Foundation/Foundation.h>

/**
* ID Card recognizer options.
*/
typedef NS_ENUM(NSInteger, EFM_IDCARD_RECOGNIZER_OPTIONS)
{
    /**
     * None.
     */
    FM_IDCARD_RECOGNIZER_OPTION_NONE = 0,
    /**
     *  Recognize Front Side.
     */
    FM_IDCARD_RECOGNIZER_OPTION_FRONT_SIDE = (1LL << 1),
    /**
     *  Recognize Back Side.
     */
    FM_IDCARD_RECOGNIZER_OPTION_BACK_SIDE = (1LL << 2),
    /**
     *  Auto Deskew image.
     */
    FM_IDCARD_RECOGNIZER_OPTION_AUTO_DESKEW = (1LL << 3),
    /**
     * Scan text information.
     */
    FM_IDCARD_RECOGNIZER_OPTION_SCAN_TEXT API_AVAILABLE(ios(13.0)) = (1LL << 4),
    /**
     *  Recognize All.
     */
    FM_IDCARD_RECOGNIZER_OPTION_ALL = 0x7fffffff
};

/**
 * ID Card recognizer options.
 */
typedef NSInteger FM_IDCARD_RECOGNIZER_OPTIONS;

/**
 * ID Card detect options.
 */
typedef NS_ENUM(NSInteger, EFM_IDCARD_DETECT_OPTIONS)
{
    /**
     * None.
     */
    FM_IDCARD_DETECT_OPTION_NONE = 0,
    /**
     *  Detect corners.
     */
    FM_IDCARD_DETECT_OPTION_CORNERS = (1LL << 1),
    /**
     *  Detect Head Shot.
     */
    FM_IDCARD_DETECT_OPTION_HEAD_SHOT = (1LL << 2),
    /**
     * Detect Security thread.
     */
    FM_IDCARD_DETECT_OPTION_SECURITY = (1LL << 4),
    /**
     * Detect all.
     */
    FM_IDCARD_DETECT_OPTION_ALL  = 0x7fffffff,
};

/**
 * ID Card detect options.
 */
typedef NSInteger FM_IDCARD_DETECT_OPTIONS;

/**
 * The type of realness status.
 *
 * @enum FM_IDCARD_REALNESS_STATUS
 */
typedef NS_ENUM(NSInteger, FM_IDCARD_REALNESS_STATUS) {
	FM_IDCARD_IS_REALNESS_UNKNOWN = 0,	//!< Unknown.
	FM_IDCARD_IS_REAL = 1,				//!< Real.
	FM_IDCARD_IS_FORGERY = 2			//!< Spoofing.
};

/**
 * The side of id card.
 *
 * @enum FM_IDCARD_SIDE_TYPE
 */
typedef NS_ENUM(NSInteger, FM_IDCARD_SIDE_TYPE) {
	FM_IDCARD_SIDE_TYPE_UNKNOWN = 0,	//!< Unknown.
	FM_IDCARD_SIDE_TYPE_FRONT = 1,		//!< Front Side.
	FM_IDCARD_SIDE_TYPE_BACK = 2		//!< Back Side.
};

/**
 * ID Card scan options.
 *
 * @enum FM_IDCARD_SCAN_OPTIONS
 */
typedef NS_ENUM(NSInteger, FM_IDCARD_SCAN_OPTIONS)
{
    FM_IDCARD_SCAN_OPTION_NONE = 0,                     //!< None.
    FM_IDCARD_SCAN_OPTION_DESKEWED_IMAGE = (1LL << 1)   //!< Scan image that has deskewed.
};

/**
 * The status of scan result.
 *
 * @enum FM_IDCARD_SCAN_RESULT_STATUS
 */
typedef NS_ENUM(NSInteger, FM_IDCARD_SCAN_RESULT_STATUS)
{
    FM_IDCARD_SCAN_RESULT_UNKNOWN = 0,          //!< Unknown.
    FM_IDCARD_SCAN_RESULT_OK = 1,               //!< Ok.
    FM_IDCARD_SCAN_RESULT_NEED_MORE_IMAGE = 2,  //!< Need more images.
    FM_IDCARD_SCAN_RESULT_HAS_REFLECTION = 3,   //!< Image has reflection.
    FM_IDCARD_SCAN_RESULT_BLURRY = 4,           //!< Image is blurry.
    FM_IDCARD_SCAN_RESULT_INVALID_FIELDS = 5,   //!< Image is incorrectly cropped or extremely tilted angle.
};

extern NSString *const FM_IDCARD_CARD_MODEL_TYPE_TW_ID;
extern NSString *const FM_IDCARD_CARD_MODEL_TYPE_TW_HEALTH_ID;

extern NSString *const FM_IDCARD_SCAN_RESULT_PROP_TW_ID_CARD_FRONT_NAME;
extern NSString *const FM_IDCARD_SCAN_RESULT_PROP_TW_ID_CARD_FRONT_DATE_OF_BIRTH;
extern NSString *const FM_IDCARD_SCAN_RESULT_PROP_TW_ID_CARD_FRONT_DATE_OF_ISSUE;
extern NSString *const FM_IDCARD_SCAN_RESULT_PROP_TW_ID_CARD_FRONT_SEX;
extern NSString *const FM_IDCARD_SCAN_RESULT_PROP_TW_ID_CARD_FRONT_ID;
extern NSString *const FM_IDCARD_SCAN_RESULT_PROP_TW_ID_CARD_BACK_FATHER;
extern NSString *const FM_IDCARD_SCAN_RESULT_PROP_TW_ID_CARD_BACK_MOTHER;
extern NSString *const FM_IDCARD_SCAN_RESULT_PROP_TW_ID_CARD_BACK_SPOUSE;
extern NSString *const FM_IDCARD_SCAN_RESULT_PROP_TW_ID_CARD_BACK_MILITARY_SERVICE;
extern NSString *const FM_IDCARD_SCAN_RESULT_PROP_TW_ID_CARD_BACK_PLACE_OF_BIRTH;
extern NSString *const FM_IDCARD_SCAN_RESULT_PROP_TW_ID_CARD_BACK_ADDRESS;
extern NSString *const FM_IDCARD_SCAN_RESULT_PROP_TW_ID_CARD_BACK_SERIAL_NUMBER;
extern NSString *const FM_IDCARD_SCAN_RESULT_PROP_TW_HEALTH_ID_CARD_NAME;
extern NSString *const FM_IDCARD_SCAN_RESULT_PROP_TW_HEALTH_ID_CARD_ID;
extern NSString *const FM_IDCARD_SCAN_RESULT_PROP_TW_HEALTH_ID_CARD_DATE_OF_BIRTH;
extern NSString *const FM_IDCARD_SCAN_RESULT_PROP_TW_HEALTH_ID_CARD_SERIAL_NUMBER;
