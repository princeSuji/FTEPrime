//
//  ViewController.m
//  FTEPrime
//
//  Created by Sujith Achuthan on 8/26/15.
//  Copyright (c) 2015 Sujith Achuthan. All rights reserved.
//

#import "ViewController.h"
#import "GridViewController.h"
#import "ThreeBoxGridViewController.h"
#import "EfficiencyTableViewController.h"
#import "GraphViewController.h"
#import "CopyImageViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *xmlFilePath = [[NSBundle mainBundle]pathForResource:@"data" ofType:@"xml"];
    NSURL *url = [NSURL fileURLWithPath:xmlFilePath];
    
    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    
    [xmlParser setDelegate:self];
    
    [xmlParser parse];
    // Do any additional setup after loading the view, typically from a nib.
    
    UITapGestureRecognizer *doubleTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected:)];
    doubleTap.numberOfTapsRequired = 2;
    doubleTap.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:doubleTap];
    
    self.library = [[ALAssetsLibrary alloc] init];
}


- (IBAction)tapDetected:(UIGestureRecognizer *)sender {
    CGPoint currentPoint = [sender locationOfTouch:0 inView:self.collectionView];
    
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
        
        UIGraphicsBeginImageContext(self.collectionView.bounds.size);
        
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

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{
    if ( [elementName isEqualToString:@"Report"])
    {
        self.components = [[NSMutableArray alloc] init];
    }
    else if ([elementName isEqualToString:@"Component"])
    {
        self.currentItem = [[NSMutableDictionary alloc] init];
        self.currentTitleArray = [[NSMutableArray alloc] init];
        self.currentQtyArray = [[NSMutableArray alloc] init];
    }
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"Component"])
    {
        if (self.currentQtyArray.count > 0 && self.currentTitleArray.count > 0)
        {
            NSDictionary *temp = [NSDictionary dictionaryWithObjectsAndKeys:[self.currentTitleArray copy],@"Title",[self.currentQtyArray copy],@"Qty", nil];
            
            [self.currentItem addEntriesFromDictionary:temp];
        }
        
        [self.components addObject:[self.currentItem copy]];
    }
    else if ([elementName isEqualToString:@"Report"])
    {
//        NSLog(@"%@",self.components);
        [self doneParsing];
    }
    else if ([elementName isEqualToString:@"Title"])
    {
        [self.currentTitleArray addObject:self.xmlValue];
    }
    else if ([elementName isEqualToString:@"Qty"])
    {
        [self.currentQtyArray addObject:self.xmlValue];
    }
    else
    {
        NSDictionary *temp = [NSDictionary dictionaryWithObjectsAndKeys:self.xmlValue,elementName, nil];
    
        [self.currentItem addEntriesFromDictionary:temp];
    }
    
}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    self.xmlValue = string;
}

