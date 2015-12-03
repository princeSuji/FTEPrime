//
//  KPIViewController.m
//  FTEPrime
//
//  Created by Sujith Achuthan on 10/21/15.
//  Copyright © 2015 Sujith Achuthan. All rights reserved.
//

#import "KPIViewController.h"
#import "CorePlot-CocoaTouch.h"

@interface KPIViewController ()

@end

@implementation KPIViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    NSString *file = [[NSString alloc] initWithContentsOfFile:@"data.csv" encoding:NSASCIIStringEncoding error:NULL];
//    NSArray *allLines = [file componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
//    for (NSString* line in allLines) {
////         NSArray *elements = [line componentsSeparatedByString:@","];
//         // Elements now contains all the data from 1 csv line
//         // Use data from line (see step 4)
//     }
    self.library = [[ALAssetsLibrary alloc] init];
    
    UITapGestureRecognizer *doubleTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected:)];
    doubleTap.numberOfTapsRequired = 2;
    doubleTap.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:doubleTap];
    
    NSInteger xPoint = 8;
    NSInteger yPoint = 8;
    
    self.mainScrollView = [[UIScrollView alloc] init];
    self.mainScrollView.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height);
    self.mainScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.mainScrollView];
    self.view.backgroundColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:.1];
    self.mainScrollView.backgroundColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:.1];
    
    UILabel *efficiencyLabel = [[UILabel alloc] initWithFrame:CGRectMake(xPoint, yPoint, 110, 21)];
    efficiencyLabel.text = @"Efficiency";
    [self.mainScrollView addSubview:efficiencyLabel];
    
    yPoint = yPoint + efficiencyLabel.frame.size.height + 12;
    
    self.indicatorImageView = [[UIImageView alloc] initWithFrame:CGRectMake(xPoint, yPoint, 150,300)];
    self.indicatorImageView.image = [UIImage imageNamed:@"EfficiencyIndicator.png"];
    [self.mainScrollView addSubview:self.indicatorImageView];
    
    xPoint = xPoint + self.indicatorImageView.frame.size.width + 8;
    
    UIView *borderLine0 = [[UIView alloc] initWithFrame:CGRectMake(xPoint-4, 0, 1, 1000)];
    borderLine0.backgroundColor = [UIColor blackColor];
    [self.mainScrollView addSubview:borderLine0];
    
    yPoint = 8;
    
    UILabel *ccEfficiencyExplanationLabel = [[UILabel alloc] initWithFrame:CGRectMake(xPoint, yPoint, 430, 23)];
    ccEfficiencyExplanationLabel.text = @"Efficiency of Each Cost Center";
    ccEfficiencyExplanationLabel.textAlignment = NSTextAlignmentCenter;
    ccEfficiencyExplanationLabel.backgroundColor = [UIColor colorWithRed:60/255.f green:170/255.f blue:134/255.f alpha:1];
    ccEfficiencyExplanationLabel.textColor = [UIColor whiteColor];
    [self.mainScrollView addSubview:ccEfficiencyExplanationLabel];
    yPoint += 31;
    
    self.ccEfficiencyGraphView = [[BarChartView alloc] initWithFrame:CGRectMake(xPoint, yPoint, 430,290)];
    self.ccEfficiencyGraphView.descriptionText = @"";
    self.ccEfficiencyGraphView.delegate = self;
    [self.mainScrollView addSubview:self.ccEfficiencyGraphView];
    
    ChartXAxis *xAxis = self.ccEfficiencyGraphView.xAxis;
    xAxis.labelPosition = XAxisLabelPositionBottom;
    xAxis.spaceBetweenLabels = 0.0;
    xAxis.drawGridLinesEnabled = NO;
    
    [self setDataCount:5 range:150];
    
    //Respective toggle
    yPoint = yPoint + self.ccEfficiencyGraphView.frame.size.height + 16;
    UILabel *ccEfficiencyToggleLabel = [[UILabel alloc] initWithFrame:CGRectMake(xPoint+5, yPoint, 110, 21)];
    ccEfficiencyToggleLabel.text = @"Show Values";
    [self.mainScrollView addSubview:ccEfficiencyToggleLabel];
    
    UISwitch *ccEfficiencyGraphToggle = [[UISwitch alloc] initWithFrame:CGRectMake(xPoint + 118, yPoint, 50, 21)];
    ccEfficiencyGraphToggle.tag = 1;
    [ccEfficiencyGraphToggle setOn:YES];
    [ccEfficiencyGraphToggle addTarget:self action:@selector(toggleValueIndicator:) forControlEvents:UIControlEventValueChanged];
    [self.mainScrollView addSubview:ccEfficiencyGraphToggle];
    
    yPoint = yPoint + 37;
    
    UILabel *ccLossExplanationLabel = [[UILabel alloc] initWithFrame:CGRectMake(xPoint, yPoint, 430, 23)];
    ccLossExplanationLabel.text = @"Loss Incurred in Million Dollars";
    ccLossExplanationLabel.textAlignment = NSTextAlignmentCenter;
    ccLossExplanationLabel.backgroundColor = [UIColor colorWithRed:60/255.f green:170/255.f blue:134/255.f alpha:1];
    ccLossExplanationLabel.textColor = [UIColor whiteColor];
    [self.mainScrollView addSubview:ccLossExplanationLabel];
    
    yPoint += 31;
    
    //CC Loss Chart
    
    self.ccLossLineChart = [[LineChartView alloc] initWithFrame:CGRectMake(xPoint, yPoint, 430, 290)];
    
    self.ccLossLineChart.descriptionText = @"";
    self.ccLossLineChart.noDataTextDescription = @"You need to provide data for the chart.";
    
    self.ccLossLineChart.dragEnabled = YES;
    [self.ccLossLineChart setScaleEnabled:YES];
    self.ccLossLineChart.drawGridBackgroundEnabled = NO;
    self.ccLossLineChart.pinchZoomEnabled = YES;
    self.ccLossLineChart.rightAxis.enabled = NO;
    
    self.ccLossLineChart.backgroundColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:.005];
    
    self.ccLossLineChart.legend.form = ChartLegendFormLine;
    self.ccLossLineChart.legend.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.f];
    self.ccLossLineChart.legend.textColor = UIColor.blackColor;
    self.ccLossLineChart.legend.position = ChartLegendPositionBelowChartLeft;
    
    [self setDataCountCCLossLineChart:10 range:10];
    
    [self.mainScrollView addSubview:self.ccLossLineChart];
    
    //Respective toggle
    yPoint = yPoint + self.ccLossLineChart.frame.size.height + 16;
    UILabel *ccLossToggleLabel = [[UILabel alloc] initWithFrame:CGRectMake(xPoint+5, yPoint, 110, 21)];
    ccLossToggleLabel.text = @"Show Values";
    [self.mainScrollView addSubview:ccLossToggleLabel];
    
    UISwitch *ccLossGraphToggle = [[UISwitch alloc] initWithFrame:CGRectMake(xPoint + 118, yPoint, 50, 21)];
    ccLossGraphToggle.tag = 2;
    [ccLossGraphToggle setOn:YES];
    [ccLossGraphToggle addTarget:self action:@selector(toggleValueIndicator:) forControlEvents:UIControlEventValueChanged];
    [self.mainScrollView addSubview:ccLossGraphToggle];
    
    xPoint = xPoint + self.ccEfficiencyGraphView.frame.size.width + 8;
    yPoint = 8;
    
    UIView *borderLine1 = [[UIView alloc] initWithFrame:CGRectMake(xPoint-4, 0, 1, 1000)];
    borderLine1.backgroundColor = [UIColor blackColor];
    [self.mainScrollView addSubview:borderLine1];
    
    //WLU Box
    NSArray *keys = @[@"Expected WLU",@"Actual WLU"];
    NSDictionary *wluDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:@"WLU Analysis",@"Label",@"10",@"Expected WLU",@"15", @"Actual WLU", nil];
    self.wluInfoBoxView = [[GridViewController alloc] initWithItems:wluDictionary andKeys:keys];
    
    self.wluInfoBoxView.view.frame = CGRectMake(xPoint, yPoint,self.wluInfoBoxView.view.frame.size.width,self.wluInfoBoxView.view.frame.size.height);
    self.wluInfoBoxView.view.backgroundColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:.1];
    
    self.wluInfoBoxView.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    // Round cell corners
    self.wluInfoBoxView.view.layer.cornerRadius = 10;
    
    // Add shadow
    self.wluInfoBoxView.view.layer.masksToBounds = NO;
    self.wluInfoBoxView.view.layer.shadowOpacity = 0.75f;
    self.wluInfoBoxView.view.layer.shadowRadius = 10.0f;
    self.wluInfoBoxView.view.layer.shouldRasterize = NO;
    self.wluInfoBoxView.view.layer.shadowPath = [UIBezierPath bezierPathWithRect:CGRectMake(self.wluInfoBoxView.view.frame.size.width/2 - (self.wluInfoBoxView.view.frame.size.width)/2, self.wluInfoBoxView.view.frame.size.height, self.wluInfoBoxView.view.frame.size.width, 10)].CGPath;
    
    [self.mainScrollView addSubview:self.wluInfoBoxView.view];
    
    yPoint = yPoint + self.wluInfoBoxView.view.frame.size.height + 8;
    
    //Hours Box
    NSArray *hrsKeys = @[@"Expected Hours",@"Actual Hours Required", @"Actual Hours Incurred"];
    NSDictionary *hrsDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:@"Hours Analysis",@"Label",@"100",@"Expected Hours",@"150", @"Actual Hours Required", @"175",@"Actual Hours Incurred", nil];
    self.hoursBoxView = [[ThreeGridViewController alloc] initWithItems:hrsDictionary andKeys:hrsKeys];
    
    self.hoursBoxView.view.frame = CGRectMake(xPoint,yPoint,self.hoursBoxView.view.frame.size.width,self.hoursBoxView.view.frame.size.height);
    self.hoursBoxView.view.backgroundColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:.1];
    
    self.hoursBoxView.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    // Round cell corners
    self.hoursBoxView.view.layer.cornerRadius = 10;
    
    // Add shadow
    self.hoursBoxView.view.layer.masksToBounds = NO;
    self.hoursBoxView.view.layer.shadowOpacity = 0.75f;
    self.hoursBoxView.view.layer.shadowRadius = 10.0f;
    self.hoursBoxView.view.layer.shouldRasterize = NO;
    self.hoursBoxView.view.layer.shadowPath = [UIBezierPath bezierPathWithRect:CGRectMake(self.hoursBoxView.view.frame.size.width/2 - (self.hoursBoxView.view.frame.size.width)/2, self.hoursBoxView.view.frame.size.height, self.hoursBoxView.view.frame.size.width, 10)].CGPath;
    
    [self.mainScrollView addSubview:self.hoursBoxView.view];
    
    yPoint = yPoint + self.hoursBoxView.view.frame.size.height + 8;
    
    //Resources
    NSArray *resourcesKeys = @[@"Required Resources",@"Scheduled Resources", @"Reported Resources"];
    NSDictionary *resourcesDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:@"Resources Analysis",@"Label",@"10",@"Required Resources",@"12", @"Scheduled Resources", @"18",@"Reported Resources", nil];
    self.resourcesBoxView = [[ThreeGridViewController alloc] initWithItems:resourcesDictionary andKeys:resourcesKeys];
    
    self.resourcesBoxView.view.frame = CGRectMake(xPoint,yPoint,self.resourcesBoxView.view.frame.size.width,self.resourcesBoxView.view.frame.size.height);
    self.resourcesBoxView.view.backgroundColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:.1];
    
    self.resourcesBoxView.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    // Round cell corners
    self.resourcesBoxView.view.layer.cornerRadius = 10;
    
    // Add shadow
    self.resourcesBoxView.view.layer.masksToBounds = NO;
    self.resourcesBoxView.view.layer.shadowOpacity = 0.75f;
    self.resourcesBoxView.view.layer.shadowRadius = 10.0f;
    self.resourcesBoxView.view.layer.shouldRasterize = NO;
    self.resourcesBoxView.view.layer.shadowPath = [UIBezierPath bezierPathWithRect:CGRectMake(self.resourcesBoxView.view.frame.size.width/2 - (self.resourcesBoxView.view.frame.size.width)/2, self.resourcesBoxView.view.frame.size.height, self.resourcesBoxView.view.frame.size.width, 10)].CGPath;
    
    [self.mainScrollView addSubview:self.resourcesBoxView.view];
    
    yPoint = yPoint + self.resourcesBoxView.view.frame.size.height + 8;
    
    //Acuity Table
    NSArray *rowTitles = @[@"Acuity",@"Expected Patients Count",@"Actual Patients Count"];
    NSArray *colTitles = @[@"1",@"2",@"3",@"4",@"5"];
    NSArray *data = @[@[@"3",@"3",@"2",@"1",@"1"],
                      @[@"5",@"5",@"3",@"2",@"0"]];
    
    NSDictionary *acuityDataDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:rowTitles,@"rowTitles",colTitles,@"columnTitles",data,@"data", nil];
    self.acuityTableView = [[CustomTableView alloc] initWithValues:acuityDataDictionary];
    [self.acuityTableView startDrawing];
    self.acuityTableView.frame = CGRectMake(xPoint, yPoint, self.acuityTableView.frame.size.width, self.acuityTableView.frame.size.height);
    
    [self.mainScrollView addSubview:self.acuityTableView];
    
    yPoint = 8;
    
    xPoint = xPoint + MAX(self.hoursBoxView.view.frame.size.width,self.acuityTableView.frame.size.width) + 8;
    
    UIView *borderLine2 = [[UIView alloc] initWithFrame:CGRectMake(xPoint-4, 0, 1, 1000)];
    borderLine2.backgroundColor = [UIColor blackColor];
    [self.mainScrollView addSubview:borderLine2];
    
    //Error Pie Chart
    NSArray *errorsArray = @[@"50",@"10",@"15"];
    NSArray *titleArray = @[@"Difference In WLU", @"Wrong Aquity", @"Managerial"];
    
    NSDictionary *errorsDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:@"Error Analysis",@"Label",errorsArray,@"Qty",titleArray, @"Title", nil];
    
    self.errorsPieChart = [[GraphViewController alloc] initWithItems:errorsDictionary];
    
    self.errorsPieChart.view.frame = CGRectMake(xPoint, yPoint,self.errorsPieChart.view.frame.size.width,self.errorsPieChart.view.frame.size.height);
    self.errorsPieChart.view.backgroundColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:.001];
    
    [self.mainScrollView addSubview:self.errorsPieChart.view];
    
    yPoint = yPoint + self.errorsPieChart.view.frame.size.height + 12;
    
    //Resource Split stacked chart
    
    UILabel *resourceSplitExplanationLabel = [[UILabel alloc] initWithFrame:CGRectMake(xPoint, yPoint, self.errorsPieChart.view.frame.size.width, 23)];
    resourceSplitExplanationLabel.text = @"Hours Splitup of Resources";
    resourceSplitExplanationLabel.textAlignment = NSTextAlignmentCenter;
    resourceSplitExplanationLabel.backgroundColor = [UIColor colorWithRed:60/255.f green:170/255.f blue:134/255.f alpha:1];
    resourceSplitExplanationLabel.textColor = [UIColor whiteColor];
    [self.mainScrollView addSubview:resourceSplitExplanationLabel];
    
    yPoint += 31;
    
    self.resourceSplitStackedChart = [[BarChartView alloc] initWithFrame:CGRectMake(xPoint, yPoint,self.errorsPieChart.view.frame.size.width,self.errorsPieChart.view.frame.size.height)];
    self.resourceSplitStackedChart.noDataTextDescription = @"You need to provide data for the chart.";
    
    self.resourceSplitStackedChart.maxVisibleValueCount = 60;
    self.resourceSplitStackedChart.pinchZoomEnabled = NO;
    self.resourceSplitStackedChart.drawGridBackgroundEnabled = NO;
    self.resourceSplitStackedChart.drawBarShadowEnabled = NO;
    self.resourceSplitStackedChart.drawValueAboveBarEnabled = NO;
    
    ChartYAxis *leftAxis = self.resourceSplitStackedChart.leftAxis;
    leftAxis.valueFormatter = [[NSNumberFormatter alloc] init];
    leftAxis.valueFormatter.maximumFractionDigits = 1;
    leftAxis.valueFormatter.negativeSuffix = @" $";
    leftAxis.valueFormatter.positiveSuffix = @" $";
    
    self.resourceSplitStackedChart.rightAxis.enabled = NO;
    
    ChartXAxis *resourcesXAxis = self.resourceSplitStackedChart.xAxis;
    resourcesXAxis.labelPosition = XAxisLabelPositionTop;
    
    ChartLegend *l = self.resourceSplitStackedChart.legend;
    l.position = ChartLegendPositionBelowChartRight;
    l.form = ChartLegendFormSquare;
    l.formSize = 8.0;
    l.formToTextSpace = 4.0;
    l.xEntrySpace = 6.0;
    
    self.resourceSplitStackedChart.backgroundColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:.001];
    
    [self setDataCountForResourceStackChart:4 range:50];
    self.resourceSplitStackedChart.descriptionText = @"";
    
    [self.mainScrollView addSubview:self.resourceSplitStackedChart];
    
    //Respective toggle
    yPoint = yPoint + self.resourceSplitStackedChart.frame.size.height + 16;
    UILabel *resourceSplitToggleLabel = [[UILabel alloc] initWithFrame:CGRectMake(xPoint+5, yPoint, 110, 21)];
    resourceSplitToggleLabel.text = @"Show Values";
    [self.mainScrollView addSubview:resourceSplitToggleLabel];
    
    UISwitch *resourceSplitToggle = [[UISwitch alloc] initWithFrame:CGRectMake(xPoint + 118, yPoint, 50, 21)];
    resourceSplitToggle.tag = 3;
    [resourceSplitToggle setOn:YES];
    [resourceSplitToggle addTarget:self action:@selector(toggleValueIndicator:) forControlEvents:UIControlEventValueChanged];
    [self.mainScrollView addSubview:resourceSplitToggle];
    
    yPoint = 8;
    
    xPoint = xPoint + self.errorsPieChart.view.frame.size.width + 8;
    
    UIView *borderLine3 = [[UIView alloc] initWithFrame:CGRectMake(xPoint-4, 0, 1, 1000)];
    borderLine3.backgroundColor = [UIColor blackColor];
    [self.mainScrollView addSubview:borderLine3];
    
    //Errors Loss Line Chart
    
    UILabel *errorLossExplanationLabel = [[UILabel alloc] initWithFrame:CGRectMake(xPoint, yPoint, 430, 23)];
    errorLossExplanationLabel.text = @"Loss Due to Each Error in Million Dollars";
    errorLossExplanationLabel.textAlignment = NSTextAlignmentCenter;
    errorLossExplanationLabel.backgroundColor = [UIColor colorWithRed:60/255.f green:170/255.f blue:134/255.f alpha:1];
    errorLossExplanationLabel.textColor = [UIColor whiteColor];
    [self.mainScrollView addSubview:errorLossExplanationLabel];
    
    yPoint += 31;
    
    self.errorLossLineChart = [[LineChartView alloc] initWithFrame:CGRectMake(xPoint, yPoint, 430, 290)];
    
    self.errorLossLineChart.descriptionText = @"";
    self.errorLossLineChart.noDataTextDescription = @"You need to provide data for the chart.";
    
    self.errorLossLineChart.dragEnabled = YES;
    [self.errorLossLineChart setScaleEnabled:YES];
    self.errorLossLineChart.drawGridBackgroundEnabled = NO;
    self.errorLossLineChart.pinchZoomEnabled = YES;
    self.errorLossLineChart.rightAxis.enabled = NO;
    
    self.errorLossLineChart.backgroundColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:.001];
    
    self.errorLossLineChart.legend.form = ChartLegendFormLine;
    self.errorLossLineChart.legend.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.f];
    self.errorLossLineChart.legend.textColor = UIColor.blackColor;
    self.errorLossLineChart.legend.position = ChartLegendPositionBelowChartLeft;
    
    [self setDataCountLineChart:10 range:10];
    
    [self.mainScrollView addSubview:self.errorLossLineChart];
    
    //Respective toggle
    yPoint = yPoint + self.errorLossLineChart.frame.size.height + 16;
    UILabel *errorLossToggleLabel = [[UILabel alloc] initWithFrame:CGRectMake(xPoint+5, yPoint, 110, 21)];
    errorLossToggleLabel.text = @"Show Values";
    [self.mainScrollView addSubview:errorLossToggleLabel];
    
    UISwitch *errorLossToggle = [[UISwitch alloc] initWithFrame:CGRectMake(xPoint + 118, yPoint, 50, 21)];
    errorLossToggle.tag = 4;
    [errorLossToggle setOn:YES];
    [errorLossToggle addTarget:self action:@selector(toggleValueIndicator:) forControlEvents:UIControlEventValueChanged];
    [self.mainScrollView addSubview:errorLossToggle];
    
    yPoint = yPoint + self.errorsPieChart.view.frame.size.height - self.errorLossLineChart.frame.size.height;
    
    
    //Resources Loss Chart
    
    UILabel *resourceLossExplanationLabel = [[UILabel alloc] initWithFrame:CGRectMake(xPoint, yPoint, 430, 23)];
    resourceLossExplanationLabel.text = @"Loss Due to Each Resources in Million Dollars";
    resourceLossExplanationLabel.textAlignment = NSTextAlignmentCenter;
    resourceLossExplanationLabel.backgroundColor = [UIColor colorWithRed:60/255.f green:170/255.f blue:134/255.f alpha:1];
    resourceLossExplanationLabel.textColor = [UIColor whiteColor];
    
    [self.mainScrollView addSubview:resourceLossExplanationLabel];
    
    yPoint += 31;
    
    self.resourcesLossLineChart = [[LineChartView alloc] initWithFrame:CGRectMake(xPoint, yPoint, 430, 290)];
    
    self.resourcesLossLineChart.descriptionText = @"";
    self.resourcesLossLineChart.noDataTextDescription = @"You need to provide data for the chart.";
    
    self.resourcesLossLineChart.dragEnabled = YES;
    [self.resourcesLossLineChart setScaleEnabled:YES];
    self.resourcesLossLineChart.drawGridBackgroundEnabled = NO;
    self.resourcesLossLineChart.pinchZoomEnabled = YES;
    self.resourcesLossLineChart.rightAxis.enabled = NO;
    
    self.resourcesLossLineChart.backgroundColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:.001];
    
    self.resourcesLossLineChart.legend.form = ChartLegendFormLine;
    self.resourcesLossLineChart.legend.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.f];
    self.resourcesLossLineChart.legend.textColor = UIColor.blackColor;
    self.resourcesLossLineChart.legend.position = ChartLegendPositionBelowChartLeft;
    
    [self setDataCountResourcesLossLineChart:10 range:10];
    
    [self.mainScrollView addSubview:self.resourcesLossLineChart];
    
    //Respective toggle
    yPoint = yPoint + self.resourcesLossLineChart.frame.size.height + 16;
    UILabel *resourceLossToggleLabel = [[UILabel alloc] initWithFrame:CGRectMake(xPoint+5, yPoint, 110, 21)];
    resourceLossToggleLabel.text = @"Show Values";
    [self.mainScrollView addSubview:resourceLossToggleLabel];
    
    UISwitch *resourceLossToggle = [[UISwitch alloc] initWithFrame:CGRectMake(xPoint + 118, yPoint, 50, 21)];
    resourceLossToggle.tag = 5;
    [resourceLossToggle setOn:YES];
    [resourceLossToggle addTarget:self action:@selector(toggleValueIndicator:) forControlEvents:UIControlEventValueChanged];
    [self.mainScrollView addSubview:resourceLossToggle];
    
    yPoint = yPoint + self.errorsPieChart.view.frame.size.height + 8;
    
    xPoint = xPoint + self.errorLossLineChart.frame.size.width + 20;
    yPoint = resourceLossToggle.frame.origin.y + 150;
    
    self.mainScrollView.contentSize = CGSizeMake(xPoint,yPoint);
    
    NSLog(@"Done");
    
    ChartHighlight *newHighlight1 = [[ChartHighlight alloc] initWithXIndex:0 dataSetIndex:0];
    ChartHighlight *newHighlight2 = [[ChartHighlight alloc] initWithXIndex:0 dataSetIndex:1];
    ChartHighlight *newHighlight3 = [[ChartHighlight alloc] initWithXIndex:0 dataSetIndex:2];
    
    NSArray *highlightValues = @[newHighlight1,newHighlight2,newHighlight3];
    
    [self.ccEfficiencyGraphView highlightValues:highlightValues];
    
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)tapDetected:(UIGestureRecognizer *)sender {
    CGPoint currentPoint = [sender locationOfTouch:0 inView:self.mainScrollView];
    
    if (self.startTouch.x == 0)
    {
        self.startTouch = currentPoint;
    }
    else
    {
        self.endTouch = currentPoint;
        
        if (ABS(self.endTouch.x - self.startTouch.x < 70) || ABS(self.endTouch.y-self.startTouch.y) < 70)
        {
            self.endTouch = CGPointZero;
            self.startTouch = CGPointZero;
            return;
        }
        
        CGRect rect = CGRectMake(self.startTouch.x+8, self.startTouch.y+84, ABS(self.startTouch.x-self.endTouch.x), ABS(self.startTouch.y-self.endTouch.y));
        //        UIGraphicsBeginImageContext(rect.size);
        //        CGContextRef context = UIGraphicsGetCurrentContext();
        //        [self.view.layer renderInContext:context];
        //        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        //        UIGraphicsEndImageContext();
        
        UIGraphicsBeginImageContext(self.mainScrollView.bounds.size);
        
        [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
        
        UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        CGImageRef imageRef = CGImageCreateWithImageInRect([viewImage CGImage], rect);
        
        UIImage *image = [UIImage imageWithCGImage:imageRef];
        
        //        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        
        CGImageRelease(imageRef);
        
        self.cpImageViewController = [[CopyImageViewController alloc] initWithImage:image];
        self.cpImageViewController.view.frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
        self.cpImageViewController.view.center = self.view.center;
        self.cpImageViewController.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.6];
        self.cpImageViewController.contentView.frame = CGRectMake(self.cpImageViewController.view.frame.origin.x, self.cpImageViewController.view.frame.origin.y, image.size.width, MIN(image.size.height, self.view.frame.size.height-self.view.frame.size.height/4)+64);
        self.cpImageViewController.contentView.center = self.cpImageViewController.view.center;
        self.cpImageViewController.contentView.layer.cornerRadius = 0.5f;
        [self.view addSubview:self.cpImageViewController.view];
    }
    
    NSLog(@"Double tap at %f,%f", currentPoint.x, currentPoint.y);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setDataCount:(int)count range:(double)range
{
    NSArray *xVals = @[@"CC1",@"CC2",@"CC3",@"CC4",@"Others"];
    
    NSMutableArray *yVals1 = [[NSMutableArray alloc] init];
    NSMutableArray *yVals2 = [[NSMutableArray alloc] init];
    NSMutableArray *yVals3 = [[NSMutableArray alloc] init];
    
    double mult = range;
    
    for (int i = 0; i < count; i++)
    {
        double val = (double) (arc4random_uniform(mult) + 3.0);
        [yVals1 addObject:[[BarChartDataEntry alloc] initWithValue:val xIndex:i]];
        
        val = (double) (arc4random_uniform(mult) + 3.0);
        [yVals2 addObject:[[BarChartDataEntry alloc] initWithValue:val xIndex:i]];
        
        val = (double) (arc4random_uniform(mult) + 3.0);
        [yVals3 addObject:[[BarChartDataEntry alloc] initWithValue:val xIndex:i]];
    }
    
    BarChartDataSet *set1 = [[BarChartDataSet alloc] initWithYVals:yVals1 label:@"Average"];
    [set1 setColor:[UIColor colorWithRed:79/255.f green:129/255.f blue:189/255.f alpha:1.f]];
    BarChartDataSet *set2 = [[BarChartDataSet alloc] initWithYVals:yVals2 label:@"Previous PayPeriod"];
    [set2 setColor:[UIColor colorWithRed:192/255.f green:80/255.f blue:77/255.f alpha:1.f]];
    BarChartDataSet *set3 = [[BarChartDataSet alloc] initWithYVals:yVals3 label:@"Current PayPeriod"];
    [set3 setColor:[UIColor colorWithRed:155/255.f green:187/255.f blue:89/255.f alpha:1.f]];
    
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    [dataSets addObject:set1];
    [dataSets addObject:set2];
    [dataSets addObject:set3];
    
    BarChartData *data = [[BarChartData alloc] initWithXVals:xVals dataSets:dataSets];
    data.groupSpace = 0.8;
    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:10.f]];
    
    self.ccEfficiencyGraphView.data = data;
}

