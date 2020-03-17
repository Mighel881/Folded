#include "Tweak.h"

%group SBFloatyFolderView
%hook SBFloatyFolderView

-(void)setBackgroundAlpha:(double)arg1 { // returning the value from the slider cell in the settings for the bg alpha

	if(enabled && backgroundAlphaEnabled){
		return %orig(backgroundAlpha);
	}
}

-(void)setCornerRadius:(double)arg1 { // returning the value from the slider cell in the settings for the corner radius
	
	if(enabled && cornerRadiusEnabled){
		return %orig(cornerRadius);
	}
}

-(CGRect)_frameForScalingView { // modyfing the frame with the values from the settings

	if(enabled && customFrameEnabled){
		if(customCenteredFrameEnabled){
			return CGRectMake((self.bounds.size.width - frameWidth)/2, (self.bounds.size.height - frameHeight)/2,frameWidth,frameHeight); // simple calculation to center things
		} else if(!customCenteredFrameEnabled){
			return CGRectMake(frameX,frameY,frameWidth,frameHeight);
		} else {return %orig;}
	} else {return %orig;}
}

-(BOOL)_showsTitle { // simply hide the title

	if(enabled && hideTitleEnabled){
		return NO;
	} else {
		return YES;
	}
}

-(double)_titleFontSize { // return the value from the slider for the font size

	if(enabled && customTitleFontSizeEnabled){
		return customTitleFontSize;
	} else {return %orig;}
}

-(void)scrollViewDidScroll:(id)arg1 {
	if(enabled && seizureModeEnabled){
		[self setBackgroundColor:[self randomColor]];
	}
}

%new
- (UIColor *)randomColor {

	int r = arc4random_uniform(256);
	int g = arc4random_uniform(256);
	int b = arc4random_uniform(256);

	return [UIColor colorWithRed:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:1.0f];
}

%end
%end

%group SBFolderBackgroundMaterialSettings
%hook SBFolderBackgroundMaterialSettings

-(UIColor *)baseOverlayColor { // this effect looks so sweet

	UIColor *color = [UIColor cscp_colorFromHexString:folderBackgroundBackgroundColor];

	if(enabled && folderBackgroundBackgroundColorEnabled){
		return color;
	} else if(enabled && randomColorBackgroundEnabled){
		return [self randomColor];
	} else {return %orig;}
}

-(double)baseOverlayTintAlpha {
	if(enabled && folderBackgroundBackgroundColorEnabled){
		return backgroundAlphaColor;
	} else if(enabled && randomColorBackgroundEnabled){
		return backgroundAlphaColor;
	} else {return %orig;}
}

%new
- (UIColor *)randomColor {

	int r = arc4random_uniform(256);
	int g = arc4random_uniform(256);
	int b = arc4random_uniform(256);

	return [UIColor colorWithRed:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:1.0f];
}

%end
%end

%group SBFolderTitleTextField
%hook SBFolderTitleTextField

-(CGRect)textRectForBounds:(CGRect)arg1 { // title offset
	
	CGRect original = %orig;

	if(enabled && customTitleOffSetEnabled){
		//return CGRectMake(original.origin.x,(original.origin.y)-customTitleOffSet,original.size.width,original.size.height);
		return %orig;
		[self setFrame:CGRectMake(original.origin.x,(original.origin.y)-customTitleOffSet,original.size.width,original.size.height)]; // everything original except the y
	} else {return original;}
} // This should wokr but i can't try it because of the title prefs crashing, hope you'll be able to fix soon :)

