//
//  People.m
//  SWMultipleDelegateProxyDemo
//
//  Created by zhoushaowen on 2018/7/4.
//  Copyright © 2018年 zhoushaowen. All rights reserved.
//

#import "People.h"

@implementation People

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"%s",__func__);
}


@end
