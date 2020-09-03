//
//  ViewController.m
//  ImageGallery
//
//  Created by Gabriel Betancourt on 9/2/20.
//  Copyright © 2020 mau5atron. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (retain, readwrite) NSMutableArray *parsedImageNamesMut;
@end

@implementation ViewController
@synthesize parsedImageNamesMut;

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	imageIndex = 0;
	NSString *filePath = [[NSBundle mainBundle] pathForResource:@"imageNames" ofType:@"txt"];
	NSError *error;
	NSString *fileContents = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
	if (error){
		NSLog(@"Error reading file: %@", error.localizedDescription);
	}
	
	// NSLog(@"File contents: \n%@", [fileContents componentsSeparatedByString:@"\n"]);
	// NSMutableArray *imageNamesMut = [(NSMutableArray *)fileContents mutableCopy];
	NSMutableArray *imageNamesMut = (NSMutableArray*)[fileContents componentsSeparatedByString:@"\n"];
	[imageNamesMut removeObjectsInArray:@[@"", @" "]]; // remove empty strings
	 self.parsedImageNamesMut = [NSMutableArray arrayWithCapacity:[imageNamesMut count]];
	
	// somehow this was being nulled once viewDidLoad was out of scope
	// NSMutableArray *parsedImageNamesMut = [[NSMutableArray alloc] initWithCapacity:[imageNamesMut count]];
	for ( int i = 0; i < [imageNamesMut count] ; i++ ) {
		parsedImageNamesMut[i] = [imageNamesMut[i] componentsSeparatedByString:@"/"][3];
		parsedImageNamesMut[i] = [parsedImageNamesMut[i] componentsSeparatedByString:@"."][0];
		NSLog(@"Separated by string: %@", parsedImageNamesMut[i]);
	}

	self.imgCountOutlet.text = [NSString stringWithFormat:@"%u/%lu", imageIndex + 1, (unsigned long)[parsedImageNamesMut count]];
	// start with image at index 0
	self.galleryImageViewOutlet.image = [UIImage imageNamed:self.parsedImageNamesMut[imageIndex]];
	[self setButtonStyling:[self backBtnOutlet] :0.5f :FALSE];
	NSLog(@"Initial imgindex: %i", imageIndex);
}

- (IBAction)nextImage:(id)sender {
	//	NSLog(@"%i", imageIndex);
	//	NSLog(@"%lu", [self.parsedImageNamesMut count]); // need to figure out why this is null - no longer null
	NSLog(@"imgindex before increment: %i", imageIndex);
	if (imageIndex < ([self.parsedImageNamesMut count] - 1)){
		NSLog(@"inside incrementing");
		imageIndex++;
		self.imgCountOutlet.text = [NSString stringWithFormat:@"%u/%lu", imageIndex + 1, (unsigned long)[parsedImageNamesMut count]];
		self.galleryImageViewOutlet.image = [UIImage imageNamed:self.parsedImageNamesMut[imageIndex]];
		self.backBtnOutlet.alpha = 1.0f;
		self.backBtnOutlet.enabled = TRUE;
		NSLog(@"imgindex incremented: %i", imageIndex);
		if ( imageIndex == ([self.parsedImageNamesMut count] - 1) ){
			[self setButtonStyling:[self nextBtnOutlet] :0.5f :FALSE];
		}
		[self setButtonStyling:[self backBtnOutlet] :1.0f :TRUE];
	} else {
		NSLog(@"Ended increment");
	}
}

- (IBAction)previousImage:(id)sender {
	NSLog(@"image index before decrement: %i", imageIndex);

	if ( imageIndex > 0 ){
		NSLog(@"inside decrementing");
		imageIndex--;
		self.imgCountOutlet.text = [NSString stringWithFormat:@"%u/%lu", imageIndex + 1, (unsigned long)[parsedImageNamesMut count]];
		self.galleryImageViewOutlet.image = [UIImage imageNamed:self.parsedImageNamesMut[imageIndex]];
		NSLog(@"imgindex decremented: %i", imageIndex);
		if ( imageIndex == 0 ){
			[self setButtonStyling:[self backBtnOutlet] :0.5f :FALSE];
		}
		
		[self setButtonStyling:[self nextBtnOutlet] :1.0f :TRUE];
	} else {
		NSLog(@"Ended decrement");
	}
}

- (void)setButtonStyling :(UIButton *)navBtn :(double)btnAlpha :(BOOL)btnEnabled {
	navBtn.alpha = btnAlpha;
	navBtn.enabled = btnEnabled;
}

@end
