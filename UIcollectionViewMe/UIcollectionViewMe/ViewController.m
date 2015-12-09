//
//  ViewController.m
//  UIcollectionViewMe
//
//  Created by Joker on 15/12/8.
//  Copyright © 2015年 Joker. All rights reserved.
//

#import "ViewController.h"
#import "MyApps.h"
#import "MyCollectionViewCell.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) NSArray *apps;
@end

@implementation ViewController
static NSString *models = @"models";
static NSString *HeaderView = @"headers";
static NSString *FooterView = @"footer";

- (NSArray *)apps {
    if (_apps == nil) {
        NSString *path = [[NSBundle mainBundle]pathForResource:@"apps" ofType:@"plist"];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray *models = [NSMutableArray array];
        for (NSDictionary *dit in array) {
            MyApps *app = [MyApps AppWithDictionary:dit];
            [models addObject:app];
        }
        _apps = models;
    }
    return _apps;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //流布局
    UICollectionViewFlowLayout *flowLayOut = [[UICollectionViewFlowLayout alloc]init];
    //滚动的方向
    [flowLayOut setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    //设置section的页眉，页脚高
    flowLayOut.headerReferenceSize = CGSizeMake(100, 100);
    flowLayOut.footerReferenceSize = CGSizeMake(100, 100);
    
    _collectionView = [[UICollectionView alloc]initWithFrame: CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 20)collectionViewLayout:flowLayOut];
    [self.view addSubview:_collectionView];
    
    _collectionView.backgroundColor = [UIColor greenColor];
    
    //设置数据元 和 代理
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    
    //注册item
    [_collectionView registerNib:[UINib nibWithNibName:@"MyCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:models];
    
    //注册补充视图（头尾）
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeaderView];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:FooterView];
    
    // Do any additional setup after loading the view, typically from a nib.
}


#pragma mark -UICellectionViewDataSoource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 5;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.apps.count;
}

//item内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:models forIndexPath:indexPath];
    
    cell.apps = self.apps[indexPath.item];
    return cell;
}

//设置item的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return CGSizeMake(80, 80);
}
//section整体的缩进
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 10, 0, 10);
}
//section中最小的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}
//section中每个item之间的间距（默认最小值为10）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}



#pragma mark -UICollectionViewDelegate
//允许显示菜单
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.item == 3) {
        return NO;
    }
    return YES;
}
//菜单中包含的操作
- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender{
    if (indexPath.item == 1) {
        if (action == @selector(cut:)) {
            return NO;
        }
    }
    return YES;
}
//处理具体的操作
- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender{
    MyCollectionViewCell *cell = (MyCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (action == @selector(cut:)) {
        NSLog(@"cut%@",cell.Label.text);
    }
    if (action == @selector(copy:)) {
        NSLog(@"copy%@",cell.Label.text);
    }
    if (action == @selector(paste:)) {
        NSLog(@"paste%@",cell.Label.text);
    }
}


#pragma mark -头视图尾视图
//补充视图（头大小） 设置大小之后会覆盖49 50 行的页眉页脚
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(40, 50);
}
//补充视图（尾大小）
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(30, 60);
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reuseableView = nil;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        reuseableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeaderView forIndexPath:indexPath];
        reuseableView.backgroundColor = [UIColor redColor];
    }else if ([kind isEqualToString:UICollectionElementKindSectionFooter]){
        reuseableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:FooterView forIndexPath:indexPath];
        reuseableView.backgroundColor = [UIColor blueColor];
    }
    return reuseableView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
