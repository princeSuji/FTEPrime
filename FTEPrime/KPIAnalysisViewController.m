//
//  KPIAnalysisViewController.m
//  FTEPrime
//
//  Created by Sujith Achuthan on 10/21/15.
//  Copyright © 2015 Sujith Achuthan. All rights reserved.
//

#import "KPIAnalysisViewController.h"

@interface KPIAnalysisViewController ()

@end

@implementation KPIAnalysisViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.efficiencyController = [[KPIViewController alloc] init];
    self.efficiencyController.view.frame = self.view.frame;
    [self.view addSubview:self.efficiencyController.view];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
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
