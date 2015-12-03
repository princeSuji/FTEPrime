//
//  GraphViewController.h
//  FTEPrime
//
//  Created by Sujith Achuthan on 10/9/15.
//  Copyright © 2015 Sujith Achuthan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLPieChart.h"

@interface GraphViewController : UIViewController <DLPieChartDelegate>
@property (weak, nonatomic) IBOutlet DLPieChart *graphView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong)NSMutableArray *data;
@property (strong)NSMutableArray *colors;
@property (strong)NSMutableArray *legends;
@property (strong)NSString *labelString;

-(id)initWithItems:(NSDictionary*)component;

@end
