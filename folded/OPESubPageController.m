#include "OPESubPageController.h"

@implementation OPESubPageController

NSDictionary *preferences;
BOOL customTitleFontSizeEnabled;
BOOL customTitleOffSetEnabled;
BOOL titleColorEnabled;
BOOL titleBackgroundEnabled;

- (void)setSpecifier:(PSSpecifier *)specifier {
    [self loadFromSpecifier:specifier];
    [super setSpecifier:specifier];
}

- (bool)shouldReloadSpecifiersOnResume {
    return false;
}



- (void)loadFromSpecifier:(PSSpecifier *)specifier {
	if (!_specifiers) {
		NSString *sub = [specifier propertyForKey:@"pageKey"];

		//NSString *contents = [NSString stringWithContentsOfFile:sub encoding:NSUTF8StringEncoding error:nil];

    	//NSArray *chosenLabels = [contents componentsSeparatedByString:@","];

		//NSArray *chosenLabels = @[@"customTitleFontSize", @"customTitleOffSet", @"titleColor", @"titleBackgroundColor", @"titleBackgroundCornerRadius"];

		_specifiers = [self loadSpecifiersFromPlistName:sub target:self];

		/*self.mySavedSpecifiers = (!self.mySavedSpecifiers) ? [[NSMutableDictionary alloc] init] : self.mySavedSpecifiers;
		for(PSSpecifier *specifier in [self specifiers]) {
			if([chosenLabels containsObject:[specifier propertyForKey:@"key"]]) {
			[self.mySavedSpecifiers setObject:specifier forKey:[specifier propertyForKey:@"key"]];
			}
		}*/
	}
}

- (void)viewWillAppear:(BOOL)animated {

	[[UISegmentedControl appearanceWhenContainedInInstancesOfClasses:@[self.class]] setTintColor:[UIColor colorWithRed:1.00 green:0.94 blue:0.27 alpha:1.0]];
    [[UISwitch appearanceWhenContainedInInstancesOfClasses:@[self.class]] setOnTintColor:[UIColor colorWithRed:1.00 green:0.94 blue:0.27 alpha:1.0]];
    [[UISlider appearanceWhenContainedInInstancesOfClasses:@[self.class]] setTintColor:[UIColor colorWithRed:1.00 green:0.94 blue:0.27 alpha:1.0]];

    [super viewWillAppear:animated];
}

-(void)viewDidLoad {
	[super viewDidLoad];
	//[self removeSegments];
	UIBarButtonItem *applyButton = [[UIBarButtonItem alloc] initWithTitle:@"Apply" style:UIBarButtonItemStylePlain target:self action:@selector(apply:)];
    self.navigationItem.rightBarButtonItem = applyButton;
}

-(void)reloadSpecifiers {
	//[self removeSegments];
}

-(void)apply:(PSSpecifier *)specifier {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
       CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR("xyz.burritoz.thomz.folded.prefs/reload"), nil, nil, true);
	   [self.view endEditing:YES]; //Hides the keyboard, if present // omg thank you that was so annoying lmao
         });
}

/*-(void)setPreferenceValue:(id)value specifier:(PSSpecifier *)specifier {
		[super setPreferenceValue:value specifier:specifier];

		preferences = [[NSUserDefaults standardUserDefaults]persistentDomainForName:@"xyz.burritoz.thomz.folded.prefs"];
		customTitleFontSizeEnabled = [[preferences objectForKey:@"customTitleFontSizeEnabled"] boolValue];
		customTitleOffSetEnabled = [[preferences objectForKey:@"customTitleOffSetEnabled"] boolValue];
		titleColorEnabled = [[preferences objectForKey:@"titleColorEnabled"] boolValue];
		titleBackgroundEnabled = [[preferences objectForKey:@"titleBackgroundEnabled"] boolValue];

		if(!customTitleFontSizeEnabled){
         	[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"customTitleFontSize"]] animated:YES];
		} else if(customTitleFontSizeEnabled && ![self containsSpecifier:self.mySavedSpecifiers[@"customTitleFontSize"]]) {
			[self insertContiguousSpecifiers:@[self.mySavedSpecifiers[@"customTitleFontSize"]] afterSpecifierID:@"Custom Title Font Size" animated:YES];
		}

		if(!customTitleOffSetEnabled){
         	[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"customTitleOffSet"]] animated:YES];
		} else if(customTitleOffSetEnabled && ![self containsSpecifier:self.mySavedSpecifiers[@"customTitleOffSet"]]) {
			[self insertContiguousSpecifiers:@[self.mySavedSpecifiers[@"customTitleOffSet"]] afterSpecifierID:@"Custom Title Offset" animated:YES];
		}

		if(!titleColorEnabled){
         	[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"titleColor"]] animated:YES];
		} else if(titleColorEnabled && ![self containsSpecifier:self.mySavedSpecifiers[@"titleColor"]]) {
			[self insertContiguousSpecifiers:@[self.mySavedSpecifiers[@"titleColor"]] afterSpecifierID:@"Custom Title Color" animated:YES];
		}

		if(!titleBackgroundEnabled){
         	[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"titleBackgroundColor"], self.mySavedSpecifiers[@"titleBackgroundCornerRadius"]] animated:YES];
		} else if(titleBackgroundEnabled && ![self containsSpecifier:self.mySavedSpecifiers[@"titleBackgroundColor"]] && ![self containsSpecifier:self.mySavedSpecifiers[@"titleBackgroundCornerRadius"]]) {
			[self insertContiguousSpecifiers:@[self.mySavedSpecifiers[@"titleBackgroundColor"], self.mySavedSpecifiers[@"titleBackgroundCornerRadius"]] afterSpecifierID:@"Title Background" animated:YES];
		}

}

-(void)removeSegments {
	preferences = [[NSUserDefaults standardUserDefaults]persistentDomainForName:@"xyz.burritoz.thomz.folded.prefs"];
	customTitleFontSizeEnabled = [[preferences objectForKey:@"customTitleFontSizeEnabled"] boolValue];
	customTitleOffSetEnabled = [[preferences objectForKey:@"customTitleOffSetEnabled"] boolValue];
	titleColorEnabled = [[preferences objectForKey:@"titleColorEnabled"] boolValue];
	titleBackgroundEnabled = [[preferences objectForKey:@"titleBackgroundEnabled"] boolValue];

	if(!customTitleFontSizeEnabled){
		[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"customTitleFontSize"]] animated:YES];
	}

	if(!customTitleOffSetEnabled){
		[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"customTitleOffSet"]] animated:YES];
	}

	if(!titleColorEnabled){
		[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"titleColor"]] animated:YES];
	}

	if(!titleBackgroundEnabled){
		[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"titleBackgroundColor"], self.mySavedSpecifiers[@"titleBackgroundCornerRadius"]] animated:YES];
	}

} */

@end
