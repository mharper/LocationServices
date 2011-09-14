//
//  LocationServicesAppDelegate.h
//  LocationServices
//
//  Created by Michael Harper on 9/1/11.
//  Copyright 2011 Standalone Code LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreMotion/CoreMotion.h>

@class LocationServicesViewController;

@interface LocationServicesAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) LocationServicesViewController *viewController;

@end
