//
//  EfficiencyTableViewController.m
//  FTEPrime
//
//  Created by Sujith Achuthan on 8/28/15.
//  Copyright (c) 2015 Sujith Achuthan. All rights reserved.
//

#import "EfficiencyTableViewController.h"

@interface EfficiencyTableViewController ()

@end

@implementation EfficiencyTableViewController

-(id)initWithItems:(NSDictionary*)component
{
    self = [super init];
    if( !self )
    {
        return nil;
    }
    
    _componentValues = component;
    
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.eFeFLabel.text = [self.componentValues valueForKey:@"efef"];
    self.efFteLabel.text = [self.componentValues valueForKey:@"effte"];
    self.efProdLabel.text = [self.componentValues valueForKey:@"efProd"];
    self.fteEfLabel.text = [self.componentValues valueForKey:@"fteef"];
    self.fteFteLabel.text = [self.componentValues valueForKey:@"ftefte"];
    self.fteProdLabel.text = [self.componentValues valueForKey:@"fteProd"];
    self.prodEfLabel.text = [self.componentValues valueForKey:@"prodef"];
    self.prodFteLabel.text = [self.componentValues valueForKey:@"prodfte"];
    self.prodProdLabel.text = [self.componentValues valueForKey:@"prodprod"];
    
    UIColor *textColor = [UIColor colorWithRed:0.17 green:0.59 blue:0.91 alpha:1.0];
    self.eFeFLabel.textColor = textColor;
    self.efFteLabel.textColor = textColor;
    self.efProdLabel.textColor = textColor;
    self.fteEfLabel.textColor = textColor;
    self.fteFteLabel.textColor = textColor;
    self.fteProdLabel.textColor = textColor;
    self.prodEfLabel.textColor = textColor;
    self.prodFteLabel.textColor = textColor;
    self.prodProdLabel.textColor = textColor;
    
    [self.eFeFLabel setFont:[UIFont systemFontOfSize:20]];
    [self.efFteLabel setFont:[UIFont systemFontOfSize:20]];
    [self.efProdLabel setFont:[UIFont systemFontOfSize:20]];
    [self.fteEfLabel setFont:[UIFont systemFontOfSize:20]];
    [self.fteFteLabel setFont:[UIFont systemFontOfSize:20]];
    [self.fteProdLabel setFont:[UIFont systemFontOfSize:20]];
    [self.prodEfLabel setFont:[UIFont systemFontOfSize:20]];
    [self.prodFteLabel setFont:[UIFont systemFontOfSize:20]];
    [self.prodProdLabel setFont:[UIFont systemFontOfSize:20]];
    
    
    [self.eFeFLabel setShadowColor:[UIColor darkGrayColor]];
    [self.efFteLabel setShadowColor:[UIColor darkGrayColor]];
    [self.efProdLabel setShadowColor:[UIColor darkGrayColor]];
    [self.fteEfLabel setShadowColor:[UIColor darkGrayColor]];
    [self.fteFteLabel setShadowColor:[UIColor darkGrayColor]];
    [self.fteProdLabel setShadowColor:[UIColor darkGrayColor]];
    [self.prodEfLabel setShadowColor:[UIColor darkGrayColor]];
    [self.prodFteLabel setShadowColor:[UIColor darkGrayColor]];
    [self.prodProdLabel setShadowColor:[UIColor darkGrayColor]];
    
    [self.eFeFLabel setShadowOffset:CGSizeMake(0, -1)];
    [self.efFteLabel setShadowOffset:CGSizeMake(0, -1)];
    [self.efProdLabel setShadowOffset:CGSizeMake(0, -1)];
    [self.fteEfLabel setShadowOffset:CGSizeMake(0, -1)];
    [self.fteFteLabel setShadowOffset:CGSizeMake(0, -1)];
    [self.fteProdLabel setShadowOffset:CGSizeMake(0, -1)];
    [self.prodEfLabel setShadowOffset:CGSizeMake(0, -1)];
    [self.prodFteLabel setShadowOffset:CGSizeMake(0, -1)];
    [self.prodProdLabel setShadowOffset:CGSizeMake(0, -1)];
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
    self.view.opaque = NO;
    
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
