#import <Foundation/Foundation.h>
#include <CSColorPicker/CSColorPicker.h>
#include <libcolorpicker.h>
UIColor *colorFromDefaultsWithKey(NSString *defaults, NSString *key, NSString *fallback);

@interface SBIconController : UIAlertController
@end

@interface SBIconListGridLayoutConfiguration
@property (nonatomic, assign) BOOL isFolder;

- (BOOL)getLocations;
- (NSUInteger)numberOfPortraitColumns;
- (NSUInteger)numberOfPortraitRows;
@end

//I use this to change the folder icon on ios 12, and fix the crashes on ios 13
@interface SBIconGridImage
+(id)gridImageForLayout:(id)arg1 previousGridImage:(id)arg2 previousGridCellIndexToUpdate:(unsigned long long)arg3 pool:(id)arg4 cellImageDrawBlock:(id)arg5 ;
+(id)gridImageForLayout:(id)arg1 cellImageDrawBlock:(id)arg2 ;
+(id)gridImageForLayout:(id)arg1 pool:(id)arg2 cellImageDrawBlock:(id)arg3 ;
@end

@interface SBFloatyFolderView : UIView
-(void)layoutSubviews;
-(void)setBackgroundColor:(UIColor *)arg1;
-(UIColor *)randomColor;
@end

@interface SBFolderBackgroundMaterialSettings
-(UIColor *)randomColor;
@end

@interface SBFolderIconBackgroundView : UIView
@end

@interface MTMaterialView : UIVisualEffectView
@end

@interface SBFolderBackgroundView : UIView
-(void)layoutSubviews;
-(void)setBackgroundColor:(UIColor *)arg1;
@property (nonatomic, retain) MTMaterialView *blurView;
@property (nonatomic, retain) UIVisualEffectView *lightView;
@property (nonatomic, retain) UIVisualEffectView *darkView;
@end

@interface SBFolderControllerBackgroundView : UIView
@property (nonatomic, retain) UIColor *backgroundColor;
@property (nonatomic, assign) CGFloat aplha;
-(void)layoutSubviews;
@end

@interface SBWallpaperEffectView : UIView
@property (nonatomic, retain) UIView *blurView;
@end

@interface SBFolderIconImageView : UIView
@property (nonatomic, retain) SBWallpaperEffectView *backgroundView;
@property (nonatomic, assign) CGFloat aplha;
@property (nonatomic, assign) CGAffineTransform transform;
@end

@interface SBIconListPageControl : UIView
@property (nonatomic, assign) BOOL hidden;
@end

@interface _SBIconGridWrapperView : UIView
@property (nonatomic, assign) CGAffineTransform transform;
@end

@interface UITextFieldBorderView
@property (nonatomic, assign) BOOL hidden;
-(void)layoutSubviews;
@end

@class UITextField, UIFont;
@interface SBFolderTitleTextField : UITextField
@property (nonatomic, assign) CGRect frame;
@property (nonatomic, assign) CGRect bounds;
@property (nonatomic, strong) UIFont *font;
-(void)setFont:(id)arg1 fullFontSize:(id)arg2 ambientOnly:(BOOL)arg3;
-(void)setTextCentersHorizontally:(BOOL)arg1;
-(void)layoutSubviews;
@end

// Defining global variables and methods

// Preferences keys
BOOL enabled = YES;
BOOL backgroundAlphaEnabled;
double backgroundAlpha;
BOOL cornerRadiusEnabled;
double cornerRadius;
BOOL pinchToCloseEnabled;
BOOL customFrameEnabled;
BOOL customCenteredFrameEnabled;
CGFloat frameX;
CGFloat frameY;
CGFloat frameWidth;
CGFloat frameHeight;
BOOL customLayoutEnabled;
long long customLayoutRows;
long long customLayoutColumns;
BOOL hideTitleEnabled;
BOOL customTitleFontSizeEnabled;
double customTitleFontSize;
BOOL customTitleOffSetEnabled;
double customTitleOffSet;
BOOL customTitleXOffSetEnabled;
double customTitleXOffSet;
BOOL customFolderIconEnabled;
long long folderIconRows;
long long folderIconColumns;
BOOL twoByTwoIconEnabled;
int titleFontWeight;
int titleAlignment;
BOOL titleColorEnabled;
NSString *titleColor;
BOOL titleBackgroundEnabled;
NSString *titleBackgroundColor;
double titleBackgroundCornerRadius;
BOOL titleBackgroundBlurEnabled;
BOOL showInjectionAlerts;
BOOL customBlurBackgroundEnabled;
int customBlurBackground;
BOOL folderBackgroundColorEnabled;
NSString *folderBackgroundColor;
BOOL customTitleFontEnabled;
NSString *customTitleFont;
BOOL seizureModeEnabled;
BOOL folderBackgroundBackgroundColorEnabled;
double backgroundAlphaColor;
NSString * folderBackgroundBackgroundColor;
BOOL randomColorBackgroundEnabled;
BOOL folderBackgroundColorWithGradientEnabled;
NSString *gradientColorOne;
NSString *gradientColorTwo;
BOOL folderBackgroundColorWithGradientVerticalGradientEnabled; // bruh
BOOL hideFolderGridEnabled;
BOOL clearBackgroundIcons;
BOOL customWallpaperBlurEnabled;
double customWallpaperBlurFactor;
BOOL tapToCloseEnabled;
BOOL customTitleBoxWidthEnabled;
double customTitleBoxWidth;
BOOL customTitleBoxHeightEnabled;
double customTitleBoxHeight;
BOOL hideFolderIconBackground;

