//
//  Generated file. Do not edit.
//

#import "GeneratedPluginRegistrant.h"

#if __has_include(<launch_review/LaunchReviewPlugin.h>)
#import <launch_review/LaunchReviewPlugin.h>
#else
@import launch_review;
#endif

#if __has_include(<screenshot_share2/ScreenshotSharePlugin.h>)
#import <screenshot_share2/ScreenshotSharePlugin.h>
#else
@import screenshot_share2;
#endif

#if __has_include(<url_launcher/FLTURLLauncherPlugin.h>)
#import <url_launcher/FLTURLLauncherPlugin.h>
#else
@import url_launcher;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [LaunchReviewPlugin registerWithRegistrar:[registry registrarForPlugin:@"LaunchReviewPlugin"]];
  [ScreenshotSharePlugin registerWithRegistrar:[registry registrarForPlugin:@"ScreenshotSharePlugin"]];
  [FLTURLLauncherPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTURLLauncherPlugin"]];
}

@end
