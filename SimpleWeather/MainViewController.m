//
//  MainViewController.m
//  SimpleWeather
//
//  Created by 徐臻 on 15/1/6.
//  Copyright (c) 2015年 xuzhen. All rights reserved.
//


#import "MainViewController.h"
#import "JHAPISDK.h"
#import "JHOpenidSupplier.h"
#import "SecondViewController.h"
#import "CCLocationManager.h"
#import "SCLAlertView.h"
#import "ZHPickView.h"
#import "MainHeader.h"
#import "MBProgressHUD.h"

@interface MainViewController ()<UIAlertViewDelegate,CLLocationManagerDelegate,ZHPickViewDelegate,UITextFieldDelegate>{
    CLLocationManager *locationmanager;
    NSString* lon;
    NSString* lat;
    ZHPickView *pickview;
    NSArray *colorArr;
    NSInteger colorCount;
    UITextField *txt;
}



@property(nonatomic,strong)NSDictionary *weatherDic;
//@property(nonatomic,strong)NSString *cityString;

@property(nonatomic,strong)UILabel *cityLabel;
@property(nonatomic,strong)UILabel *temperatureLabel;
@property(nonatomic,strong)UILabel *weatherLabel;
@property(nonatomic,strong)UILabel *dryingLabel;
@property(nonatomic,strong)UILabel *windLabel;


