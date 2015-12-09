//
//  MyCollectionViewCell.m
//  UIcollectionViewMe
//
//  Created by Joker on 15/12/8.
//  Copyright © 2015年 Joker. All rights reserved.
//

#import "MyCollectionViewCell.h"
#import "MyApps.h"

@implementation MyCollectionViewCell


- (void)setApps:(MyApps *)apps {
    _apps = apps;
    
    _ImgView.image = apps.icon;
    _Label.text = apps.name;
}


- (void)awakeFromNib {
    // Initialization code
    
    self.backgroundColor = [UIColor whiteColor];
    
    
    //设置选中时的背景颜色
    UIView *selectedBgView = [[UIView alloc]init];
    selectedBgView.backgroundColor = [UIColor orangeColor];
    self.selectedBackgroundView = selectedBgView;
    
    
}

@end
