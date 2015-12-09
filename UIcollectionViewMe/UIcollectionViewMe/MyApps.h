//
//  MyApps.h
//  UIcollectionViewMe
//
//  Created by Joker on 15/12/8.
//  Copyright © 2015年 Joker. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UIImage;
@interface MyApps : NSObject

@property (nonatomic,strong) UIImage *icon;
@property (nonatomic,strong) NSString *name;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
+ (instancetype)AppWithDictionary:(NSDictionary *)dict;

@end
