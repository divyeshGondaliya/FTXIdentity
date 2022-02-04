/*
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 *
 * CyberLink FaceMe (R) SDK
 * Copyright (c) CyberLink Corp. All rights reserved.
 * https://www.cyberlink.com
 */

#import <UIKit/UIKit.h>

#import <FaceMeSDK/FMBaseObject.h>
#import <FaceMeSDK/FMSpeechRecognizer.h>
#import <FaceMeSDK/AntiSpoofingDef.h>
#import <FaceMeSDK/AntiSpoofingManager.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AntiSpoofingDelegate <NSObject>

@optional
- (void)onDetectError:(FM_RETURN)returnCode;
- (void)detectFinish:(AntiSpoofingResult *)result;

- (void)detectFinish:(CIImage *)image faceInfo:(FMFaceInfo *)faceInfo result:(FMASD_DETECT_RESULT)result score:(double)score
        __attribute((deprecated("This method will be removed in FaceMeSDK version 6.0. Use the detectFinish: instead")));
- (void)detectFinish:(CIImage *)image isLive:(BOOL)isLive faceInfo:(FMFaceInfo *)faceInfo
        __attribute((deprecated("This method will be removed in FaceMeSDK version 6.0. Use the detectFinish:faceInfo:result:score: instead")));
- (void)detectFinish:(NSString *)detectName image:(CIImage *)image isLive:(BOOL)isLive faceInfo:(FMFaceInfo *)faceInfo
        __attribute((deprecated("This method will be removed in FaceMeSDK version 6.0. Use the detectFinish:faceInfo:result:score: instead")));
- (void)detectFinish:(CIImage *)image faceInfo:(FMFaceInfo *)faceInfo result:(FMASD_DETECT_RESULT)result
        __attribute((deprecated("This method will be removed in FaceMeSDK version 6.0. Use the detectFinish:faceInfo:result:score: instead")));

@end

@interface AntiSpoofingViewController : UIViewController

@property (nonatomic, weak) id<AntiSpoofingDelegate> delegate;
@property (nonatomic, strong, nonnull) AntiSpoofingLayoutSetting *layoutSetting;
@property (nonatomic, strong, nonnull) AntiSpoofingVoiceHintSetting *voiceHintSetting;

- (instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil mode:(FMASD_PRECISION_MODE)mode;

- (void)startDetect;
- (void)stopDetect;
- (void)setBottomHidden:(BOOL)hidden __attribute((deprecated("Use the layoutSetting property instead")));
- (void)setAppIcon:(UIImage *)icon;
- (void)setAppTitle:(NSString *)title __attribute((deprecated("Use the setLocalizedString:dict: instead")));
- (void)setAppSubtitle:(NSString *)title __attribute((deprecated("Use the setLocalizedString:dict: instead")));
- (void)setUserInteraction:(BOOL)enable __attribute((deprecated("Use the setUserInteractionMode: instead")));
- (void)setLocalizedString:(NSDictionary<NSString*, NSString*> *)dict;
- (void)setShowFPS:(BOOL)showFPS __attribute((deprecated("Use the layoutSetting property instead")));
- (void)updatePrecisionMode:(FMASD_PRECISION_MODE)mode;
- (CGRect)getMaskOvalFrame;
- (CGRect)getMaskLayoutFrame;

- (void)setUserInteractionMode:(FMASD_USER_INTERACTION_MODE)mode;
- (FM_RETURN)setRandomActionCount:(int)count;
- (void)setEnableSmileAction:(BOOL)enable;
- (void)setEnableNodHeadAction:(BOOL)enable;
- (void)setEnableVibrateAfterEachActionComplete:(BOOL)enable;
- (void)setEnableVoiceAction:(BOOL)enable API_AVAILABLE(ios(13.0));
- (void)setSpeechRecognizer:(FMSpeechRecognizer * _Nullable)speechRecognizer API_AVAILABLE(ios(13.0));

- (void)setEnableVoiceHint:(BOOL)enable;
- (void)setEnableMask:(BOOL)enable;

- (FM_RETURN)setProperty:(NSString *)propertyId value:(NSObject * _Nullable)value;

@end

NS_ASSUME_NONNULL_END