- (void)setDataCountLineChart:(int)count range:(double)range
{
    NSMutableArray *xVals = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i++)
    {
        [xVals addObject:[@(i) stringValue]];
    }
    
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i++)
    {
        double mult = range / 2.0;
        double val = (double) (arc4random_uniform(mult)) + 50;
        [yVals addObject:[[ChartDataEntry alloc] initWithValue:val xIndex:i]];
    }
    
    LineChartDataSet *set1 = [[LineChartDataSet alloc] initWithYVals:yVals label:@"Managerial"];
    set1.axisDependency = AxisDependencyLeft;
    [set1 setColor:[UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f]];
    [set1 setCircleColor:UIColor.whiteColor];
    set1.lineWidth = 2.0;
    set1.circleRadius = 3.0;
    set1.fillAlpha = 65/255.0;
    set1.fillColor = [UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f];
    set1.highlightColor = [UIColor colorWithRed:244/255.f green:117/255.f blue:117/255.f alpha:1.f];
    set1.drawCircleHoleEnabled = NO;
    
    NSMutableArray *yVals2 = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i++)
    {
        double mult = range;
        double val = (double) (arc4random_uniform(mult)) + 75;
        [yVals2 addObject:[[ChartDataEntry alloc] initWithValue:val xIndex:i]];
    }
    
    LineChartDataSet *set2 = [[LineChartDataSet alloc] initWithYVals:yVals2 label:@"Additional WLU"];
    set2.axisDependency = AxisDependencyRight;
    [set2 setColor:[UIColor colorWithRed:74/255.f green:126/255.f blue:187/255.f alpha:1.f]];
    [set2 setCircleColor:UIColor.whiteColor];
    set2.lineWidth = 2.0;
    set2.circleRadius = 3.0;
    set2.fillAlpha = 65/255.0;
    set2.fillColor = UIColor.redColor;
    set2.highlightColor = [UIColor colorWithRed:244/255.f green:117/255.f blue:117/255.f alpha:1.f];
    set2.drawCircleHoleEnabled = NO;
    
    NSMutableArray *yVals3 = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i++)
    {
        double mult = range / 2.0;
        double val = (double) (arc4random_uniform(mult)) + 60;
        [yVals3 addObject:[[ChartDataEntry alloc] initWithValue:val xIndex:i]];
    }
    
    LineChartDataSet *set3 = [[LineChartDataSet alloc] initWithYVals:yVals3 label:@"Wrong Acuity"];
    set3.axisDependency = AxisDependencyLeft;
    [set3 setColor:[UIColor colorWithRed:190/255.f green:75/255.f blue:72/255.f alpha:1.f]];
    [set3 setCircleColor:UIColor.whiteColor];
    set3.lineWidth = 2.0;
    set3.circleRadius = 3.0;
    set3.fillAlpha = 65/255.0;
    set3.fillColor = [UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f];
    set3.highlightColor = [UIColor colorWithRed:244/255.f green:117/255.f blue:117/255.f alpha:1.f];
    set3.drawCircleHoleEnabled = NO;
    
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    [dataSets addObject:set1];
    [dataSets addObject:set2];
    [dataSets addObject:set3];
    
    LineChartData *data = [[LineChartData alloc] initWithXVals:xVals dataSets:dataSets];
    [data setValueTextColor:UIColor.blackColor];
    [data setValueFont:[UIFont systemFontOfSize:9.f]];
    
    self.errorLossLineChart.data = data;
}

