//
//  BooksTableViewController.m
//  YZXshowshow
//
//  Created by 展祥叶 on 15/9/13.
//  Copyright (c) 2015年 yzx. All rights reserved.
//

#import "BooksTableViewController.h"
#import "BookTableViewCell.h"
#import "Book.h"
#import "BookWebViewController.h"

@interface BooksTableViewController ()
@property(strong,nonatomic)NSMutableArray *books;
@end

@implementation BooksTableViewController

-(NSMutableArray *)books
{
    if (!_books) {
        _books = [[NSMutableArray alloc] init];
    }
    return _books;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *httpUrl = @"http://apis.baidu.com/qunartravel/travellist/travellist";
    NSString *str = @"广州";
    str = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *httpArg =[NSString stringWithFormat:@"query=%@&page=1",str];
    [self request: httpUrl withHttpArg: httpArg];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.books.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BookTableViewCell *cell = [BookTableViewCell initWithBookCell:tableView] ;
    cell.book = self.books[indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 112.0f;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BookTableViewCell *cell = (BookTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    NSString *url = cell.book.bookUrl;
    BookWebViewController *bookWebVC = [[self storyboard] instantiateViewControllerWithIdentifier:@"BookWebViewController"];
    bookWebVC.urlStr = url;
    [self.navigationController pushViewController:bookWebVC animated:YES];
}

- (IBAction)goBackHome:(id)sender {
     [self dismissViewControllerAnimated:YES completion:nil];
}


//获取json数据
-(void)request: (NSString*)httpUrl withHttpArg: (NSString*)HttpArg  {
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, HttpArg];
    NSURL *url = [NSURL URLWithString: urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
    [request setHTTPMethod: @"GET"];
    [request addValue: @"1fd250e4742e82659501fcfb5a05878a" forHTTPHeaderField: @"apikey"];
    [NSURLConnection sendAsynchronousRequest: request
                                       queue: [NSOperationQueue mainQueue]
                           completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error){
                               if (error) {
                                   NSLog(@"Httperror: %@%ld", error.localizedDescription, error.code);
                               } else {
                                   NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
                                   NSLog(@"HttpResponseCode:%ld", responseCode);
                                   
                                   //json
                                   NSError *error = nil;
                                   NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
                                   if(json[@"data"][@"books"])
                                   {
                                       for (NSDictionary *dict in json[@"data"][@"books"]) {
                                           Book *book = [[Book alloc] initWithDictionary:dict];
                                           [self.books addObject:book];
                                       }
                                       [self.tableView reloadData];
                                   }
                               }
                           }];
}

@end
