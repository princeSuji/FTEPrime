//
//  GraphViewController.m
//  FTEPrime
//
//  Created by Sujith Achuthan on 10/9/15.
//  Copyright © 2015 Sujith Achuthan. All rights reserved.
//

#import "GraphViewController.h"

@interface GraphViewController ()

@end

@implementation GraphViewController

-(id)initWithItems:(NSDictionary*)component
{
    self = [super init];
    if( !self )
    {
        return nil;
    }
    
    _data = [component valueForKey:@"Qty"];
    _legends = [component valueForKey:@"Title"];
    
    NSArray *colorsArray = @[[UIColor colorWithRed:64/255.f green:105/255.f blue:156/255.f alpha:1.f],
                            [UIColor colorWithRed:79/255.f green:129/255.f blue:189/255.f alpha:1.f],
                            [UIColor colorWithRed:170/255.f green:186/255.f blue:215/255.f alpha:1.f],
                            [UIColor brownColor]];
    
    _colors = [[NSMutableArray alloc] initWithArray:colorsArray];
    _labelString = [component valueForKey:@"Label"];
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.graphView renderInLayer:self.graphView dataArray:self.data legendsArray:self.legends andColorsArray:self.colors];
    self.graphView.delegate = self;
    self.titleLabel.text = self.labelString;
    self.graphView.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pieChart:(DLPieChart *)pieChart didSelectSliceAtIndex:(NSUInteger)index
{
    NSLog(@"Selected slice %lu",index);
}

- (void)pieChart:(DLPieChart *)pieChart didDeselectSliceAtIndex:(NSUInteger)index
{
   NSLog(@"Unselected slice %lu",index);
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
