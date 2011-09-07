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
@synthesize currentLocation;
@synthesize currentHeading;

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
  NSLog(@"didChangeAuthorizationStatus called with status %d", status);
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
  latitudeLabel.text = [NSString stringWithFormat:@"%f", newLocation.coordinate.latitude];
  longitudeLabel.text = [NSString stringWithFormat:@"%f", newLocation.coordinate.longitude];
  altitudeLabel.text = [NSString stringWithFormat:@"%f", newLocation.altitude];
  }
  else if ([keyPath isEqualToString:@"currentHeading"])
  {
    CLHeading *newHeading = [change objectForKey:NSKeyValueChangeNewKey];
    headingLabel.text = [NSString stringWithFormat:@"%f", newHeading.magneticHeading];
  }
}

@end