BOOL hasProcessLaunched;
BOOL hasInjectionFailed;
BOOL hasShownFailureAlert;

#define PLIST_PATH @"/User/Library/Preferences/xyz.burritoz.thomz.folded.prefs.plist"
#define kIdentifier @"xyz.burritoz.thomz.folded.prefs"
#define kSettingsChangedNotification (CFStringRef)@"xyz.burritoz.thomz.folded.prefs/reload"
#define kSettingsPath @"/var/mobile/Library/Preferences/xyz.burritoz.thomz.folded.prefs.plist"

NSDictionary *prefs = nil;

inline NSString *StringForPreferenceKey(NSString *key) {
    NSDictionary *prefs = [NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] ? : [NSDictionary new];
    return prefs[key];
}

static void *observer = NULL;

static void reloadPrefs() 
{
    if ([NSHomeDirectory() isEqualToString:@"/var/mobile"]) 
    {
        CFArrayRef keyList = CFPreferencesCopyKeyList((CFStringRef)kIdentifier, kCFPreferencesCurrentUser, kCFPreferencesAnyHost);

        if (keyList) 
        {
            prefs = (NSDictionary *)CFBridgingRelease(CFPreferencesCopyMultiple(keyList, (CFStringRef)kIdentifier, kCFPreferencesCurrentUser, kCFPreferencesAnyHost));

            if (!prefs) 
            {
                prefs = [NSDictionary new];
            }
            CFRelease(keyList);
        }
    } 
    else 
    {
        prefs = [NSDictionary dictionaryWithContentsOfFile:kSettingsPath];
    }
}


static BOOL boolValueForKey(NSString *key, BOOL defaultValue) {
    return (prefs && [prefs objectForKey:key]) ? [[prefs objectForKey:key] boolValue] : defaultValue;
}

static double numberForValue(NSString *key, double defaultValue) {
	return (prefs && [prefs objectForKey:key]) ?  [[prefs objectForKey:key] doubleValue] : defaultValue;
	//I'm pretty sure a double will return fine to any numeric variable
}

