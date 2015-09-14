//
//  NewsChannelController.m
//  YZXshowshow
//
//  Created by 展祥叶 on 15/8/31.
//  Copyright (c) 2015年 yzx. All rights reserved.
//

#import "NewsChannelController.h"
#import "NewsChannelCell.h"
#import "NewsChannelModel.h"

#define APIKEY @"1fd250e4742e82659501fcfb5a05878a"

@interface NewsChannelController ()<UITableViewDataSource,UITableViewDelegate>
@property(strong,nonatomic)NSMutableArray *channelArray;
@property (weak, nonatomic) IBOutlet UITableView *channelTabel;

@end

@implementation NewsChannelController

//懒加载
-(NSMutableArray *)channelArray
{
    if(!_channelArray)
    {
        _channelArray = [[NSMutableArray alloc] init];
        //接口
        NSString *httpUrl = @"http://apis.baidu.com/showapi_open_bus/channel_news/channel_news";
        NSString *httpArg = @"";
        //加载数据到数组
        [self request: httpUrl withHttpArg: httpArg];
    }

    return _channelArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置tableview代理
    self.channelTabel.dataSource = self;
    self.channelTabel.delegate = self;
}

#pragma mark - 黄金3问

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.channelArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsChannelCell *cell = [NewsChannelCell initNewsChannelCell:tableView];
    NewsChannelModel *model = self.channelArray[indexPath.row];
    cell.textLabel.text = model.name;
    
    return cell;
}

#pragma mark - 接口方法

-(void)request: (NSString*)httpUrl withHttpArg: (NSString*)HttpArg  {
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, HttpArg];
    NSURL *url = [NSURL URLWithString: urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
    [request setHTTPMethod: @"GET"];
    [request addValue: APIKEY forHTTPHeaderField: @"apikey"];
    
    [NSURLConnection sendAsynchronousRequest: request
                                       queue: [NSOperationQueue mainQueue]
                           completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error){
                               if (error) {
                                   NSLog(@"Httperror: %@%ld", error.localizedDescription, error.code);
                               } else {
                                   NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
                                   NSLog(@"HttpResponseCode:%ld", responseCode);
                                   
                                   //转化
                                   NSError *error = nil;
                                   NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
                                  // NSLog(@"%@",json[@"showapi_res_body"][@"channelList"]);
                                  if(json[@"showapi_res_body"][@"channelList"])
                                  {
                                      for (NSDictionary *dict in json[@"showapi_res_body"][@"channelList"]) {
                                          NewsChannelModel *channelModel = [NewsChannelModel channelWithDictionary:dict];
                                          [self.channelArray addObject:channelModel];
                                      }
                                      
                                      [self.channelTabel reloadData];
                                  }
                               }
                           }];
}

//返回首页
- (IBAction)goToHome:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
