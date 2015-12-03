//
//  CopyImageViewController.m
//  FTEPrime
//
//  Created by Sujith Achuthan on 10/12/15.
//  Copyright © 2015 Sujith Achuthan. All rights reserved.
//

#import "CopyImageViewController.h"

@interface CopyImageViewController ()

@end

@implementation CopyImageViewController

-(id)initWithImage:(UIImage*)image
{
    
    self = [super init];
    if( !self )
    {
        return nil;
    }
    
    _displayImage = image;
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.imageView setImage:self.displayImage];
    [(UIView *)self.view layer].shadowOpacity = 0.8;
    [(UIView *)self.view layer].shadowOffset = CGSizeMake(0.0f, 0.0f);
//    [self.imageView sizeToFit];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
