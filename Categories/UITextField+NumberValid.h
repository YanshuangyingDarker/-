//
//  UITextField+NumberValid.h
//  BCManagerProject
//
//  Created by sidoufu on 16/9/26.
//  Copyright © 2016年 RogerLauren. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (NumberValid)
- (BOOL)shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
@end
