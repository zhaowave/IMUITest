//
//  SendMessageView.h
//  Exercise1
//
//  Created by ccis on 16/6/30.
//  Copyright © 2016年 kfzxbj001. All rights reserved.
//

#import <UIKit/UIKit.h>
//使用代理，响应按钮点击事件，在level2中实现这个代理
@protocol SendMessageViewDelegate<NSObject>
@optional
- (void) onSendMessage;
@end

@interface SendMessageView : UIView
@property (strong, nonatomic) UITextField *messageField;
@property (strong, nonatomic) UIButton *sendButton;
@property id<SendMessageViewDelegate> delegate;
- (void) onSend;
@end


