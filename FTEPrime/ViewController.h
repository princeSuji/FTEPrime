//
//  ViewController.h
//  FTEPrime
//
//  Created by Sujith Achuthan on 8/26/15.
//  Copyright (c) 2015 Sujith Achuthan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CopyImageViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "ALAssetsLibrary+CustomPhotoAlbum.h"

@interface ViewController : UIViewController<NSXMLParserDelegate,UICollectionViewDataSource, UICollectionViewDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;

@property(strong)NSString *xmlValue;
@property(strong)NSMutableDictionary *currentItem;
@property(strong)NSMutableArray *currentTitleArray;
@property(strong)NSMutableArray *currentQtyArray;
@property(strong)NSMutableArray *components;
@property(strong)NSMutableArray *componentViews;
@property(strong)CopyImageViewController *cpImageViewController;

@property(assign)CGPoint startTouch;
@property(assign)CGPoint endTouch;
@property(strong)UIView* highlightView;

@property (strong, atomic) ALAssetsLibrary* library;

@end