- (void)setDataCountResourcesLossLineChart:(int)count range:(double)range
{
    NSMutableArray *xVals = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i++)
    {
        [xVals addObject:[@(i) stringValue]];
    }
    
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i++)
    {
        double mult = range / 2.0;
        double val = (double) (arc4random_uniform(mult)) + 50;
        [yVals addObject:[[ChartDataEntry alloc] initWithValue:val xIndex:i]];
    }
    
    LineChartDataSet *set1 = [[LineChartDataSet alloc] initWithYVals:yVals label:@"RN"];
    set1.axisDependency = AxisDependencyLeft;
    [set1 setColor:[UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f]];
    [set1 setCircleColor:UIColor.whiteColor];
    set1.lineWidth = 2.0;
    set1.circleRadius = 3.0;
    set1.fillAlpha = 65/255.0;
    set1.fillColor = [UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f];
    set1.highlightColor = [UIColor colorWithRed:244/255.f green:117/255.f blue:117/255.f alpha:1.f];
    set1.drawCircleHoleEnabled = NO;
    
    NSMutableArray *yVals2 = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i++)
    {
        double mult = range;
        double val = (double) (arc4random_uniform(mult)) + 35;
        [yVals2 addObject:[[ChartDataEntry alloc] initWithValue:val xIndex:i]];
    }
    
    LineChartDataSet *set2 = [[LineChartDataSet alloc] initWithYVals:yVals2 label:@"LPN"];
    set2.axisDependency = AxisDependencyRight;
    [set2 setColor:[UIColor colorWithRed:74/255.f green:126/255.f blue:187/255.f alpha:1.f]];
    [set2 setCircleColor:UIColor.whiteColor];
    set2.lineWidth = 2.0;
    set2.circleRadius = 3.0;
    set2.fillAlpha = 65/255.0;
    set2.fillColor = UIColor.redColor;
    set2.highlightColor = [UIColor colorWithRed:244/255.f green:117/255.f blue:117/255.f alpha:1.f];
    set2.drawCircleHoleEnabled = NO;
    
    NSMutableArray *yVals3 = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i++)
    {
        double mult = range / 2.0;
        double val = (double) (arc4random_uniform(mult)) + 25;
        [yVals3 addObject:[[ChartDataEntry alloc] initWithValue:val xIndex:i]];
    }
    
    LineChartDataSet *set3 = [[LineChartDataSet alloc] initWithYVals:yVals3 label:@"AID"];
    set3.axisDependency = AxisDependencyLeft;
    [set3 setColor:[UIColor colorWithRed:190/255.f green:75/255.f blue:72/255.f alpha:1.f]];
    [set3 setCircleColor:UIColor.whiteColor];
    set3.lineWidth = 2.0;
    set3.circleRadius = 3.0;
    set3.fillAlpha = 65/255.0;
    set3.fillColor = [UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f];
    set3.highlightColor = [UIColor colorWithRed:244/255.f green:117/255.f blue:117/255.f alpha:1.f];
    set3.drawCircleHoleEnabled = NO;
    
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    [dataSets addObject:set1];
    [dataSets addObject:set2];
    [dataSets addObject:set3];
    
    LineChartData *data = [[LineChartData alloc] initWithXVals:xVals dataSets:dataSets];
    [data setValueTextColor:UIColor.blackColor];
    [data setValueFont:[UIFont systemFontOfSize:9.f]];
    
    self.resourcesLossLineChart.data = data;
}

