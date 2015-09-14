//
//  TRWeatherViewController.m
//  Day09-03-Weather-UI-V1
//
//  Created by Xiao on 15/6/10.
//  Copyright (c) 2015年 Xiao. All rights reserved.
//

#import "TRWeatherViewController.h"
#import "TRHeadView.h"
#import "TRManager.h"
#import "TRWeather.h"
#import "AFNetworking.h"

#define weatherURL [NSURL URLWithString:@"http://api.worldweatheronline.com/free/v2/weather.ashx?q=guangzhou&num_of_days=5&format=json&tp=4&key=a7bdb4aff27ae387b9db730f56ef4"]

@interface TRWeatherViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UITableView *tableView;

//自定义表header视图
@property (nonatomic, strong) TRHeadView *headerView;

//天气管理类属性
@property (nonatomic, strong) TRManager *weatherManager;



// 屏幕高度
@property (nonatomic, assign)CGFloat screenHeight;

@end

@implementation TRWeatherViewController


#pragma mark -- 懒加载weatherManager
- (TRManager *)weatherManager{
    
    if (!_weatherManager) {
        _weatherManager = [TRManager sharedWeatherDataCenter];
    }
    return _weatherManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    [self initTableView];
    
    //初始化头部view
    [self initHeaderView];
    
}

#pragma mark -- 初始化table view
- (void)initTableView {
    
    //  手动搭建UI
    //  1.  添加背景图片
    UIImage *background = [UIImage imageNamed:@"bg.png"];
    
    self.backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.backgroundImageView.image = background;
    self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:self.backgroundImageView];
    
    
    //  2.  创建TableView
    self.tableView = [UITableView new];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    CGRect bounds = self.view.bounds;
    self.tableView.frame = bounds;
    
    //  分割线的颜色变浅
    self.tableView.separatorColor = [UIColor colorWithWhite:1 alpha:0.2];
    //self.tableView.separatorColor = [UIColor redColor];
    //  把分页打开
    self.tableView.pagingEnabled = YES;
    //  加入主视图
    [self.view addSubview:self.tableView];
}

- (void)initHeaderView {
    
    //  新建一个headerView
    CGRect headerFrame = [UIScreen mainScreen].bounds;
    
//    UIView *header = [[UIView alloc] initWithFrame:headerFrame];
//    header.backgroundColor = [UIColor clearColor];
    
    self.headerView = [[TRHeadView alloc] initWithFrame:headerFrame];
    self.headerView.backgroundColor = [UIColor clearColor];
    
    //  设置为TableView的表头视图
    self.tableView.tableHeaderView = self.headerView;
    
    //获取json数据
    [self getJsonFromURL];
    
    
}


#pragma mark -- 解析后的数据存储到TRManager数组中

- (NSArray *)weatherFromJOSN:(id)json isHourly:(BOOL)isHourly{
    
    NSMutableArray *hourlyResult = [NSMutableArray new];
    NSMutableArray *dailyResult = [NSMutableArray new];
    
    NSDictionary *data = json[@"data"];
    NSArray *weathers = data[@"weather"];
    NSArray *hourly = weathers[0][@"hourly"];
    
    //解析dealsArray中的数据(NSDictionary)； NSDictionary(对象) ===> TRWeather(模型)
    
    //将解析后的每小时数据添加到TRManager的houriyWeathers数组中
    for (NSDictionary *hourlyJSON in hourly) {
        
        TRWeather *hourlyWeathers = [TRWeather weatherWithHourlyJSON:hourlyJSON];
        [hourlyResult addObject:hourlyWeathers];
        
    }
    
    //将解析后的后几天数据添加到TRManager的dailyWeathers数组中
    for (int i = 0; i < weathers.count-1 ; i++ ) {
        
        NSDictionary *dailyJSON = weathers[i+1];
        
        TRWeather *dailyWeathers = [TRWeather weatherWithDailyJSON:dailyJSON];
        [dailyResult addObject:dailyWeathers];
    }
    
    return isHourly ? [hourlyResult copy]:[dailyResult copy];
}


