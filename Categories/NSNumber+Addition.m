//
// Created by xnxin on 2016/11/2.
// Copyright (c) 2016 RogerLauren. All rights reserved.
//

#import "NSNumber+Addition.h"


@implementation NSNumber (Addition)

- (NSString *)moneyValue {

    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat:@"###,##0.00;"];
    NSString *formattedNumberString = [numberFormatter stringFromNumber:self];
    return formattedNumberString;
}
@end