- (void)setDataCountCCLossLineChart:(int)count range:(double)range
{
    NSMutableArray *xVals = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i++)
    {
        [xVals addObject:[@(i) stringValue]];
    }
    
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i++)
    {
        double mult = range / 2.0;
        double val = (double) (arc4random_uniform(mult)) + 50;
        [yVals addObject:[[ChartDataEntry alloc] initWithValue:val xIndex:i]];
    }
    
    LineChartDataSet *set1 = [[LineChartDataSet alloc] initWithYVals:yVals label:@"CC1"];
    set1.axisDependency = AxisDependencyLeft;
    [set1 setColor:[UIColor colorWithRed:170/255.f green:91/255.f blue:151/255.f alpha:1.f]];
    [set1 setCircleColor:UIColor.whiteColor];
    set1.lineWidth = 2.0;
    set1.circleRadius = 3.0;
    set1.fillAlpha = 65/255.0;
    set1.fillColor = [UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f];
    set1.highlightColor = [UIColor colorWithRed:244/255.f green:117/255.f blue:117/255.f alpha:1.f];
    set1.drawCircleHoleEnabled = NO;
    
    NSMutableArray *yVals2 = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i++)
    {
        double mult = range;
        double val = (double) (arc4random_uniform(mult)) + 15;
        [yVals2 addObject:[[ChartDataEntry alloc] initWithValue:val xIndex:i]];
    }
    
    LineChartDataSet *set2 = [[LineChartDataSet alloc] initWithYVals:yVals2 label:@"CC2"];
    set2.axisDependency = AxisDependencyRight;
    [set2 setColor:[UIColor colorWithRed:74/255.f green:126/255.f blue:187/255.f alpha:1.f]];
    [set2 setCircleColor:UIColor.whiteColor];
    set2.lineWidth = 2.0;
    set2.circleRadius = 3.0;
    set2.fillAlpha = 65/255.0;
    set2.fillColor = UIColor.redColor;
    set2.highlightColor = [UIColor colorWithRed:244/255.f green:117/255.f blue:117/255.f alpha:1.f];
    set2.drawCircleHoleEnabled = NO;
    
    NSMutableArray *yVals3 = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i++)
    {
        double mult = range;
        double val = (double) (arc4random_uniform(mult)) + 35;
        [yVals3 addObject:[[ChartDataEntry alloc] initWithValue:val xIndex:i]];
    }
    
    LineChartDataSet *set3 = [[LineChartDataSet alloc] initWithYVals:yVals3 label:@"CC3"];
    set3.axisDependency = AxisDependencyRight;
    [set3 setColor:[UIColor colorWithRed:190/255.f green:75/255.f blue:72/255.f alpha:1.f]];
    [set3 setCircleColor:UIColor.whiteColor];
    set3.lineWidth = 2.0;
    set3.circleRadius = 3.0;
    set3.fillAlpha = 65/255.0;
    set3.fillColor = UIColor.redColor;
    set3.highlightColor = [UIColor colorWithRed:244/255.f green:117/255.f blue:117/255.f alpha:1.f];
    set3.drawCircleHoleEnabled = NO;
    
    
    NSMutableArray *yVals4 = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i++)
    {
        double mult = range;
        double val = (double) (arc4random_uniform(mult)) + 55;
        [yVals4 addObject:[[ChartDataEntry alloc] initWithValue:val xIndex:i]];
    }
    
    LineChartDataSet *set4 = [[LineChartDataSet alloc] initWithYVals:yVals4 label:@"CC4"];
    set4.axisDependency = AxisDependencyRight;
    [set4 setColor:[UIColor colorWithRed:152/255.f green:185/255.f blue:84/255.f alpha:1.f]];
    [set4 setCircleColor:UIColor.whiteColor];
    set4.lineWidth = 2.0;
    set4.circleRadius = 3.0;
    set4.fillAlpha = 65/255.0;
    set4.fillColor = UIColor.redColor;
    set4.highlightColor = [UIColor colorWithRed:244/255.f green:117/255.f blue:117/255.f alpha:1.f];
    set4.drawCircleHoleEnabled = NO;
    
    NSMutableArray *yVals5 = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i++)
    {
        double mult = range;
        double val = (double) (arc4random_uniform(mult)) + 70;
        [yVals5 addObject:[[ChartDataEntry alloc] initWithValue:val xIndex:i]];
    }
    
    LineChartDataSet *set5 = [[LineChartDataSet alloc] initWithYVals:yVals5 label:@"OTHERS"];
    set5.axisDependency = AxisDependencyRight;
    [set5 setColor:[UIColor colorWithRed:125/255.f green:96/255.f blue:160/255.f alpha:1.f]];
    [set5 setCircleColor:UIColor.whiteColor];
    set5.lineWidth = 2.0;
    set5.circleRadius = 3.0;
    set5.fillAlpha = 65/255.0;
    set5.fillColor = UIColor.redColor;
    set5.highlightColor = [UIColor colorWithRed:244/255.f green:117/255.f blue:117/255.f alpha:1.f];
    set5.drawCircleHoleEnabled = NO;
    
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    [dataSets addObject:set1];
    [dataSets addObject:set2];
    [dataSets addObject:set3];
    [dataSets addObject:set4];
    [dataSets addObject:set5];
    
    LineChartData *data = [[LineChartData alloc] initWithXVals:xVals dataSets:dataSets];
    [data setValueTextColor:UIColor.blackColor];
    [data setValueFont:[UIFont systemFontOfSize:9.f]];
    
    self.ccLossLineChart.data = data;
}

