//
//  IPViewController.m
//  YZXshowshow
//
//  Created by 展祥叶 on 15/9/14.
//  Copyright (c) 2015年 yzx. All rights reserved.
//

#import "IPViewController.h"
#import "IPModel.h"

@interface IPViewController ()
@property (weak, nonatomic) IBOutlet UITextField *ipText;

//结果
@property (weak, nonatomic) IBOutlet UILabel *countryLabel;
@property (weak, nonatomic) IBOutlet UILabel *provinceLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *districtLabel;
@property (weak, nonatomic) IBOutlet UILabel *carrierLabel;

@property (weak, nonatomic) IBOutlet UIView *queryView;

@end

@implementation IPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.queryView.alpha = 0.0f;
}


- (IBAction)queryIP:(id)sender {
    NSString *IP = self.ipText.text;
    NSString *httpUrl = @"http://apis.baidu.com/apistore/iplookupservice/iplookup";
    NSString *httpArg = [NSString stringWithFormat:@"ip=%@",IP];
    [self request: httpUrl withHttpArg: httpArg];
}

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
                                  //json
                                   NSError *error = nil;
                                   NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
                                   if(json[@"retData"])
                                   {
                                        IPModel *model = [[IPModel alloc] initWithDictionary:json[@"retData"]];
                                        //显示数据
                                       self.queryView.alpha = 1.0f;
                                       self.countryLabel.text = model.country;
                                       self.provinceLabel.text = model.province;
                                       self.cityLabel.text = model.city;
                                       self.districtLabel.text = model.district;
                                       self.carrierLabel.text = model.carrier;
                                   }
                               }
                           }];
}

- (IBAction)goBackHome:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
