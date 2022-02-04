/**
 * @file FMLicenseManager.h
 * The interface of CyberLink FaceMe License Manager.
 * CyberLink FaceMe (R) SDK
 * Copyright (C) 2018 CyberLink Corp. All rights reserved.
 * https://www.cyberlink.com
 */
#import <CoreImage/CoreImage.h>
#import <FaceMeSDK/FMLicenseManagerObject.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * CyberLink Face License Manager
 * @interface FaceMeLicenseManager
 */
@interface FMLicenseManager : NSObject

- (instancetype)init;

#pragma mark - General

/**
 * Initialize FaceMe License Manager.
 *
 * @param[in] config The configuration for license manager setup.
 * @param[in] licenseInfo The license information provided by CyberLink. The format of license information is a raw buffer.
 * @return Returns an <code>FR_RETURN</code>. Possible values include, but
 * are not limited to, the following list.
 *  * <code>FM_RETURN_OK</code>: Succeeded.
 *  * <code>FM_RETURN_FAIL</code>: Failed.
 *  * <code>FM_RETURN_INVALID_ARGUMENT</code>: The input argument is invalid.
 *  * <code>FM_RETURN_INCONSISTENT_VERSION</code>: The version of input data structure is not accepted or not filled in.
 *  * <code>FM_RETURN_LICENSE_FAIL</code>: The license is invalid.
 *  * <code>FM_RETURN_LICENSE_EXPIRED</code>: The license is expired.
 */
- (FM_RETURN)initialize:(FMLicenseManagerConfig *)config licenseInfo:(NSData *)licenseInfo;

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

#pragma mark - License

/**
 * Register license to do authentication with CyberLink license server.
 *
 * @return Returns an <code>FR_RETURN</code>. Possible values include, but
 * are not limited to, the following list.
 *  * <code>FM_RETURN_ASYNC</code>: Asynchronous operation.
 *  * <code>FM_RETURN_OK</code>: Succeeded.
 *  * <code>FM_RETURN_NO_INIT</code>: Not initialized yet.
 *  * <code>FM_RETURN_FAIL</code>: Failed.
 *  * <code>FM_RETURN_UNKNOWN_HOST</code>: Unknown license server error.
 *  * <code>FM_RETURN_NETWORK_ERROR</code>: Network error while communicating with the license server.
 *  * <code>FM_RETURN_LICENSE_FAIL</code>: The license is invalid.
 *  * <code>FM_RETURN_LICENSE_EXPIRED</code>: The license is expired.
 */
- (FM_RETURN)registerLicense;

/**
 Renew license to retrieve latest authentication options.
 */
- (FM_RETURN)renewLicense;

/**
 Deactivate authentication on current device.
 */
- (FM_RETURN)deactivateLicense;

@end

NS_ASSUME_NONNULL_END
