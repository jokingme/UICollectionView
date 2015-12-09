//
//  MyCollectionViewCell.h
//  UIcollectionViewMe
//
//  Created by Joker on 15/12/8.
//  Copyright © 2015年 Joker. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyApps;

@interface MyCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *ImgView;
@property (weak, nonatomic) IBOutlet UILabel *Label;

@property (nonatomic,strong) MyApps *apps;
@end
