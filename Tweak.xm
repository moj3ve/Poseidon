// Enable home gestures
%hook BSPlatform
- (NSInteger)homeButtonType {
		return 2;
}
%end

// Hide home bar
%hook MTLumaDodgePillView
- (id)initWithFrame:(struct CGRect)arg1 {
	return NULL;
}
%end

// Hide Camera and Flashlight Button on Coversheet
%hook SBDashBoardQuickActionsViewController	
	-(BOOL)hasFlashlight{
		return NO;
		}
	-(BOOL)hasCamera{
		return NO;
}
%end

// Restore screenshot shortcut
%hook SpringBoard
- (void)applicationDidFinishLaunching:(id)arg1 {
	applicationDidFinishLaunching = 2;
	%orig;
}
%end
%hook SBPressGestureRecognizer
- (void)setAllowedPressTypes:(NSArray *)arg1 {
	NSArray * lockHome = @[@104, @101];
	NSArray * lockVol = @[@104, @102, @103];
	if ([arg1 isEqual:lockVol] && applicationDidFinishLaunching == 2) {
		%orig(lockHome);
		applicationDidFinishLaunching--;
		return;
	}
	%orig;
}
%end
%hook SBClickGestureRecognizer
- (void)addShortcutWithPressTypes:(id)arg1 {
	if (applicationDidFinishLaunching == 1) {
		applicationDidFinishLaunching--;
		return;
	}
	%orig;
}
%end
%hook SBHomeHardwareButton
- (id)initWithScreenshotGestureRecognizer:(id)arg1 homeButtonType:(long long)arg2 buttonActions:(id)arg3 gestureRecognizerConfiguration:(id)arg4 {
	return %orig(arg1, _homeButtonType, arg3, arg4);
}
- (id)initWithScreenshotGestureRecognizer:(id)arg1 homeButtonType:(long long)arg2 {
	return %orig(arg1, _homeButtonType);
}
%end
// Restore button to invoke Siri
%hook SBLockHardwareButtonActions
- (id)initWithHomeButtonType:(long long)arg1 proximitySensorManager:(id)arg2 {
	return %orig(_homeButtonType, arg2);
}
%end
%hook SBHomeHardwareButtonActions
- (id)initWitHomeButtonType:(long long)arg1 {
	return %orig(_homeButtonType);
}
%end

%hook MTLumaDodgePillView
- (id)initWithFrame:(struct CGRect)arg1 {
      return NULL;
}
%end