static void preferencesChanged() 
{
    CFPreferencesAppSynchronize((CFStringRef)kIdentifier);
    reloadPrefs();

	enabled = boolValueForKey(@"enabled", YES);
	backgroundAlphaEnabled = boolValueForKey(@"backgroundAlphaEnabled", NO);
	backgroundAlpha = numberForValue(@"backgroundAlpha", 1.0);
	cornerRadiusEnabled = boolValueForKey(@"cornerRadiusEnabled", NO);
	cornerRadius = numberForValue(@"cornerRadius", 10);
	pinchToCloseEnabled = boolValueForKey(@"pinchToCloseEnabled", NO);
	customFrameEnabled = boolValueForKey(@"customFrameEnabled", NO);
	customCenteredFrameEnabled = boolValueForKey(@"customCenteredFrameEnabled", NO);
	frameX = numberForValue(@"customFrameX", 0);
	frameY = numberForValue(@"customFrameY", 0);
	frameWidth = numberForValue(@"customFrameWidth", 300);
	frameHeight = numberForValue(@"customFrameHeight", 300);
	customLayoutEnabled = boolValueForKey(@"customLayoutEnabled", NO);
	customLayoutRows = numberForValue(@"customLayoutRows", 4);
	customLayoutColumns = numberForValue(@"customLayoutColumns", 4);
    hideTitleEnabled = boolValueForKey(@"hideTitleEnabled", NO);
    customTitleFontSizeEnabled = boolValueForKey(@"customTitleFontSizeEnabled", NO);
    customTitleFontSize = numberForValue(@"customTitleFontSize", 36);
    customTitleOffSetEnabled = boolValueForKey(@"customTitleOffSetEnabled", NO);
    customTitleOffSet = numberForValue(@"customTitleOffSet", 0);
	customTitleXOffSetEnabled = boolValueForKey(@"customTitleXOffSetEnabled", NO);
    customTitleXOffSet = numberForValue(@"customTitleXOffSet", 0);
	customFolderIconEnabled = boolValueForKey(@"customFolderIconEnabled", NO);
    folderIconRows = numberForValue(@"folderIconRows", 3);
	folderIconColumns = numberForValue(@"folderIconColumns", 3);
	twoByTwoIconEnabled = boolValueForKey(@"twoByTwoIconEnabled", NO);
	titleFontWeight = numberForValue(@"titleFontWeight", 1);
	titleAlignment = numberForValue(@"titleAlignment", 1);
	titleColorEnabled = boolValueForKey(@"titleColorEnabled", NO);
	titleColor = [prefs objectForKey:@"titleColor"];
	titleBackgroundEnabled = boolValueForKey(@"titleBackgroundEnabled", NO);
	titleBackgroundColor = [prefs objectForKey:@"titleBackgroundColor"];
	titleBackgroundCornerRadius = numberForValue(@"titleBackgroundCornerRadius", 10);
	titleBackgroundBlurEnabled = boolValueForKey(@"titleBackgroundBlurEnabled", NO);
	showInjectionAlerts = boolValueForKey(@"showInjectionAlerts", YES);
	customBlurBackgroundEnabled = boolValueForKey(@"customBlurBackgroundEnabled", NO);
	customBlurBackground = numberForValue(@"customBlurBackground", 1);
	folderBackgroundColorEnabled = boolValueForKey(@"folderBackgroundColorEnabled", NO);
	folderBackgroundColor = [prefs objectForKey:@"folderBackgroundColor"];
	customTitleFontEnabled = boolValueForKey(@"customTitleFontEnabled", NO);
	customTitleFont = [[prefs valueForKey:@"customTitleFont"] stringValue];
	seizureModeEnabled = boolValueForKey(@"seizureModeEnabled", NO);
	folderBackgroundBackgroundColorEnabled = boolValueForKey(@"folderBackgroundBackgroundColorEnabled", NO);
	backgroundAlphaColor = numberForValue(@"backgroundAlphaColor", 0);
	folderBackgroundBackgroundColor = [prefs objectForKey:@"folderBackgroundBackgroundColor"];
	randomColorBackgroundEnabled = boolValueForKey(@"randomColorBackgroundEnabled", NO);
	folderBackgroundColorWithGradientEnabled = boolValueForKey(@"folderBackgroundColorWithGradientEnabled", NO);
	gradientColorOne = [prefs objectForKey:@"gradientColorOne"];
	gradientColorTwo = [prefs objectForKey:@"gradientColorTwo"];
	folderBackgroundColorWithGradientVerticalGradientEnabled = boolValueForKey(@"folderBackgroundColorWithGradientVerticalGradientEnabled", NO);
	hideFolderGridEnabled = boolValueForKey(@"hideFolderGridEnabled", NO);
	clearBackgroundIcons = boolValueForKey(@"clearBackgroundIcons", NO);
	customWallpaperBlurEnabled = boolValueForKey(@"customWallpaperBlurEnabled", NO);
	customWallpaperBlurFactor = numberForValue(@"customWallpaperBlurFactor", 1.0);
	tapToCloseEnabled = boolValueForKey(@"tapToCloseEnabled", NO);
	customTitleBoxWidthEnabled = boolValueForKey(@"customTitleBoxWidthEnabled", NO);
	customTitleBoxHeightEnabled = boolValueForKey(@"customTitleBoxHeightEnabled", NO);
	customTitleBoxWidth = numberForValue(@"customTitleBoxWidth", 100);
	customTitleBoxHeight = numberForValue(@"customTitleBoxHeight", 50);
	hideFolderIconBackground = boolValueForKey(@"hideFolderIconBackground", NO);

	NSLog(@"[Folded]: Preferences reloaded sucessfully.");
	//Hopefully this works :D
}