- (void)setDataCountForResourceStackChart:(int)count range:(double)range
{
    NSMutableArray *xVals = [[NSMutableArray alloc] init];
    NSArray *months = @[
                        @"RN", @"LPN", @"AID", @"OTHERS"
                        ];
    
    for (int i = 0; i < count; i++)
    {
        [xVals addObject:months[i % 12]];
    }
    
    NSMutableArray *yVals1 = [[NSMutableArray alloc] init];
    NSMutableArray *yVals2 = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i++)
    {
        double mult = (range + 1);
        double val1 = (double) (arc4random_uniform(mult) + mult / 3);
        double val2 = (double) (arc4random_uniform(mult) + mult / 3);
        
        double val = (double) (arc4random_uniform(mult) + mult / 3);
        [yVals1 addObject:[[BarChartDataEntry alloc] initWithValue:val xIndex:i]];
        
        val = (double) (arc4random_uniform(mult) + 3.0);
        [yVals2 addObject:[[BarChartDataEntry alloc] initWithValues:@[@(val1),@(val2)] xIndex:i]];
        
        
    }
    
    BarChartDataSet *set1 = [[BarChartDataSet alloc] initWithYVals:yVals1 label:@"Expected Regular"];
    [set1 setColor:[UIColor colorWithRed:104/255.f green:241/255.f blue:175/255.f alpha:1.f]];
    BarChartDataSet *set2 = [[BarChartDataSet alloc] initWithYVals:yVals2 label:@""];
    [set2 setColor:[UIColor colorWithRed:164/255.f green:228/255.f blue:251/255.f alpha:1.f]];
    
