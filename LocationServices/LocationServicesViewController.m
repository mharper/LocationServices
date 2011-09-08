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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
  [self addObserver:self forKeyPath:@"currentLocation" options:NSKeyValueObservingOptionNew context:nil];
  [self addObserver:self forKeyPath:@"currentHeading" options:NSKeyValueObservingOptionNew context:nil];
  self.degreesFormatter = [[NSNumberFormatter alloc] init];
  degreesFormatter.maximumFractionDigits = 6;
  self.distanceFormatter = [[NSNumberFormatter alloc] init];
  distanceFormatter.maximumFractionDigits = 1;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
      return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
  } else {
      return YES;
  }
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
  self.currentLocation = newLocation;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
  self.currentHeading = newHeading;
}

#pragma mark KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
  if ([keyPath isEqualToString:@"currentLocation"])
  {
    CLLocation *newLocation = [change objectForKey:NSKeyValueChangeNewKey];
    latitudeLabel.text = [degreesFormatter stringFromNumber:[NSNumber numberWithFloat:newLocation.coordinate.latitude]];
    longitudeLabel.text = [degreesFormatter stringFromNumber:[NSNumber numberWithFloat:newLocation.coordinate.longitude]];
    altitudeLabel.text = [distanceFormatter stringFromNumber:[NSNumber numberWithFloat:newLocation.altitude]];
    hAccLabel.text = [distanceFormatter stringFromNumber:[NSNumber numberWithFloat:newLocation.horizontalAccuracy]];
    vAccLabel.text = [distanceFormatter stringFromNumber:[NSNumber numberWithFloat:newLocation.verticalAccuracy]];
  }
  else if ([keyPath isEqualToString:@"currentHeading"])
  {
    CLHeading *newHeading = [change objectForKey:NSKeyValueChangeNewKey];
    headingLabel.text = [degreesFormatter stringFromNumber:[NSNumber numberWithFloat:newHeading.magneticHeading]];
  }
}

@end