@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [NSThread sleepForTimeInterval:1];
    //绑定OpenID
    [[JHOpenidSupplier shareSupplier]registerJuheAPIByOpenId:@"JHdcaf908a57a5d916f086a06d06c7cd9c"];
    colorArr = [NSArray arrayWithObjects:DefaultColor,DefaultGreen,DefaultRed,DefaultYellow,nil];
    
    colorCount = [[[NSUserDefaults standardUserDefaults]objectForKey:@"colorCount"] integerValue];
    
    self.view.backgroundColor = colorArr[colorCount];
    
    NSString *cityString = [[NSUserDefaults standardUserDefaults]objectForKey:@"cityStr"];
    NSLog(@"打开app:%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"cityStr"]);
    if ([self isBlankString:cityString]) {
        cityString = @"武汉";
    }
    NSLog(@"cityString:%@",cityString);
    [self weatherParse:cityString];
    
    [self initButtons];
   // [self getCity];
    if (IS_IOS8) {
        [UIApplication sharedApplication].idleTimerDisabled = TRUE;
        locationmanager = [[CLLocationManager alloc] init];
        [locationmanager requestAlwaysAuthorization];        //NSLocationAlwaysUsageDescription
        [locationmanager requestWhenInUseAuthorization];     //NSLocationWhenInUseDescription
        locationmanager.delegate = self;
    }
}
-(void)initButtons
{
    UIButton *weatherBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    weatherBtn.frame = CGRectMake(10, 34, 50, 44);
    [weatherBtn setImage:[UIImage imageNamed:@"22.png"] forState:UIControlStateNormal];
  [weatherBtn setImage:[UIImage imageNamed:@"22副本.png"] forState:UIControlStateHighlighted];
    [weatherBtn addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:weatherBtn];
    
    UIButton *locateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    locateBtn.frame = CGRectMake(self.view.frame.size.width -58 , 90, 45, 35);
    [locateBtn setImage:[UIImage imageNamed:@"location.png"] forState:UIControlStateNormal];
    [locateBtn setImage:[UIImage imageNamed:@"location2.png"] forState:UIControlStateHighlighted];
    [locateBtn addTarget:self action:@selector(getLat) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:locateBtn];
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = CGRectMake(self.view.frame.size.width - 60, 38, 45, 38);
    [searchBtn setImage:[UIImage imageNamed:@"search.png"] forState:UIControlStateNormal];
    [searchBtn setImage:[UIImage imageNamed:@"search副本.png"] forState:UIControlStateHighlighted];
    [searchBtn addTarget:self action:@selector(locateBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchBtn];
    
    UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    settingBtn.frame = CGRectMake(12, 86, 45, 38);
    [settingBtn setImage:[UIImage imageNamed:@"qwe.png"] forState:UIControlStateNormal];
    [settingBtn setImage:[UIImage imageNamed:@"qwer.png"] forState:UIControlStateHighlighted];
    [settingBtn addTarget:self action:@selector(changeColor) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:settingBtn];
}
-(void)changeColor
{
    colorCount = (colorCount + 1)%4;
    NSNumber *numObj = [NSNumber numberWithInteger:colorCount];
    [[NSUserDefaults standardUserDefaults]setObject:numObj forKey:@"colorCount"];
    
    self.view.backgroundColor = colorArr[colorCount];
}
-(void)getLat
{
    __block __weak MainViewController *wself = self;
    
    if (IS_IOS8) {
        
        [[CCLocationManager shareLocation] getLocationCoordinate:^(CLLocationCoordinate2D locationCorrrdinate) {
            NSLog(@"哈哈 %f %f",locationCorrrdinate.latitude,locationCorrrdinate.longitude);
            lon = [NSString stringWithFormat:@"%f",locationCorrrdinate.longitude];
            lat = [NSString stringWithFormat:@"%f",locationCorrrdinate.latitude];
             [wself GPSWeatherParse];
        }];
    }
   
}
-(void)getCity
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    
    hud.yOffset = -100.f;
    [self.view addSubview:hud];
    hud.detailsLabelText = @"loading...";
    hud.square = YES;
    [hud show:YES];
    
    //绑定OpenID
    [[JHOpenidSupplier shareSupplier]registerJuheAPIByOpenId:@"JHdcaf908a57a5d916f086a06d06c7cd9c"];
    
    NSString *path = @"http://v.juhe.cn/weather/citys";
    NSString *api_id = @"39";
    NSString *method = @"GET";
    NSDictionary *param = [NSDictionary dictionary];
    
    param = @{@"dtype":@"json"};

    JHAPISDK *juheapi = [JHAPISDK shareJHAPISDK];
    
    [juheapi executeWorkWithAPI:path APIID:api_id Parameters:param Method:method Success:^(id responseObject) {
        if ([[param objectForKey:@"dtype"]isEqualToString:@"xml"]) {
            NSLog(@"***xml*** \n%@",responseObject);
        }else
        {
            int error_code = [[responseObject objectForKey:@"error_code"]intValue];
            if (!error_code) {
                [hud hide:YES];
                
                NSArray *resultArr = [responseObject objectForKey:@"result"];
                NSLog(@"resultArr:%@",resultArr);

            }else{
                NSLog(@"%@",responseObject);
            }
        }
    } Failure:^(NSError *error) {
        NSLog(@"error : %@",error.description);
    }];
}
-(void)locateBtnClicked
{
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    
    txt = [alert addTextField:@"Enter search city"];
    txt.delegate = self;
    [alert addButton:@"确定" actionBlock:^(void) {
        NSLog(@"Text value: %@", txt.text);
        if (![self isBlankString:txt.text]) {
            [[NSUserDefaults standardUserDefaults]setObject:txt.text forKey:@"cityStr"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            [self weatherParse:txt.text];
            
        }
    }];
    [alert addButton:@"选择城市" actionBlock:^(void) {
        NSLog(@"Second button tapped");
        [self getPicker];
    }];
    [alert showSuccess:self title:@"天气" subTitle:@"输入查询的城市名" closeButtonTitle:nil duration:0.0f];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [txt resignFirstResponder];
}

-(void)getPicker
{
    NSLog(@"getPicker");
    pickview=[[ZHPickView alloc] initPickviewWithPlistName:@"city" isHaveNavControler:NO];
    pickview.delegate = self;
    
    //调整
    [pickview setPickViewColer:colorArr[colorCount]];
    [pickview setTintColor:[UIColor blackColor]];
    [pickview setToolbarTintColor:colorArr[colorCount]];
    [pickview show];
}
#pragma mark ZhpickVIewDelegate

-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString{
    
    NSLog(@"%@",resultString);
    if (![self isBlankString:resultString]) {
        [[NSUserDefaults standardUserDefaults]setObject:resultString forKey:@"cityStr"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [self weatherParse:resultString];
    }
}

- (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}
-(void)btnClicked
{
    NSLog(@"btnClicked");
    SecondViewController *sec = [[SecondViewController alloc]init];
    sec.weDic = self.weatherDic;
    [self presentViewController:sec animated:NO completion:nil];
}
#pragma mark - 查询天气
-(void)GPSWeatherParse
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    
    hud.yOffset = -100.f;
    [self.view addSubview:hud];
    hud.detailsLabelText = @"loading...";
    hud.square = YES;
    [hud show:YES];
    
    NSLog(@"GPSWeatherParse:%@,%@",lon,lat);
    //绑定OpenID
    [[JHOpenidSupplier shareSupplier]registerJuheAPIByOpenId:@"JHdcaf908a57a5d916f086a06d06c7cd9c"];
    
    NSString *path = @"http://v.juhe.cn/weather/geo";
    NSString *api_id = @"39";
    NSString *method = @"GET";
    NSDictionary *param = [NSDictionary dictionary];
  
    param = @{@"lon":lon,@"lat":lat,@"dtype":@"json"};

    JHAPISDK *juheapi = [JHAPISDK shareJHAPISDK];
    
    [juheapi executeWorkWithAPI:path APIID:api_id Parameters:param Method:method Success:^(id responseObject) {
        if ([[param objectForKey:@"dtype"]isEqualToString:@"xml"]) {
            NSLog(@"***xml*** \n%@",responseObject);
        }else
        {
            int error_code = [[responseObject objectForKey:@"error_code"]intValue];
            if (!error_code) {
                NSDictionary *resultDic = [responseObject objectForKey:@"result"];
                NSLog(@"%@",responseObject);
                [hud hide:YES];
                [self initUI:resultDic];
                self.weatherDic = [NSDictionary dictionary];
                self.weatherDic = resultDic;
            }else{
                NSLog(@"%@",responseObject);
            }
        }
    } Failure:^(NSError *error) {
        NSLog(@"error : %@",error.description);
    }];
}

-(void)weatherParse:(NSString*)cityStr
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
   
    hud.yOffset = -100.f;
    [self.view addSubview:hud];
    hud.detailsLabelText = @"loading...";
    hud.square = YES;
    [hud show:YES];
    
    //绑定OpenID
    [[JHOpenidSupplier shareSupplier]registerJuheAPIByOpenId:@"JHdcaf908a57a5d916f086a06d06c7cd9c"];
    
    NSString *path = @"http://v.juhe.cn/weather/index";
    NSString *api_id = @"39";
    NSString *method = @"GET";
    NSDictionary *param = [NSDictionary dictionary];
    NSString *sti = [[NSUserDefaults standardUserDefaults]objectForKey:@"cityStr"];

        NSLog(@"cityStr:%@",sti);
        param = @{@"cityname":cityStr,@"dtype":@"json"};
    
    JHAPISDK *juheapi = [JHAPISDK shareJHAPISDK];
    
    [juheapi executeWorkWithAPI:path APIID:api_id Parameters:param Method:method Success:^(id responseObject) {
        if ([[param objectForKey:@"dtype"]isEqualToString:@"xml"]) {
            NSLog(@"***xml*** \n%@",responseObject);
        }else
        {
            int error_code = [[responseObject objectForKey:@"error_code"]intValue];
            if (!error_code) {
                NSDictionary *resultDic = [responseObject objectForKey:@"result"];
                NSLog(@"%@",responseObject);
               [hud hide:YES];
                
                [self initUI:resultDic];
                self.weatherDic = [NSDictionary dictionary];
                self.weatherDic = resultDic;
            }else{
                NSLog(@"%@",responseObject);
            }
        }
    } Failure:^(NSError *error) {
        NSLog(@"error : %@",error.description);
    }];
}
-(void)initUI:(NSDictionary*)dict
{
    if (_cityLabel.text != nil) {
        _cityLabel.text = nil;
        _temperatureLabel.text = nil;
        _weatherLabel.text = nil;
        _dryingLabel.text = nil;
        _windLabel.text = nil;
    }
    NSDictionary *todayDic = [dict objectForKey:@"today"];
    //城市
    _cityLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/5, self.view.frame.size.height/4, 200, 100)];
    _cityLabel.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/3 - 80);
    _cityLabel.text = [todayDic objectForKey:@"city"];
    
    [[NSUserDefaults standardUserDefaults]setObject:[todayDic objectForKey:@"city"] forKey:@"cityStr"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    _cityLabel.textColor = [UIColor whiteColor];
    _cityLabel.textAlignment = NSTextAlignmentCenter;
    _cityLabel.font = [UIFont boldSystemFontOfSize:40];
    [self.view addSubview:_cityLabel];
    //温度
    _temperatureLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/5, self.view.frame.size.height/4, 350, 100)];
    _temperatureLabel.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2 );
    _temperatureLabel.text = [todayDic objectForKey:@"temperature"];
    _temperatureLabel.textColor = [UIColor whiteColor];
    _temperatureLabel.textAlignment = NSTextAlignmentCenter;
    _temperatureLabel.font = [UIFont boldSystemFontOfSize:55];
    [self.view addSubview:_temperatureLabel];
    //天气
    _weatherLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/4, self.view.frame.size.height/4, 250, 100)];
    _weatherLabel.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/3 );
    _weatherLabel.text =[todayDic objectForKey:@"weather"];
    _weatherLabel.textColor = [UIColor whiteColor];
    _weatherLabel.textAlignment = NSTextAlignmentCenter;
    _weatherLabel.font = [UIFont boldSystemFontOfSize:30];
    [self.view addSubview:_weatherLabel];
    //干燥度
    _dryingLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/5, self.view.frame.size.height/4, 150, 100)];
    _dryingLabel.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2 + 100 );
    _dryingLabel.text =[todayDic objectForKey:@"dressing_index"];
    _dryingLabel.textColor = [UIColor whiteColor];
    _dryingLabel.textAlignment = NSTextAlignmentCenter;
    _dryingLabel.font = [UIFont boldSystemFontOfSize:30];
    [self.view addSubview:_dryingLabel];
    //风向
    _windLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/5, self.view.frame.size.height/4, 250, 200)];
    _windLabel.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2 + 170 );
    _windLabel.numberOfLines = 0;
    _windLabel.text =[todayDic objectForKey:@"wind"];
    _windLabel.textColor = [UIColor whiteColor];
    _windLabel.textAlignment = NSTextAlignmentCenter;
    _windLabel.font = [UIFont boldSystemFontOfSize:30];
    [self.view addSubview:_windLabel];
    
}


@end
