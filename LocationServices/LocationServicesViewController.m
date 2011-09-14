//
//  LocationServicesViewController.m
//  LocationServices
//
//  Created by Michael Harper on 9/1/11.
//  Copyright 2011 Standalone Code LLC. All rights reserved.
//

#import "LocationServicesViewController.h"

@implementation LocationServicesViewController

@synthesize latitudeLabel;
@synthesize longitudeLabel;
@synthesize headingLabel;
@synthesize altitudeLabel;
@synthesize hAccLabel;
@synthesize vAccLabel;
@synthesize lsLabel;
@synthesize currentLocation;
@synthesize currentHeading;
@synthesize degreesFormatter;
@synthesize distanceFormatter;
@synthesize pitchLabel;
@synthesize rollLabel;
@synthesize yawLabel;

#pragma mark - View lifecycle

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self addObserver:self forKeyPath:@"currentLocation" options:NSKeyValueObservingOptionNew context:nil];
  [self addObserver:self forKeyPath:@"currentHeading" options:NSKeyValueObservingOptionNew context:nil];
  self.degreesFormatter = [[NSNumberFormatter alloc] init];
  degreesFormatter.minimumIntegerDigits = 1;
  degreesFormatter.maximumFractionDigits = 6;
  self.distanceFormatter = [[NSNumberFormatter alloc] init];
  distanceFormatter.minimumIntegerDigits = 1;
  distanceFormatter.maximumFractionDigits = 1;
}

- (void)viewDidUnload
{
  [self removeObserver:self forKeyPath:@"currentLocation"];
  [self removeObserver:self forKeyPath:@"currentHeading"];
  [self setLatitudeLabel:nil];
  [self setLongitudeLabel:nil];
  [self setHeadingLabel:nil];
  [self setAltitudeLabel:nil];
  [self setHAccLabel:nil];
  [self setVAccLabel:nil];
  [self setLsLabel:nil];
  [self setPitchLabel:nil];
  [self setRollLabel:nil];
  [self setYawLabel:nil];
  [self setDegreesFormatter:nil];
  [self setDistanceFormatter:nil];
  [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark CLLocationManagerDelegate methods

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
  NSString *lsStatus = @"";
  switch (status)
  {
    case kCLAuthorizationStatusNotDetermined:
      lsStatus = @"Undetermined";
      break;
      
    case kCLAuthorizationStatusRestricted:
      lsStatus = @"Restricted";
      break;
      
    case kCLAuthorizationStatusDenied:
      lsStatus = @"Denied";
      break;
      
    case kCLAuthorizationStatusAuthorized:
      lsStatus = @"Authorized";
      break;
      
    default:
      break;
  }
  lsLabel.text = lsStatus;
}

-(void) locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
  if (newLocation.horizontalAccuracy > 0)
  {
    self.currentLocation = newLocation;    
  }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
  if (newHeading.headingAccuracy > 0)
  {
    self.currentHeading = newHeading;
  }
}

-(void) updateMotionInfo:(CMDeviceMotion *) motionInfo
{
  NSNumber *number = [NSNumber alloc];
  pitchLabel.text = [degreesFormatter stringFromNumber:[number initWithDouble:radiansToDegrees(motionInfo.attitude.pitch)]];
  rollLabel.text = [degreesFormatter stringFromNumber:[number initWithDouble:radiansToDegrees(motionInfo.attitude.roll)]];
  yawLabel.text = [degreesFormatter stringFromNumber:[number initWithDouble:radiansToDegrees(motionInfo.attitude.yaw)]];
}

#pragma mark KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
  NSNumber *number = [NSNumber alloc];
  if ([keyPath isEqualToString:@"currentLocation"])
  {
    CLLocation *newLocation = [change objectForKey:NSKeyValueChangeNewKey];
    latitudeLabel.text = [degreesFormatter stringFromNumber:[number initWithFloat:newLocation.coordinate.latitude]];
    longitudeLabel.text = [degreesFormatter stringFromNumber:[number initWithFloat:newLocation.coordinate.longitude]];
    altitudeLabel.text = [distanceFormatter stringFromNumber:[number initWithFloat:newLocation.altitude]];
    hAccLabel.text = [distanceFormatter stringFromNumber:[number initWithFloat:newLocation.horizontalAccuracy]];
    vAccLabel.text = [distanceFormatter stringFromNumber:[number initWithFloat:newLocation.verticalAccuracy]];
  }
  else if ([keyPath isEqualToString:@"currentHeading"])
  {
    CLHeading *newHeading = [change objectForKey:NSKeyValueChangeNewKey];
    headingLabel.text = [degreesFormatter stringFromNumber:[number initWithFloat:newHeading.magneticHeading]];
  }
}

@end
