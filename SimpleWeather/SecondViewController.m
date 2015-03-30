//
//  SecondViewController.m
//  SimpleWeather
//
//  Created by 徐臻 on 15/1/6.
//  Copyright (c) 2015年 xuzhen. All rights reserved.
//

#import "SecondViewController.h"
#import "JHOpenidSupplier.h"
#import "JHAPISDK.h"
#import "MainHeader.h"
#import <iAd/iAd.h>
@interface SecondViewController ()<ADBannerViewDelegate>

@property(weak,nonatomic)ADBannerView *bannerView;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //绑定OpenID
    [[JHOpenidSupplier shareSupplier]registerJuheAPIByOpenId:@"JHdcaf908a57a5d916f086a06d06c7cd9c"];
    
    NSArray *colorArr = [NSArray arrayWithObjects:DefaultColor,DefaultGreen,DefaultRed,DefaultYellow,nil];
    NSInteger colorCount = [[[NSUserDefaults standardUserDefaults]objectForKey:@"colorCount"] integerValue];
    self.view.backgroundColor = colorArr[colorCount];
    [self initButtons];
    //NSLog(@"weDic:%@",self.weDic);
    [self initUIs];
    
    [self initAD];
    
}
-(void)initAD
{
    ADBannerView *bannerView = [[ADBannerView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 44, kDeviceWidth, 50)];
    bannerView.delegate = self;
    bannerView.alpha = .0f;
    [self.view addSubview:bannerView];
    self.bannerView = bannerView;
    //[self.bannerView setBackgroundColor:[UIColor clearColor]];
}
#pragma mark - ADBannerViewDelegate

//广告即将被加载时调用。所以，这个方法调用的时候广告还没加载进来
- (void)bannerViewDidLoadAd:(ADBannerView *)banner{
    [UIView animateWithDuration:10.5f animations:^{
        self.bannerView.alpha = 1.f;
    }];
}
//方法在广告加载之后调用
- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave{
    NSLog(@"开始调用广告%s", __PRETTY_FUNCTION__);
    return YES;
}
- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error{
    NSLog(@"结束调用广告%s", __PRETTY_FUNCTION__);
    
    [UIView animateWithDuration:0.5f animations:^{
        self.bannerView.alpha = .0f;
        NSLog(@"结束调用了");
    }];
}