//    BarChartDataSet *set1 = [[BarChartDataSet alloc] initWithYVals:yVals label:@"Resource Hours Split"];
    set1.colors = @[[UIColor colorWithRed:79/255.f green:129/255.f blue:189/255.f alpha:1.f]];
    set2.colors = @[[UIColor colorWithRed:155/255.f green:187/255.f blue:89/255.f alpha:1.f],
                    [UIColor colorWithRed:192/255.f green:80/255.f blue:77/255.f alpha:1.f]];
    set2.stackLabels = @[@"Actual Regular", @"Actual Overtime"];
    
//    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
//    [dataSets addObject:set1];
    
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    [dataSets addObject:set1];
    [dataSets addObject:set2];
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.maximumFractionDigits = 1;
    formatter.negativeSuffix = @" hrs";
    formatter.positiveSuffix = @" hrs";
    
    BarChartData *data = [[BarChartData alloc] initWithXVals:xVals dataSets:dataSets];
    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:7.f]];
    [data setValueFormatter:formatter];
    
    self.resourceSplitStackedChart.data = data;
}

- (void)toggleValueIndicator:(id)sender
{
    NSInteger tag = [sender tag];
    
    if (tag == 1)
    {
        for (ChartDataSet *set in self.ccEfficiencyGraphView.data.dataSets)
        {
            set.drawValuesEnabled = !set.isDrawValuesEnabled;
        }
        
        [self.ccEfficiencyGraphView setNeedsDisplay];
    }
    else if (tag == 2)
    {
        for (ChartDataSet *set in self.ccLossLineChart.data.dataSets)
        {
            set.drawValuesEnabled = !set.isDrawValuesEnabled;
        }
        
        [self.ccLossLineChart setNeedsDisplay];
    }
    else if (tag == 3)
    {
        for (ChartDataSet *set in self.resourceSplitStackedChart.data.dataSets)
        {
            set.drawValuesEnabled = !set.isDrawValuesEnabled;
        }
        
        [self.resourceSplitStackedChart setNeedsDisplay];
    }
    else if (tag == 4)
    {
        for (ChartDataSet *set in self.errorLossLineChart.data.dataSets)
        {
            set.drawValuesEnabled = !set.isDrawValuesEnabled;
        }
        
        [self.errorLossLineChart setNeedsDisplay];
    }
    else if (tag == 5)
    {
        for (ChartDataSet *set in self.resourcesLossLineChart.data.dataSets)
        {
            set.drawValuesEnabled = !set.isDrawValuesEnabled;
        }
        
        [self.resourcesLossLineChart setNeedsDisplay];
    }
}

