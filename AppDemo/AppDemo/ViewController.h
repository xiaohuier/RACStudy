//
//  ViewController.h
//  AppDemo
//
//  Created by 周正东 on 2017/12/25.
//  Copyright © 2017年 周正东. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QuestionProtocol <NSObject>
//场次ID
@property (nonatomic, copy) NSString *seeeionID;
//问题编号
@property (nonatomic, copy) NSString *questionNumber;
//问题
@property (nonatomic, copy) NSString *question;
//选项
@property (nonatomic, copy) NSArray<NSString *> *options;
//多少s后显示
@property (nonatomic, assign) NSTimeInterval showDelayTime;
//显示后倒计时多少
@property (nonatomic, assign) NSTimeInterval showTime;
@end

@protocol SDKProtocol <NSObject>
//获取题目
- (void)questionsWillshow:(id<QuestionProtocol>)question;
//获取结果
- (void)answerJudge:(id<QuestionProtocol>)question tureCode:(NSInteger)code;
//判断资格
- (BOOL)judgeAnswerQualify;

@end

@protocol AppProtocol <NSObject>
//答题
- (void)answer:(NSDictionary *)params callBack:(void(^)(void))block;
//复活
- (void)resurrection:(NSDictionary *)params callBack:(void(^)(BOOL success))block;
@end

@interface ViewController : UIViewController


@end