-(void)layoutSubviews {
	%orig;

	UIColor *color = [UIColor cscp_colorFromHexString:titleColor];
	UIColor *color2 = [UIColor cscp_colorFromHexString:titleBackgroundColor];

	if(enabled && titleFontWeight == 1){

	} else if(enabled && titleFontWeight == 2){
		[self setFont:[UIFont systemFontOfSize:(self.font.pointSize)]]; // for some reason, systemFontOfSize is bigger than the title font
	} else if(enabled && titleFontWeight == 3){
		[self setFont:[UIFont boldSystemFontOfSize:(self.font.pointSize)]];
	}

	if(enabled && titleAlignment == 1){
		[self setTextAlignment:NSTextAlignmentLeft];
	} else if(enabled && titleAlignment == 2){

	} else if(enabled && titleAlignment == 3){
		[self setTextAlignment:NSTextAlignmentRight];
	}

	if(enabled && titleColorEnabled){
		[self setTextColor:color];
	}

	if(enabled && titleBackgroundEnabled){
		[self setBackgroundColor:color2];
		[self.layer setMasksToBounds:true];
		[self.layer setCornerRadius:titleBackgroundCornerRadius];
	}

	if (enabled && customTitleFontEnabled) {
    	[self setFont:[UIFont fontWithName:customTitleFont size:(self.font.pointSize)]];
	}

	if(enabled && customTitleOffSetEnabled){
		[self setFrame:CGRectMake(self.frame.origin.x,(self.bounds.origin.y)+customTitleOffSet,self.bounds.size.width,self.bounds.size.height)]; 
	}
}

%end
%end

%group pinchToClose12
%hook SBFolderSettings

-(BOOL)pinchToClose { // enable pinch to close 

	if(enabled && pinchToCloseEnabled){
		return YES;
	} else {
		return NO;
	}
}

%end
%end

%group pinchToClose13
%hook SBHFolderSettings

-(BOOL)pinchToClose { // enable pinch to close again

	if(enabled && pinchToCloseEnabled){
		return YES;
	} else {
		return NO;
	}
}

%end
%end

%group layout12
%hook SBFolderIconListView

+ (unsigned long long)maxVisibleIconRowsInterfaceOrientation:(long long)arg1 {

	if(enabled && customLayoutEnabled){
		return (customLayoutRows);
	} else {return %orig;}
}

+ (unsigned long long)iconColumnsForInterfaceOrientation:(long long)arg1 { // same for columns

	if(enabled && customLayoutEnabled){
    	return (customLayoutColumns);
	} else {return %orig;}
}

%end
%end

%group layout13
//This part is crucial to my method :devil_face:
%hook SBIconController

-(void)viewDidAppear:(BOOL)arg1 {
  %orig;
  hasProcessLaunched = YES;

  if (hasInjectionFailed && showInjectionAlerts && !hasShownFailureAlert) {
	  UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Folded"
                               message:@"Folded has failed to inject a custom folder icon layout. This is due to another tweak interfering with Folded. Please note Cartella has prevented a crash that would have occured due to this." // wut ?
                               preferredStyle:UIAlertControllerStyleAlert];
 
		UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleDefault
   		handler:^(UIAlertAction * action) {}];
 
		[alert addAction:defaultAction];
		[self presentViewController:alert animated:YES completion:nil];
                hasShownFailureAlert = YES;
  }

}

%end

%hook SBIconListGridLayoutConfiguration

%property (nonatomic, assign) BOOL isFolder;

%new
-(BOOL)getLocations {
  NSUInteger locationColumns = MSHookIvar<NSUInteger>(self, "_numberOfPortraitColumns");
  NSUInteger locationRows = MSHookIvar<NSUInteger>(self, "_numberOfPortraitRows");
  if (locationColumns == 3 && locationRows == 3) {
    self.isFolder = YES;
  } else {
    self.isFolder = NO;
  }
  return self.isFolder;
}

-(NSUInteger)numberOfPortraitColumns {
  [self getLocations];
  if (self.isFolder && enabled) {
    if (hasProcessLaunched) {
    return (customLayoutColumns);
    } else {
      @try {
      return (folderIconColumns);
      } @catch (NSException *exception) {
      return customLayoutColumns;
	  hasInjectionFailed = YES;
      }
    }
  } else {
    return (%orig);
  }
}

-(NSUInteger)numberOfPortraitRows {
  [self getLocations];
  if (self.isFolder && enabled) {
    if (hasProcessLaunched) {
    return (customLayoutRows);
    } else {
      @try {
      return (folderIconRows);
      } @catch (NSException *exception) {
      return customLayoutRows;
	  hasInjectionFailed = YES;
      }
    }
  } else {
    return (%orig);
  }
}

%end
%end

