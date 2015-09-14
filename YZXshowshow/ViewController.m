//
//  ViewController.m
//  YZXshowshow
//
//  Created by 展祥叶 on 15/8/14.
//  Copyright (c) 2015年 yzx. All rights reserved.
//

#import "ViewController.h"
#import "MenuCell.h"
#import "AdMenuCell.h"
#import "UIView+ScaleButton.h"
#import "UIImage+Circle.h"
#import "MenuBtnInfo.h"
#import "NewsViewController.h"
#import "TRWeatherViewController.h"
#import "TaoBaoViewController.h"
#import "QrCodeViewController.h"

#define AD_SECTION 2

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic)UISearchBar *searchBar;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *MenuLayout;

@property (weak, nonatomic) IBOutlet UIImageView *headImage;

@property(strong,nonatomic)NSArray *menuArray;


@end

@implementation ViewController

-(NSArray *)menuArray
{
    if(!_menuArray)
    {
        _menuArray = [MenuBtnInfo ArrayOfMenuBtn];
    }
    return _menuArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 250, 28)];
    bgView.backgroundColor = [UIColor colorWithRed:37 /255.0f green:163 / 255.0f blue:235 / 255.0f alpha:1.0];
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 250, 28)];
    self.searchBar.backgroundColor = [UIColor clearColor];
    self.searchBar.keyboardAppearance = UIKeyboardAppearanceDark;
    self.searchBar.barTintColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0];
    self.searchBar.placeholder = @"请输入查询内容";
    self.searchBar.layer.cornerRadius = 16;
    self.searchBar.layer.masksToBounds = YES;
    [bgView addSubview:self.searchBar];
    self.navigationItem.titleView = bgView;
    
    //设置头像为原形
    self.headImage.image = [UIImage circleImageWithImage:self.headImage.image borderWidth:2 borderColor:[UIColor redColor]];
    
    //注册广告Cell
    [self.collectionView registerNib:[UINib nibWithNibName:@"AdMenuCell" bundle:nil] forCellWithReuseIdentifier:@"AdMenuCell"];
    
    //菜单的间隔
    self.MenuLayout.minimumInteritemSpacing = 0.5f;
    self.MenuLayout.minimumLineSpacing = 0.0f;
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.menuArray.count + 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (AD_SECTION == section) {
        return 1;
    }
    if(section < AD_SECTION)
    {
        NSArray *arr = [NSArray arrayWithArray:self.menuArray[section]];
        return arr.count;
    }
    return 0;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == AD_SECTION)
    {
        AdMenuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AdMenuCell" forIndexPath:indexPath];

        return cell;
    }
    else
    {
        MenuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MenuCell" forIndexPath:indexPath];
        cell.btnInfo = self.menuArray[indexPath.section][indexPath.row];
        [cell.MenuButton setImage:[UIImage imageNamed:cell.btnInfo.imageName] forState:(UIControlStateNormal)];
        cell.MenuButton.userInteractionEnabled = NO;
        cell.MenuLabel.text = cell.btnInfo.btnTitle;
        return cell;
    }
}

//计算菜单按钮的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == AD_SECTION)
        return CGSizeMake(self.view.frame.size.width, 80);
    return CGSizeMake((self.view.frame.size.width - 2) / 4 , self.collectionView.frame.size.height / 3);
}

//控制分区的间隔
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if(section == AD_SECTION)
        return UIEdgeInsetsMake(20, 0,20, 0);
    return UIEdgeInsetsMake(1, 0, 0, 0);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MenuCell *cell = (MenuCell *)[collectionView cellForItemAtIndexPath:indexPath];
    UINavigationController *navController = [UINavigationController new];
    if([cell.btnInfo.btnTitle isEqualToString:@"新闻"])
    {
        navController = [[self storyboard] instantiateViewControllerWithIdentifier:@"newsNavigationController"];
        
    }
    if([cell.btnInfo.btnTitle isEqualToString:@"天气"])
    {
         navController = [[self storyboard] instantiateViewControllerWithIdentifier:@"WeatherNavigationController"];
    }
    if([cell.btnInfo.btnTitle isEqualToString:@"淘宝"])
    {
        navController = [[self storyboard] instantiateViewControllerWithIdentifier:@"taobaoNavigationController"];
        TaoBaoViewController *taobaoVC = (TaoBaoViewController *)navController.topViewController;
        taobaoVC.webURL = @"https://www.taobao.com";
    }
    if([cell.btnInfo.btnTitle isEqualToString:@"天猫"])
    {
        navController = [[self storyboard] instantiateViewControllerWithIdentifier:@"taobaoNavigationController"];
        TaoBaoViewController *taobaoVC = (TaoBaoViewController *)navController.topViewController;
        taobaoVC.webURL = @"https://www.tmall.com/";
    }
    if([cell.btnInfo.btnTitle isEqualToString:@"旅游景点"])
    {
        navController = [[self storyboard] instantiateViewControllerWithIdentifier:@"bookNavigationController"];
    }
    if([cell.btnInfo.btnTitle isEqualToString:@"IP查询"])
    {
        navController = [[self storyboard] instantiateViewControllerWithIdentifier:@"IPNavigationController"];
    }
    if([cell.btnInfo.btnTitle isEqualToString:@"身份证查询"])
    {
        navController = [[self storyboard] instantiateViewControllerWithIdentifier:@"IDCardNavigationController"];
    }
    
    [self presentViewController:navController animated:YES completion:nil];
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section != 3)
    {
        MenuCell *cell = (MenuCell *)[collectionView cellForItemAtIndexPath:indexPath];
        //选中缩放
        [cell.MenuButton startToScale:0.05f];
    }
}

-(void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section != 3)
    {
        MenuCell *cell = (MenuCell *)[collectionView cellForItemAtIndexPath:indexPath];
        //不选中变回原形
        [cell.MenuButton stopToScale:0.3f];
    }
}

//扫一扫
- (IBAction)saomiao:(UIButton *)sender {
    QrCodeViewController *qrVC = [[QrCodeViewController alloc] init];
    [self.navigationController pushViewController:qrVC animated:YES];
}


@end
