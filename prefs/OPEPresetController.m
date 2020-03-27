#include "OPEPresetController.m"

@implementation OPEPresetController

- (void)setSpecifier:(PSSpecifier *)specifier {
    [self loadFromSpecifier:specifier];
    [super setSpecifier:specifier];
}

- (void)loadFromSpecifier:(PSSpecifier *)specifier {
	if (!_specifiers) {

		_specifiers = [self loadSpecifiersFromPlistName:Presets target:self];

	}
}

- (void)viewWillAppear:(BOOL)animated {

	[[UISegmentedControl appearanceWhenContainedInInstancesOfClasses:@[self.class]] setTintColor:[UIColor colorWithRed:0.00 green:0.54 blue:1.00 alpha:1.00]];
    [[UISwitch appearanceWhenContainedInInstancesOfClasses:@[self.class]] setOnTintColor:[UIColor colorWithRed:0.00 green:0.54 blue:1.00 alpha:1.00]];
    [[UISlider appearanceWhenContainedInInstancesOfClasses:@[self.class]] setTintColor:[UIColor colorWithRed:0.00 green:0.54 blue:1.00 alpha:1.00]];

    [super viewWillAppear:animated];
}

-(void)applyPreset:(PSSpecifier *)specifier {
    desiredPreset = [specifier propertyForKey:@"presetName"];

	UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Apply Preset"
							message:@"Are you sure you want to apply this preset? This action CANNOT be undone! Your device will respring."
							preferredStyle:UIAlertControllerStyleAlert];

		UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault
		handler:^(UIAlertAction * action) {}];
		UIAlertAction* yes = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDestructive
		handler:^(UIAlertAction * action) {
            NSTask *t3 = [[NSTask alloc] init];
			[t3 setLaunchPath:@"usr/bin/killall"];
			[t3 setArguments:[NSArray arrayWithObjects:@"-u $USER cfprefsd", nil]];
			[t3 launch];
			NSTask *t = [[NSTask alloc] init];
			[t setLaunchPath:@"/bin/rm"];
			[t setArguments:[NSArray arrayWithObjects:@"/var/mobile/Library/Preferences/xyz.burritoz.thomz.folded.prefs.plist", nil]];
			[t launch];

			//COPY NEW PLIST HERE


			NSTask *t2 = [[NSTask alloc] init];
			[t2 setLaunchPath:@"usr/bin/killall"];
			[t2 setArguments:[NSArray arrayWithObjects:@"backboardd", nil]];
			[t2 launch];
		}];

		[alert addAction:defaultAction];
		[alert addAction:yes];
		[self presentViewController:alert animated:YES completion:nil];
}

@end