/*
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 *
 * CyberLink FaceMe (R) SDK
 * Copyright (c) CyberLink Corp. All rights reserved.
 * https://www.cyberlink.com
 */

#import <CoreImage/CoreImage.h>
#import <UIKit/UIKit.h>

#import <FaceMeSDK/FMBaseObject.h>
#import <FaceMeSDK/FMSpeechRecognizerObject.h>

typedef NS_ENUM(NSInteger, FMASD_DETECT_RESULT) {
    FMASD_DETECT_RESULT_LIVENESS = 0,
    FMASD_DETECT_RESULT_SPOOFING = 1,
    FMASD_DETECT_RESULT_SHAKEN = 2
};

typedef NS_ENUM(NSInteger, FMASD_PRECISION_MODE) {
    FMASD_PRECISION_MODE_NONE = 0,
    FMASD_PRECISION_MODE_HIGH = 1,
    FMASD_PRECISION_MODE_STANDARD = 2,
    FMASD_PRECISION_MODE_FAST = 3
};

typedef NS_ENUM(NSInteger, FMASD_USER_INTERACTION_MODE) {
    FMASD_USER_INTERACTION_MODE_NONE = 0,
    FMASD_USER_INTERACTION_MODE_AUTO = 1,
    FMASD_USER_INTERACTION_MODE_OFF  = 2,
    FMASD_USER_INTERACTION_MODE_ON_WITH_RANDOM_ACTION = 3
};

/**
 Deprecated

 This Enum is for internal Beta developing, and will be removed soon.
 */
typedef NS_ENUM(NSInteger, FMASD_SPEECH_RESULT) {
    FMASD_SPEECH_RESULT_NONE = 0,
    FMASD_SPEECH_RESULT_OK = 1,
    FMASD_SPEECH_RESULT_UNKNOWN = 2,
    FMASD_SPEECH_RESULT_FAIL = 3,
    FMASD_SPEECH_RESULT_LOW_VOLUME  = 4,
    FMASD_SPEECH_RESULT_INIT_FAIL = 5,
    FMASD_SPEECH_RESULT_FEATURE_FAIL = 6,
    FMASD_SPEECH_RESULT_DIGIT_FAIL = 7
};

#pragma mark -
@interface AntiSpoofingResult : NSObject

@property (readonly) CIImage * _Nullable image;
@property (readonly) FMFaceInfo * _Nullable faceInfo;
@property (readonly) FMASD_DETECT_RESULT result;
@property (readonly) double score;

@property (readonly) FMSpeechFeature * _Nullable speechFeature API_AVAILABLE(ios(13.0));

/**
 Deprecated

 This attribute is for internal Beta developing, and will be removed soon.
 */
@property (readonly) FMASD_SPEECH_RESULT speechResult;

@end

NS_ASSUME_NONNULL_BEGIN
@interface AntiSpoofingLayoutSetting : NSObject
@property (nonatomic, strong) UIColor *frameActiveColor;
@property (nonatomic, strong) UIColor *frameIdleColor;
@property (nonatomic, assign) CGFloat frameBorderWidth;
@property (nonatomic, assign) BOOL showFrame;
@property (nonatomic, strong) UIColor *circleActiveColor;
@property (nonatomic, strong) UIColor *circleIdleColor;
@property (nonatomic, assign) CGFloat circleBorderWidth;

@property (nonatomic, assign) BOOL showFPS;

@property (nonatomic, strong) UIColor *actionHintColor;
@property (nonatomic, strong) UIFont *actionHintFont;
@property (nonatomic, strong) UIColor *actionDetailHintActiveColor;
@property (nonatomic, strong) UIColor *actionDetailHintIdleColor;
@property (nonatomic, strong) UIFont *actionDetailHintFont;

@property (nonatomic, strong) UIColor *progressBarForegroundColor;
@property (nonatomic, strong) UIColor *progressBarBackgroundColor;
@property (nonatomic, assign) CGFloat progressBarWidth;
@property (nonatomic, assign) CGFloat progressBarHeight;

@property (nonatomic, strong) UIColor *userActionHintColor;
@property (nonatomic, strong) UIFont *userActionHintFont;
@property (nonatomic, assign) BOOL showUserActionSteps;

@property (nonatomic, strong) UIColor *speechNumberActiveColor;
@property (nonatomic, strong) UIColor *speechNumberIdleColor;
@property (nonatomic, strong) UIFont *speechNumberFont;
@property (nonatomic, strong) UIColor *speechLanguageColor;
@property (nonatomic, strong) UIFont *speechLanguageFont;
@property (nonatomic, strong) UIColor *speechLanguageBackgroundColor;
@property (nonatomic, assign) BOOL showSpeechLanguage;

@property (nonatomic, strong) UIColor *footerTitleColor;
@property (nonatomic, strong) UIFont *footerTitleFont;
@property (nonatomic, strong) UIColor *footerSubtitleColor;
@property (nonatomic, strong) UIFont *footerSubtitleFont;
@property (nonatomic, assign) BOOL showFooter;

@property (nonatomic, strong) UIColor *alertBackgroundColor;
@property (nonatomic, strong) UIColor *alertTitleColor;
@property (nonatomic, strong) UIFont *alertTitleFont;
@property (nonatomic, strong) UIColor *alertDescriptionColor;
@property (nonatomic, strong) UIFont *alertDescriptionFont;
@property (nonatomic, assign) CGFloat alertDistanceToCircle;

@end

#pragma mark - Voice Hint
@interface FileResource : NSObject

@property (nonatomic, strong) NSBundle *bundle;
@property (nonatomic, strong) NSString *filename;
@property (nonatomic, strong) NSString *type;

- (instancetype)initWithBundle:(NSBundle *)bundle filename:(NSString *)filename type:(NSString *)type;

@end

@interface AntiSpoofingVoiceHintSetting : NSObject

@property (nonatomic, strong) FileResource *turnHeadLeft;
@property (nonatomic, strong) FileResource *turnHeadRight;
@property (nonatomic, strong) FileResource *smile;
@property (nonatomic, strong) FileResource *nodHead;
@property (nonatomic, strong) FileResource *envTooDark;
@property (nonatomic, strong) FileResource *centerFace;
@property (nonatomic, strong) FileResource *comeCloser;
@property (nonatomic, strong) FileResource *goFarther;
@property (nonatomic, strong) FileResource *stayStill;
@property (nonatomic, strong) FileResource *actionDone;

@end

NS_ASSUME_NONNULL_END
