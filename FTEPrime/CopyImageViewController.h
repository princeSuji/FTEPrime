//
//  CopyImageViewController.h
//  FTEPrime
//
//  Created by Sujith Achuthan on 10/12/15.
//  Copyright © 2015 Sujith Achuthan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CopyImageViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *cpButton;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (strong, nonatomic)UIImage *displayImage;

-(id)initWithImage:(UIImage*)image;
@end
