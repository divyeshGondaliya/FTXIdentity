/**
 * @file FMECardRecognizer.h
 * The interface of CyberLink FaceMe e-Card Recognizer.
 * CyberLink FaceMe (R) SDK
 * Copyright (c) CyberLink Corp. All rights reserved.
 * https://www.cyberlink.com
 */

/*
 @note For Japanese Driver's License Card.
    Please add below to the "Info.plist" of your app for NFC usage.
 
 <key>NFCReaderUsageDescription</key>
 <string>This application needs to scan NFC tags.</string>
 <key>com.apple.developer.nfc.readersession.iso7816.select-identifiers</key>
 <array>
     <string>A0000002310100000000000000000000</string>
     <string>A0000002310200000000000000000000</string>
     <string>A0000002480300000000000000000000</string>
 </array>
 
 @note Please also cabability of "Near Field Communication Tag Reading".
 
 <key>com.apple.developer.nfc.readersession.formats</key>
 <array>
     <string>NDEF</string>
     <string>TAG</string>
 </array>

 */

#import <CoreImage/CoreImage.h>
#import <FaceMeSDK/FMECardRecognizerObject.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * CyberLink Face e-Card Recognizer
 * @interface FMECardRecognizer
 */
@interface FMECardRecognizer : NSObject

- (instancetype)init;

#pragma mark - General

/**
 * Initialize FaceMe ECardRecognizer.
 *
 * @param[in] config The configuration for ECardRecognizer setup.
 * @param[in] licenseInfo The license information provided by CyberLink. The format of license information is a raw buffer.
 * @return Returns an <code>FM_RETURN</code>. Possible values include, but
 * are not limited to, the following list.
 *  * <code>FM_RETURN_OK</code>: Succeeded.
 *  * <code>FM_RETURN_FAIL</code>: Failed.
 *  * <code>FM_RETURN_INVALID_ARGUMENT</code>: The input argument is invalid.
 *  * <code>FM_RETURN_INCONSISTENT_VERSION</code>: The version of input data structure is not accepted or not filled in.
 *  * <code>FM_RETURN_LICENSE_FAIL</code>: The license is invalid.
 *  * <code>FM_RETURN_LICENSE_EXPIRED</code>: The license is expired.
 *  * <code>FM_RETURN_LICENSE_NOT_SUPPORT</code>: The license feature is not supported.
 */
- (FM_RETURN)initialize:(FMECardRecognizerConfig *)config licenseInfo:(NSData *)licenseInfo;

/**
 * Finalize FaceMe SDK and release corresponding resources.
 *
 * @return Returns an <code>FM_RETURN</code>. Possible values include, but
 * are not limited to, the following list.
 *  * <code>FM_RETURN_OK</code>: Succeeded.
 *  * <code>FM_RETURN_NO_INIT</code>: Not initialized yet.
 *  * <code>FM_RETURN_FAIL</code>: Failed.
 */
- (FM_RETURN)finalize;

/**
 * Set property.
 *
 * @param[in] propertyId An utf-8 encoded string of property identifier.
 * @param[in] value The specified type of reference variant value by property identifier.
 * @return Returns an <code>FM_RETURN</code>. Possible values include, but
 * are not limited to, the following list.
 *  * <code>FM_RETURN_OK</code>: Succeeded.
 *  * <code>FM_RETURN_INVALID_ARGUMENT</code>: The property identifier is not found.
 */
- (FM_RETURN)setProperty:(NSString *)propertyId value:(NSObject *)value;

/**
 * Get property.
 *
 * @param[in] propertyId An utf-8 encoded string of property identifier.
 * @return Returns the specified type of reference variant value by property identifier.
 */
- (nullable NSObject *)getProperty:(NSString *)propertyId;


#pragma mark - Scan

/**
 * Scan e-Card.
 *
 * @param[in] scanConfig Providing configuration to improve the scan.
 * @param[in] image The image to scan passport.
 * @param[in,out] scanResult The information of scan result.
 * @return Returns an <code>FM_RETURN</code>. Possible values include, but
 * are not limited to, the following list.
 *  * <code>FM_RETURN_OK</code>: Succeeded.
 *  * <code>FM_RETURN_FAIL</code>: Failed.
 *  * <code>FM_RETURN_NOT_SUPPORT</code>: e-card is not supported.
 *  * <code>FM_RETURN_INVALID_ARGUMENT</code>: The input argument is invalid.
 *  * <code>FM_RETURN_INCONSISTENT_VERSION</code>: The version of input data structure is not accepted or not filled in.
 */
- (FM_RETURN)scan:(FMECardScanConfig *)scanConfig
            image:(CIImage *)image
       scanResult:(FMECardScanResult *_Nonnull*_Nonnull)scanResult;

#pragma mark - Read

/**
 * Read e-Card.
 *
 * @param[in] readConfig Providing configuration to improve the e-Card read.
 * @param[in] scanResult The information of scan result if need.
 * @param[in,out] progressBlock The progress block to show progress message.
 * @param[in,out] completionBlock The completion block when read is completed.
 * @return Returns an <code>FM_RETURN</code>. Possible values include, but
 * are not limited to, the following list.
 *  * <code>FM_RETURN_OK</code>: Succeeded.
 *  * <code>FM_RETURN_FAIL</code>: Failed.
 *  * <code>FM_RETURN_NOT_SUPPORT</code>: e-card is not supported.
 *  * <code>FM_RETURN_INVALID_ARGUMENT</code>: The input argument is invalid.
 *  * <code>FM_RETURN_INCONSISTENT_VERSION</code>: The version of input data structure is not accepted or not filled in.
 */
- (FM_RETURN)read:(FMECardReadConfig *)readConfig
       scanResult:(FMECardScanResult *_Nullable)scanResult
         progress:(FMECardProgressBlock _Nullable)progressBlock
        completed:(FMECardCompletionBlock _Nullable)completionBlock API_AVAILABLE(ios(13));

@end


NS_ASSUME_NONNULL_END