%group SBFolderBackgroundView
%hook SBFolderBackgroundView
%property (nonatomic, retain) UIVisualEffectView *lightView;
%property (nonatomic, retain) UIVisualEffectView *darkView;
-(void)layoutSubviews {
	%orig;
    self.lightView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
	self.lightView.frame = self.bounds;
	self.darkView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
	self.darkView.frame = self.bounds;
	UIView *backgroundColorFrame = [[UIView alloc] initWithFrame:self.bounds];
	UIColor *backgroundColor = [UIColor cscp_colorFromHexString:folderBackgroundColor];
	[backgroundColorFrame setBackgroundColor:backgroundColor];

	if(enabled && customBlurBackgroundEnabled && customBlurBackground == 1){
		MSHookIvar<UIVisualEffectView *>(self, "_blurView") = self.lightView;
		[[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
		[self addSubview:self.lightView];
	}

	if(enabled && customBlurBackgroundEnabled && customBlurBackground == 2){
		MSHookIvar<UIVisualEffectView *>(self, "_blurView") = self.darkView;
		[[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
		[self addSubview:self.darkView];
	}

	if(enabled && folderBackgroundColorEnabled){
		[[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
		[self addSubview:backgroundColorFrame];
	}

}
%end
%end

%group iconGrid12
%hook SBIconGridImage

+ (unsigned long long)numberOfColumns {

	if(enabled && twoByTwoIconEnabled){
		return 2;
	} else {return %orig;}
}

+ (unsigned long long)numberOfRowsForNumberOfCells:(unsigned long long)arg1 {
    
	if(enabled && twoByTwoIconEnabled){
		return 2;
	} else {return %orig;}
}

+ (CGSize)cellSize {
    CGSize orig = %orig;
	if(enabled && twoByTwoIconEnabled){
		return CGSizeMake(orig.width * 1.5, orig.height);
	} else {return %orig;}
}

+ (CGSize)cellSpacing {
    CGSize orig = %orig;
    if(enabled && twoByTwoIconEnabled){
		return CGSizeMake(orig.width * 1.5, orig.height);
	} else {return %orig;}
}

%end 
%end

%group iconGrid13
%hook SBIconGridImage

-(NSUInteger)numberOfColumns {
	if(enabled && customFolderIconEnabled){
  		return folderIconColumns;
  	} else {return %orig;}
}

-(NSUInteger)numberOfCells {
	if(enabled && customFolderIconEnabled){
  		return (folderIconColumns*folderIconRows);
  	} else {return %orig;}
}

-(NSUInteger)numberOfRows {
	if(enabled && customFolderIconEnabled){	
  		return folderIconRows;
  	} else {return %orig;}
}
///

//Haha this next part is my genius method of stopping SpringBoard crashes!
//Ngl surprised my dumb self thought of this. :D
+(id)gridImageForLayout:(id)arg1 previousGridImage:(id)arg2 previousGridCellIndexToUpdate:(unsigned long long)arg3 pool:(id)arg4 cellImageDrawBlock:(id)arg5 {
  @try {
    return %orig;
  } @catch (NSException *exception) {
    return nil;
  }
}
+(id)gridImageForLayout:(id)arg1 cellImageDrawBlock:(id)arg2 {
  @try {
    return %orig;
  } @catch (NSException *exception) {
    return nil;
  }
}

+(id)gridImageForLayout:(id)arg1 pool:(id)arg2 cellImageDrawBlock:(id)arg3 {
  @try {
    return %orig;
  } @catch (NSException *exception) {
    return nil;
  }
}

%end
%end

%ctor{ // reloading prefs
	reloadPrefs();
	hasProcessLaunched = NO;
	hasInjectionFailed = NO;
    hasShownFailureAlert = NO;

	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)reloadPrefs, CFSTR("xyz.burritoz.thomz.folded.prefs/reload"), NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
	
	%init(SBFloatyFolderView);
	%init(SBFolderTitleTextField);
	%init(SBFolderBackgroundView);
	%init(SBFolderBackgroundMaterialSettings);
	if(kCFCoreFoundationVersionNumber < 1600){ 
		%init(pinchToClose12);
		%init(layout12);
		%init(iconGrid12);
	} else {
		%init(pinchToClose13);
		%init(layout13);
		%init(iconGrid13);
	}
}


//Well, that's all for now, folks! It's been awesome working with Thomz, I hope to make more tweaks with him!