-(void)initButtons
{
    UIButton *weatherBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    weatherBtn.frame = CGRectMake(10, 34, 50, 44);
    [weatherBtn setImage:[UIImage imageNamed:@"22.png"] forState:UIControlStateNormal];
    [weatherBtn setImage:[UIImage imageNamed:@"22副本.png"] forState:UIControlStateHighlighted];
    [weatherBtn addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:weatherBtn];
}
-(void)btnClicked
{
    NSLog(@"btnClicked");
    [self dismissViewControllerAnimated:NO completion:nil];
}
-(void)initUIs
{
    NSDictionary *futureDic   = [self.weDic objectForKey:@"future"];
    NSLog(@"futureDic:%@",futureDic);
    NSMutableArray *arr   = [NSMutableArray array];

    NSArray *dic  = [futureDic allKeys] ;
    dic  = [dic sortedArrayUsingComparator:^(id obj1, id obj2)
                           {
                               NSComparisonResult result = [obj2 compare:obj1];
                               switch(result)
                               {
                                   case NSOrderedAscending:
                                       return NSOrderedDescending;
                                   case NSOrderedDescending:
                                       return NSOrderedAscending;
                                   case NSOrderedSame:
                                       return NSOrderedSame;
                                   default:
                                       return NSOrderedSame;
                               } // 时间从近到远（远近相对当前时间而言）
           }];
    arr = [dic copy];
    NSLog(@"%@",arr);
    
    //城市
    UILabel *cityLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/5, self.view.frame.size.height/4, 200, 100)];
    cityLabel.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/3 - 80);
    NSDictionary *todayDic = [self.weDic objectForKey:@"today"];
    cityLabel.text =[todayDic objectForKey:@"city"];
    cityLabel.textColor = [UIColor whiteColor];
    cityLabel.textAlignment = NSTextAlignmentCenter;
    cityLabel.font = [UIFont boldSystemFontOfSize:40];
    [self.view addSubview:cityLabel];
    
    //时间1
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/5, self.view.frame.size.height/4, 80, 80)];
    timeLabel.center = CGPointMake(self.view.frame.size.width/4 - 10, self.view.frame.size.height/3 - 20 );
    NSDictionary *dayDic = [futureDic objectForKey:arr[0]];
    timeLabel.text = @"今天";
    timeLabel.textColor = [UIColor whiteColor];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.font = [UIFont boldSystemFontOfSize:20];
    [self.view addSubview:timeLabel];
    
    UILabel *weatherLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/5, self.view.frame.size.height/4, 80, 80)];
    weatherLabel.center = CGPointMake(self.view.frame.size.width/4 +90, self.view.frame.size.height/3 - 20 );
    weatherLabel.text = [dayDic objectForKey:@"weather"];
    weatherLabel.textColor = [UIColor whiteColor];
    weatherLabel.textAlignment = NSTextAlignmentCenter;
    weatherLabel.font = [UIFont boldSystemFontOfSize:13];
    [self.view addSubview:weatherLabel];
    
    UILabel *temperatureLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/5, self.view.frame.size.height/4, 80, 80)];
    temperatureLabel.center = CGPointMake(self.view.frame.size.width/4 +170, self.view.frame.size.height/3 - 20 );
    temperatureLabel.text = [dayDic objectForKey:@"temperature"];
    temperatureLabel.textColor = [UIColor whiteColor];
    temperatureLabel.textAlignment = NSTextAlignmentCenter;
    temperatureLabel.font = [UIFont boldSystemFontOfSize:13];
    [self.view addSubview:temperatureLabel];
    
    //时间2
    UILabel *timeLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/5, self.view.frame.size.height/4, 80, 80)];
    timeLabel2.center = CGPointMake(self.view.frame.size.width/4 - 10, self.view.frame.size.height/3 + 40 );
    NSDictionary *dayDic2 = [futureDic objectForKey:arr[1]];
    timeLabel2.text = @"明天";
    timeLabel2.textColor = [UIColor whiteColor];
    timeLabel2.textAlignment = NSTextAlignmentCenter;
    timeLabel2.font = [UIFont boldSystemFontOfSize:20];
    [self.view addSubview:timeLabel2];
    
    UILabel *weatherLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/5, self.view.frame.size.height/4, 80, 80)];
    weatherLabel2.center = CGPointMake(self.view.frame.size.width/4 +90, self.view.frame.size.height/3 + 40 );
    weatherLabel2.text = [dayDic2 objectForKey:@"weather"];
    weatherLabel2.textColor = [UIColor whiteColor];
    weatherLabel2.textAlignment = NSTextAlignmentCenter;
    weatherLabel2.font = [UIFont boldSystemFontOfSize:13];
    [self.view addSubview:weatherLabel2];
    
    UILabel *temperatureLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/5, self.view.frame.size.height/4, 80, 80)];
    temperatureLabel2.center = CGPointMake(self.view.frame.size.width/4 +170, self.view.frame.size.height/3 + 40 );
    temperatureLabel2.text = [dayDic2 objectForKey:@"temperature"];
    temperatureLabel2.textColor = [UIColor whiteColor];
    temperatureLabel2.textAlignment = NSTextAlignmentCenter;
    temperatureLabel2.font = [UIFont boldSystemFontOfSize:13];
    [self.view addSubview:temperatureLabel2];
    
    //时间3
    UILabel *timeLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/5, self.view.frame.size.height/4, 80, 80)];
    timeLabel3.center = CGPointMake(self.view.frame.size.width/4 - 10, self.view.frame.size.height/3 + 100 );
    NSDictionary *dayDic3 = [futureDic objectForKey:arr[2]];
    timeLabel3.text = @"后天";
    timeLabel3.textColor = [UIColor whiteColor];
    timeLabel3.textAlignment = NSTextAlignmentCenter;
    timeLabel3.font = [UIFont boldSystemFontOfSize:20];
    [self.view addSubview:timeLabel3];
    
    UILabel *weatherLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/5, self.view.frame.size.height/4, 80, 80)];
    weatherLabel3.center = CGPointMake(self.view.frame.size.width/4 +90, self.view.frame.size.height/3 + 100 );
    weatherLabel3.text = [dayDic3 objectForKey:@"weather"];
    weatherLabel3.textColor = [UIColor whiteColor];
    weatherLabel3.textAlignment = NSTextAlignmentCenter;
    weatherLabel3.font = [UIFont boldSystemFontOfSize:13];
    [self.view addSubview:weatherLabel3];
    
    UILabel *temperatureLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/5, self.view.frame.size.height/4, 80, 80)];
    temperatureLabel3.center = CGPointMake(self.view.frame.size.width/4 +170, self.view.frame.size.height/3 + 100 );
    temperatureLabel3.text = [dayDic3 objectForKey:@"temperature"];
    temperatureLabel3.textColor = [UIColor whiteColor];
    temperatureLabel3.textAlignment = NSTextAlignmentCenter;
    temperatureLabel3.font = [UIFont boldSystemFontOfSize:13];
    [self.view addSubview:temperatureLabel3];
    
    
    //时间4
    UILabel *timeLabel4 = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/5, self.view.frame.size.height/4, 80, 80)];
    timeLabel4.center = CGPointMake(self.view.frame.size.width/4 - 10, self.view.frame.size.height/3 + 160 );
    NSDictionary *dayDic4 = [futureDic objectForKey:arr[3]];
    timeLabel4.text = [dayDic4 objectForKey:@"week"];
    timeLabel4.textColor = [UIColor whiteColor];
    timeLabel4.textAlignment = NSTextAlignmentCenter;
    timeLabel4.font = [UIFont boldSystemFontOfSize:20];
    [self.view addSubview:timeLabel4];
    
    UILabel *weatherLabel4 = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/5, self.view.frame.size.height/4, 80, 80)];
    weatherLabel4.center = CGPointMake(self.view.frame.size.width/4 +90, self.view.frame.size.height/3 + 160 );
    weatherLabel4.text = [dayDic4 objectForKey:@"weather"];
    weatherLabel4.textColor = [UIColor whiteColor];
    weatherLabel4.textAlignment = NSTextAlignmentCenter;
    weatherLabel4.font = [UIFont boldSystemFontOfSize:13];
    [self.view addSubview:weatherLabel4];
    
    UILabel *temperatureLabel4 = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/5, self.view.frame.size.height/4, 80, 80)];
    temperatureLabel4.center = CGPointMake(self.view.frame.size.width/4 +170, self.view.frame.size.height/3 + 160 );
    temperatureLabel4.text = [dayDic4 objectForKey:@"temperature"];
    temperatureLabel4.textColor = [UIColor whiteColor];
    temperatureLabel4.textAlignment = NSTextAlignmentCenter;
    temperatureLabel4.font = [UIFont boldSystemFontOfSize:13];
    [self.view addSubview:temperatureLabel4];
    //时间5
    UILabel *timeLabel5 = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/5, self.view.frame.size.height/4, 80, 80)];
    timeLabel5.center = CGPointMake(self.view.frame.size.width/4 - 10, self.view.frame.size.height/3 + 220 );
    NSDictionary *dayDic5 = [futureDic objectForKey:arr[4]];
    timeLabel5.text = [dayDic5 objectForKey:@"week"];
    timeLabel5.textColor = [UIColor whiteColor];
    timeLabel5.textAlignment = NSTextAlignmentCenter;
    timeLabel5.font = [UIFont boldSystemFontOfSize:20];
    [self.view addSubview:timeLabel5];
    
    UILabel *weatherLabel5 = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/5, self.view.frame.size.height/4, 80, 80)];
    weatherLabel5.center = CGPointMake(self.view.frame.size.width/4 +90, self.view.frame.size.height/3 + 220 );
    weatherLabel5.text = [dayDic5 objectForKey:@"weather"];
    weatherLabel5.textColor = [UIColor whiteColor];
    weatherLabel5.textAlignment = NSTextAlignmentCenter;
    weatherLabel5.font = [UIFont boldSystemFontOfSize:13];
    [self.view addSubview:weatherLabel5];
    
    UILabel *temperatureLabel5 = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/5, self.view.frame.size.height/4, 80, 80)];
    temperatureLabel5.center = CGPointMake(self.view.frame.size.width/4 +170, self.view.frame.size.height/3 + 220 );
    temperatureLabel5.text = [dayDic5 objectForKey:@"temperature"];
    temperatureLabel5.textColor = [UIColor whiteColor];
    temperatureLabel5.textAlignment = NSTextAlignmentCenter;
    temperatureLabel5.font = [UIFont boldSystemFontOfSize:13];
    [self.view addSubview:temperatureLabel5];
    //时间6
    UILabel *timeLabel6 = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/5, self.view.frame.size.height/4, 80, 80)];
    timeLabel6.center = CGPointMake(self.view.frame.size.width/4 - 10, self.view.frame.size.height/3 + 280 );
    NSDictionary *dayDic6 = [futureDic objectForKey:arr[5]];
    timeLabel6.text = [dayDic6 objectForKey:@"week"];
    timeLabel6.textColor = [UIColor whiteColor];
    timeLabel6.textAlignment = NSTextAlignmentCenter;
    timeLabel6.font = [UIFont boldSystemFontOfSize:20];
    [self.view addSubview:timeLabel6];
    
    UILabel *weatherLabel6 = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/5, self.view.frame.size.height/4, 80, 80)];
    weatherLabel6.center = CGPointMake(self.view.frame.size.width/4 +90, self.view.frame.size.height/3 + 280 );
    weatherLabel6.text = [dayDic6 objectForKey:@"weather"];
    weatherLabel6.textColor = [UIColor whiteColor];
    weatherLabel6.textAlignment = NSTextAlignmentCenter;
    weatherLabel6.font = [UIFont boldSystemFontOfSize:13];
    [self.view addSubview:weatherLabel6];
    
    UILabel *temperatureLabel6 = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/5, self.view.frame.size.height/4, 80, 80)];
    temperatureLabel6.center = CGPointMake(self.view.frame.size.width/4 +170, self.view.frame.size.height/3 + 280 );
    temperatureLabel6.text = [dayDic6 objectForKey:@"temperature"];
    temperatureLabel6.textColor = [UIColor whiteColor];
    temperatureLabel6.textAlignment = NSTextAlignmentCenter;
    temperatureLabel6.font = [UIFont boldSystemFontOfSize:13];
    [self.view addSubview:temperatureLabel6];
    //时间7
    UILabel *timeLabel7 = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/5, self.view.frame.size.height/4, 80, 80)];
    timeLabel7.center = CGPointMake(self.view.frame.size.width/4 - 10, self.view.frame.size.height/3 + 340 );
    NSDictionary *dayDic7 = [futureDic objectForKey:arr[6]];
    timeLabel7.text = [dayDic7 objectForKey:@"week"];
    timeLabel7.textColor = [UIColor whiteColor];
    timeLabel7.textAlignment = NSTextAlignmentCenter;
    timeLabel7.font = [UIFont boldSystemFontOfSize:20];
    [self.view addSubview:timeLabel7];
    
    UILabel *weatherLabel7 = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/5, self.view.frame.size.height/4, 80, 80)];
    weatherLabel7.center = CGPointMake(self.view.frame.size.width/4 +90, self.view.frame.size.height/3 + 340 );
    weatherLabel7.text = [dayDic7 objectForKey:@"weather"];
    weatherLabel7.textColor = [UIColor whiteColor];
    weatherLabel7.textAlignment = NSTextAlignmentCenter;
    weatherLabel7.font = [UIFont boldSystemFontOfSize:13];
    [self.view addSubview:weatherLabel7];
    
    UILabel *temperatureLabel7 = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/5, self.view.frame.size.height/4, 80, 80)];
    temperatureLabel7.center = CGPointMake(self.view.frame.size.width/4 +170, self.view.frame.size.height/3 + 340 );
    temperatureLabel7.text = [dayDic7 objectForKey:@"temperature"];
    temperatureLabel7.textColor = [UIColor whiteColor];
    temperatureLabel7.textAlignment = NSTextAlignmentCenter;
    temperatureLabel7.font = [UIFont boldSystemFontOfSize:13];
    [self.view addSubview:temperatureLabel7];
    
}

@end