- (void)chartValueSelected:(ChartViewBase * __nonnull)chartView entry:(ChartDataEntry * __nonnull)entry dataSetIndex:(NSInteger)dataSetIndex highlight:(ChartHighlight * __nonnull)highlight
{
    ChartHighlight *newHighlight1 = [[ChartHighlight alloc] initWithXIndex:highlight.xIndex dataSetIndex:0];
    ChartHighlight *newHighlight2 = [[ChartHighlight alloc] initWithXIndex:highlight.xIndex dataSetIndex:1];
    ChartHighlight *newHighlight3 = [[ChartHighlight alloc] initWithXIndex:highlight.xIndex dataSetIndex:2];
    
    NSArray *highlightValues = @[newHighlight1,newHighlight2,newHighlight3];
    
    [chartView highlightValues:highlightValues];
    
}

- (IBAction)copyImage:(id)sender
{
    [UIPasteboard generalPasteboard].image = self.cpImageViewController.displayImage;
    
    [self cancel:nil];
}

- (IBAction)cancel:(id)sender
{
    [self.cpImageViewController.view removeFromSuperview];
    self.startTouch = CGPointZero;
    self.endTouch = CGPointZero;
}

- (IBAction)saveToPhotos:(id)sender
{
    [self copyImage:nil];
    [self.library saveImage:self.cpImageViewController.displayImage toAlbum:@"FTEPrime" withCompletionBlock:^(NSError *error) {
        if (error!=nil) {
            NSLog(@"Big error: %@", [error description]);
        }
        else
        {
            [self cancel:nil];
        }
    }];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

@end
