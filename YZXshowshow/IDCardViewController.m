//
//  IDCardViewController.m
//  YZXshowshow
//
//  Created by 展祥叶 on 15/9/14.
//  Copyright (c) 2015年 yzx. All rights reserved.
//

#import "IDCardViewController.h"
#import "IDCard.h"

@interface IDCardViewController ()
@property (weak, nonatomic) IBOutlet UITextField *idcardTF;
@property (weak, nonatomic) IBOutlet UILabel *sexLabel;
@property (weak, nonatomic) IBOutlet UILabel *birthdayLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIView *InfoView;

@end

@implementation IDCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.InfoView.alpha = 0.0f;
}

- (IBAction)queryIDCard:(id)sender {
    NSString *idcard = self.idcardTF.text;
    NSString *httpUrl = @"http://apis.baidu.com/apistore/idservice/id";
    NSString *httpArg = [NSString stringWithFormat:@"id=%@",idcard];
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
                                   NSError *error = nil;
                                   NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
                                   if(json[@"retData"])
                                   {
                                       IDCard *card = [[IDCard alloc] initWithDictionary:json[@"retData"]];
                                       self.InfoView.alpha = 1.0f;
                                       if ([card.sex isEqualToString:@"M"]) {
                                           self.sexLabel.text = @"男";
                                       }else{
                                           self.sexLabel.text = @"女";
                                       }
                                       self.birthdayLabel.text = card.birthday;
                                       self.addressLabel.text = card.address;
                                   }
                                   
                               }
                           }];
}

- (IBAction)gobackHome:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
