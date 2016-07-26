//
//  SendMessageView.m
//  Exercise1
//
//  Created by ccis on 16/6/30.
//  Copyright © 2016年 kfzxbj001. All rights reserved.
//

#import "SendMessageView.h"

@implementation SendMessageView

- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
        self.layer.borderColor = [[UIColor grayColor] CGColor];
        self.layer.borderWidth = 1.0f;
        _messageField = [[UITextField alloc] initWithFrame:CGRectMake(10, 5, [[UIScreen mainScreen] bounds].size.width - 80, 30)];
        _messageField.backgroundColor = [UIColor whiteColor];
        _messageField.returnKeyType = UIReturnKeySend;
        _messageField.layer.borderColor = [[UIColor whiteColor] CGColor];
        _messageField.layer.borderWidth = 1.0f;
        [_messageField.layer setCornerRadius:6];
        
        _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sendButton = [[UIButton alloc] initWithFrame:CGRectMake(_messageField.frame.size.width + 10 + 2, 5, 70, 30)];
        _sendButton.frame = CGRectMake(_messageField.frame.size.width + 10 + 5, 5, 60, 30);
        _sendButton.userInteractionEnabled = YES;
        //[_sendButton addTarget:self action:@selector(onSendMessage) forControlEvents:UIControlEventTouchDown];
        _sendButton.backgroundColor = [UIColor grayColor];
        [_sendButton.layer setCornerRadius:6.0f];
        [_sendButton setTitle:@"发送" forState:UIControlStateNormal];
        
        [self addSubview:_sendButton];[self addSubview:_messageField];
    }
    return self;
}

- (void) onSend {
    NSLog(@"onSend");
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
