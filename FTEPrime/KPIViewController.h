//
//  KPIViewController.h
//  FTEPrime
//
//  Created by Sujith Achuthan on 10/21/15.
//  Copyright © 2015 Sujith Achuthan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLPieChart.h"
#import <Charts/Charts-Swift.h>
#import "GridViewController.h"
#import "ThreeGridViewController.h"
#import "GraphViewController.h"
#import "CustomTableView.h"
#import "CopyImageViewController.h"


@interface KPIViewController : UIViewController <ChartViewDelegate>

@property (strong, nonatomic) UIScrollView *mainScrollView;
@property (strong, nonatomic) UIImageView *indicatorImageView;
@property (nonatomic, strong) BarChartView *ccEfficiencyGraphView;
@property (strong, nonatomic) NSDictionary *barProperty;;
@property (strong, nonatomic) GridViewController *wluInfoBoxView;
@property (strong, nonatomic) ThreeGridViewController *hoursBoxView;
@property (strong, nonatomic) ThreeGridViewController *resourcesBoxView;
@property (strong, nonatomic) GraphViewController *errorsPieChart;
@property (strong, nonatomic) LineChartView *errorLossLineChart;
@property (strong, nonatomic) LineChartView *ccLossLineChart;
@property (strong, nonatomic) LineChartView *resourcesLossLineChart;
@property (strong, nonatomic) CustomTableView *acuityTableView;
@property (nonatomic, strong) BarChartView *resourceSplitStackedChart;


@property(strong)CopyImageViewController *cpImageViewController;
@property(assign)CGPoint startTouch;
@property(assign)CGPoint endTouch;
@property (strong, atomic) ALAssetsLibrary* library;

- (IBAction)toggleValueIndicator:(id)sender;

@end
