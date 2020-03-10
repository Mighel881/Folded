#include <CSColorPicker/CSColorPicker.h>

#define PLIST_PATH @"/User/Library/Preferences/com.thomz.foldy.plist"

inline NSString *StringForPreferenceKey(NSString *key) {
    NSDictionary *prefs = [NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] ? : [NSDictionary new];
    return prefs[key];
}

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
@end

@interface SBFolderBackgroundView : UIView
-(void)layoutSubviews;
-(void)setBackgroundColor:(UIColor *)arg1;
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
NSDictionary *preferences;
BOOL enabled;
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
BOOL customFolderIconEnabled;
long long folderIconRows;
long long folderIconColumns;
int titleFontWeight;
int titleAlignment;
BOOL titleColorEnabled;
NSString *titleColor;
BOOL titleBackgroundEnabled;
NSString *titleBackgroundColor;
double titleBackgroundCornerRadius;
BOOL showInjectionAlerts;

BOOL hasProcessLaunched;
BOOL hasInjectionFailed;
BOOL hasShownFailureAlert;

//Reloading the prefs (duh) 
static void reloadPrefs(){
	preferences = [[NSUserDefaults standardUserDefaults]persistentDomainForName:@"xyz.burritoz.thomz.folded.prefs"];
	enabled = [[preferences objectForKey:@"enabled"] boolValue];
	backgroundAlphaEnabled = [[preferences objectForKey:@"backgroundAlphaEnabled"] boolValue];
	backgroundAlpha = [[preferences objectForKey:@"backgroundAlpha"] doubleValue];
	cornerRadiusEnabled = [[preferences objectForKey:@"cornerRadiusEnabled"] boolValue];
	cornerRadius = [[preferences objectForKey:@"cornerRadius"] doubleValue];
	pinchToCloseEnabled = [[preferences objectForKey:@"pinchToCloseEnabled"] boolValue];
	customFrameEnabled = [[preferences objectForKey:@"customFrameEnabled"] boolValue];
	customCenteredFrameEnabled = [[preferences objectForKey:@"customCenteredFrameEnabled"] boolValue];
	frameX = [[preferences valueForKey:@"customFrameX"] floatValue];
	frameY = [[preferences valueForKey:@"customFrameY"] floatValue];
	frameWidth = [[preferences valueForKey:@"customFrameWidth"] floatValue];
	frameHeight = [[preferences valueForKey:@"customFrameHeight"] floatValue];
	customLayoutEnabled = [[preferences objectForKey:@"customLayoutEnabled"] boolValue];
	customLayoutRows = [[preferences objectForKey:@"customLayoutRows"] longLongValue];
	customLayoutColumns = [[preferences objectForKey:@"customLayoutColumns"] longLongValue];
    hideTitleEnabled = [[preferences objectForKey:@"hideTitleEnabled"] boolValue];
    customTitleFontSizeEnabled = [[preferences objectForKey:@"customTitleFontSizeEnabled"] boolValue];
    customTitleFontSize = [[preferences objectForKey:@"customTitleFontSize"] doubleValue];
    customTitleOffSetEnabled = [[preferences objectForKey:@"customTitleOffSetEnabled"] boolValue];
    customTitleOffSet = [[preferences objectForKey:@"customTitleOffSet"] doubleValue];
	customFolderIconEnabled = [[preferences objectForKey:@"customFolderIconEnabled"] boolValue];
    folderIconRows = [[preferences objectForKey:@"folderIconRows"] longLongValue];
	folderIconColumns = [[preferences objectForKey:@"folderIconColumns"] longLongValue];
	titleFontWeight = [[preferences objectForKey:@"titleFontWeight"] intValue];
	titleAlignment = [[preferences objectForKey:@"titleAlignment"] intValue];
	titleColorEnabled = [[preferences objectForKey:@"titleColorEnabled"] boolValue];
	titleColor = [preferences valueForKey:@"titleColor"];
	titleBackgroundEnabled = [[preferences objectForKey:@"titleBackgroundEnabled"] boolValue];
	titleBackgroundColor = [preferences valueForKey:@"titleBackgroundColor"];
	titleBackgroundCornerRadius = [[preferences objectForKey:@"titleBackgroundCornerRadius"] doubleValue];
	showInjectionAlerts = [[preferences objectForKey:@"showInjectionAlerts"] boolValue];
}
