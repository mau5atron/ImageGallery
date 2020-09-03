//
//  ViewController.h
//  ImageGallery
//
//  Created by Gabriel Betancourt on 9/2/20.
//  Copyright © 2020 mau5atron. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {
	unsigned int imageIndex;
}

@property (weak, nonatomic) IBOutlet UIImageView *galleryImageViewOutlet;
@property (weak, nonatomic) IBOutlet UIButton *backBtnOutlet;
@property (weak, nonatomic) IBOutlet UIButton *nextBtnOutlet;
@property (weak, nonatomic) IBOutlet UILabel *imgCountOutlet;
@property (retain, readonly) NSMutableArray *parsedImageNamesMut;

- (IBAction)nextImage:(id)sender;
- (IBAction)previousImage:(id)sender;
- (void)setButtonStyling :(UIButton *)navBtn :(double)btnAlpha :(BOOL)btnEnabled;

@end

