//
//  EfficiencyTableViewController.h
//  FTEPrime
//
//  Created by Sujith Achuthan on 8/28/15.
//  Copyright (c) 2015 Sujith Achuthan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EfficiencyTableViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *eFeFLabel;
@property (weak, nonatomic) IBOutlet UILabel *efFteLabel;
@property (weak, nonatomic) IBOutlet UILabel *efProdLabel;
@property (weak, nonatomic) IBOutlet UILabel *fteEfLabel;
@property (weak, nonatomic) IBOutlet UILabel *fteFteLabel;
@property (weak, nonatomic) IBOutlet UILabel *fteProdLabel;
@property (weak, nonatomic) IBOutlet UILabel *prodEfLabel;
@property (weak, nonatomic) IBOutlet UILabel *prodFteLabel;
@property (weak, nonatomic) IBOutlet UILabel *prodProdLabel;

@property (strong, nonatomic)NSDictionary* componentValues;

-(id)initWithItems:(NSDictionary*)component;

@end