#pragma mark -- 获取json数据
//发送请求获取数据
- (void)getJsonFromURL {
    
    // 发送网络请求
    //  1.准备请求
    NSURLRequest *request = [NSURLRequest requestWithURL:weatherURL];
    
    // 2. 使用AFNetworking来解析json请求
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    // 设定解析器
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"解析过得JSON是：%@",responseObject);
        
        self.weatherManager.houriyWeathers = [self weatherFromJOSN:responseObject isHourly:YES];
        self.weatherManager.dailyWeathers  = [self weatherFromJOSN:responseObject isHourly:NO];

        //在主线程中更新ui
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self updateHeaderViewData: responseObject];
            
            //重新刷新table view
            [self.tableView reloadData];
            
        });

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求发送失败：%@",error);
    }];
    
    // 3. 开始任务
    [operation start];
    
}

#pragma mark -- 更新头部视图的label
- (void)updateHeaderViewData:(NSDictionary *)json {
    
    //更新头部视图的所有数据
    
    //获取解析完的current_condition数据
    TRWeather *weather = [TRWeather weatherWithCurrentJSON:json];
    //当前温度
    self.headerView.tempratureLabel.text = [NSString stringWithFormat:@"%.0f°",weather.temp];
    
    //最高、最低温度
    self.headerView.hiloLabel.text = [NSString stringWithFormat:@"%.0f° / %.0f°",weather.minTemp,weather.maxTemp];
    
    //城市名称
    self.headerView.cityLabel.text = weather.cityName;

    //天气图标
    self.headerView.iconView.image = [UIImage imageNamed:weather.iconName];
    
    //天气描述信息
    self.headerView.conditionLabel.text = weather.weatherDesc;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}


//  将状态栏内的字体颜色变浅
//- (UIStatusBarStyle)preferredStatusBarStyle{
//    return UIStatusBarStyleLightContent;
//}


////  系统改变布局时的响应方法，在这里更新子视图的frame
//- (void)viewWillLayoutSubviews{
//    [super viewWillLayoutSubviews];
//    
//    CGRect bounds = self.view.bounds;
//    
//    self.backgroundImageView.frame = bounds;
//    self.tableView.frame = bounds;
//}

#pragma mark - UITableViewDataSource

//  两部分，一部分是小时预报，一部分是每日预报
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //  TODO: 返回天气预报的数量
    return section == 0 ?
    self.weatherManager.houriyWeathers.count + 1 :
    self.weatherManager.dailyWeathers.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (! cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    //  cell的背景是半透明，文字颜色是白色，cell是不可选的。
    cell.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textColor = [UIColor whiteColor];
    
    
    // 配置不同类型的 Cell
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            //  第一页（小时预报）的标题行
            [self configureHeaderCell:cell title:@"Hourly Forecast"];
        } else {
            //  内容行
            TRWeather *weather = self.weatherManager.houriyWeathers[indexPath.row - 1];
            //  配置小时cell的方法
            [self configureCell:cell weather:weather isHourly:YES];
        }
    } else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            // 第二页（每日天气）的标题行
            [self configureHeaderCell:cell title:@"Daily Forecaset"];
        } else {
            // 每日的内容行
            TRWeather *weather = self.weatherManager.dailyWeathers[indexPath.row - 1];
            // 声明一个自己的配置方法
            [self configureCell:cell weather:weather isHourly:NO];
        }
    }
    
    return cell;
}
        
//  配置标题行
- (void)configureHeaderCell:(UITableViewCell *)cell title:(NSString *)title {
    
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:18];
    cell.textLabel.text = title;
    cell.detailTextLabel.text = @"";
    cell.imageView.image = nil;

}
        
// 配置小时/每天的内容行
- (void)configureCell:(UITableViewCell *)cell weather:(TRWeather *)weather isHourly:(BOOL)isHourly {
    //  配置样式
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
    cell.detailTextLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:18];
    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    //  填充数据
    cell.textLabel.text = isHourly ?
    [NSString stringWithFormat:@"%.0f:00", weather.time] :
    [NSString stringWithFormat:@"%@", weather.date];
    
    //配置天气图片
    cell.imageView.image = [UIImage imageNamed:weather.iconName];;

    cell.detailTextLabel.text = isHourly ?
    [NSString stringWithFormat:@"%.0f°", weather.temp] :
    [NSString stringWithFormat:@"%.0f° / %.0f°", weather.maxTemp, weather.minTemp];

}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger cellCount = [self tableView:tableView numberOfRowsInSection:indexPath.section];
    return self.screenHeight / (CGFloat)cellCount;
}

- (IBAction)goBackHomeMenu:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
