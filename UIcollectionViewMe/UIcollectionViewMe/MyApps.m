//
//  MyApps.m
//  UIcollectionViewMe
//
//  Created by Joker on 15/12/8.
//  Copyright © 2015年 Joker. All rights reserved.
//

#import "MyApps.h"
#import <UIKit/UIImage.h>

@implementation MyApps

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        _icon = [UIImage imageNamed:dict[@"icon"]];
        _name = dict[@"name"];
    }
    return self;
}

+ (instancetype)AppWithDictionary:(NSDictionary *)dict {
    return [[MyApps alloc]initWithDictionary:dict];
}

@end