- (void)doneParsing
{
    self.componentViews = [[NSMutableArray alloc] init];
    for (NSDictionary *currentDictionary in self.components)
    {
        UIViewController *newController = nil;
        
        if ([[currentDictionary valueForKey:@"Type"] integerValue] == 1)
        {
            NSArray *keys = @[@"PayPeriod_Count",@"YTD_Value"];
            newController = [[GridViewController alloc] initWithItems:currentDictionary andKeys:keys];
            
            newController.view.frame = CGRectMake(0, 0,newController.view.frame.size.width,newController.view.frame.size.height);
            newController.view.backgroundColor = [UIColor grayColor];
            
            newController.view.translatesAutoresizingMaskIntoConstraints = NO;
        }
        else if ([[currentDictionary valueForKey:@"Type"] integerValue] == 2)
        {
            newController = [[ThreeBoxGridViewController alloc] initWithItems:currentDictionary];
            
            newController.view.frame = CGRectMake(0, 0,newController.view.frame.size.width,newController.view.frame.size.height);
            newController.view.backgroundColor = [UIColor grayColor];
            
            newController.view.translatesAutoresizingMaskIntoConstraints = NO;
        }
        else if ([[currentDictionary valueForKey:@"Type"] integerValue] == 3)
        {
            newController = [[EfficiencyTableViewController alloc] initWithItems:currentDictionary];
            
            newController.view.frame = CGRectMake(0, 0,newController.view.frame.size.width,newController.view.frame.size.height);
            newController.view.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:.1];
        }
        else if ([[currentDictionary valueForKey:@"Type"] integerValue] == 4)
        {
            newController = [[GraphViewController alloc] initWithItems:currentDictionary];
            
            newController.view.frame = CGRectMake(0, 0,newController.view.frame.size.width,newController.view.frame.size.height);
            newController.view.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:.1];
        }
        
        [self.componentViews addObject:newController];
    }
    [self.collectionView reloadData];
    self.mainScrollView.contentSize = self.collectionView.frame.size;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.componentViews.count;
}
// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = nil;
    UIViewController *newController = self.componentViews[indexPath.row];
    
    if ([newController isKindOfClass:[GridViewController class]])
    {
        cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
        
        [[cell.contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
        
        [cell.contentView addSubview:newController.view];
    }
    else if ([newController isKindOfClass:[ThreeBoxGridViewController class]])
    {
        cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"threeCellIdentifier" forIndexPath:indexPath];
        
        [[cell.contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
        
        [cell.contentView addSubview:newController.view];
    }
    else if ([newController isKindOfClass:[EfficiencyTableViewController class]])
    {
        cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"tableCellIdentifier" forIndexPath:indexPath];
        
        [[cell.contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
        
        [cell.contentView addSubview:newController.view];
    }
    else if ([newController isKindOfClass:[GraphViewController class]])
    {
        cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"graphCellIdentifier" forIndexPath:indexPath];
        
        [[cell.contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
        
        [cell.contentView addSubview:newController.view];
    }
    
    [cell.contentView addConstraint:[NSLayoutConstraint constraintWithItem:newController.view
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:cell.contentView
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1.0
                                                           constant:0.0]];
    [cell.contentView addConstraint:[NSLayoutConstraint
                              constraintWithItem:newController.view
                              attribute:NSLayoutAttributeWidth
                              relatedBy:NSLayoutRelationEqual
                              toItem: newController.view
                              attribute:NSLayoutAttributeWidth
                              multiplier:1.0f
                              constant:0]];
    
    UIColor *newColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:.2];
    cell.contentView.backgroundColor = newColor;
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:cell.bounds
                                                   byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight)
                                                         cornerRadii:CGSizeMake(10, 10)];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = cell.bounds;
    maskLayer.path = maskPath.CGPath;
    cell.layer.mask = maskLayer;
    
    // Round cell corners
    cell.layer.cornerRadius = 10;
    
    // Add shadow
    cell.layer.masksToBounds = NO;
    cell.layer.shadowOpacity = 0.75f;
    cell.layer.shadowRadius = 10.0f;
    cell.layer.shouldRasterize = NO;
    cell.layer.shadowPath = [UIBezierPath bezierPathWithRect:CGRectMake(cell.frame.size.width/2 - (cell.frame.size.width)/2, cell.frame.size.height, cell.frame.size.width, 10)].CGPath;
    
    return cell;
}

#pragma mark Collection view layout things
// Layout: Set cell size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UIViewController *newController = self.componentViews[indexPath.row];
    
    return newController.view.frame.size;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 12.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 12.0;
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

//// Layout: Set Edges
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    float width = collectionView.frame.size.width;
//    float spacing = [self collectionView:collectionView layout:collectionViewLayout minimumInteritemSpacingForSectionAtIndex:section];
//    NSInteger numberOfCells = (width + spacing) / (316 + spacing);
//    NSInteger inset = (width + spacing - numberOfCells * (316 + spacing) ) / 2;
//    
//    return UIEdgeInsetsMake(0, inset, 0, inset);
//}

@end
