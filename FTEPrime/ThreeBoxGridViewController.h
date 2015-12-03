//
//  ThreeBoxGridViewController.h
//  FTEPrime
//
//  Created by Sujith Achuthan on 8/27/15.
//  Copyright (c) 2015 Sujith Achuthan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EfficiencyIndicator.h"

@interface ThreeBoxGridViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet EfficiencyIndicator *firstBox;
@property (weak, nonatomic) IBOutlet EfficiencyIndicator *secondBox;
@property (weak, nonatomic) IBOutlet EfficiencyIndicator *thirdBox;

@property (strong)NSDictionary *components;

-(id)initWithItems:(NSDictionary*)component;
@end
