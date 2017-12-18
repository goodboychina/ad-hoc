//
//  main.m
//  wifinetwork
//
//  Created by Apple on 2017/12/18.
//  Copyright © 2017年 PWRD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreWLAN/CoreWLAN.h>
#include <unistd.h>

int main(int argc, const char * argv[])
{
    if (argc != 3)
    {
        printf("usage: ad-hoc interface [on | off]\n");
        exit(1);
    }
    
    NSString *interface = [NSString stringWithUTF8String:argv[1]];
    CWWiFiClient *wificlient = [CWWiFiClient sharedWiFiClient];
    CWInterface *def = [wificlient interfaceWithName: interface];
    
    if (def == nil)
    {
        printf("ad-hoc: interface %s does not exist\n", [interface UTF8String]);
        exit(1);
    }
    
    bool bOn = false;
    if (strcmp(argv[2], "on") == 0)
    {
        bOn = true;
    }
    else if (strcmp(argv[2], "off") == 0)
    {
        bOn = false;
    }
    else
    {
        printf("usage: ad-hoc interface [on | off]\n");
        exit(1);
    }
    

    if (bOn)
    {
        NSString *hostname = [[NSHost currentHost] localizedName];
        NSError *err = nil;
        NSData *ssid = [hostname dataUsingEncoding: NSUTF8StringEncoding];
        BOOL ret = [def startIBSSModeWithSSID:ssid security:kCWIBSSModeSecurityNone channel:11 password:nil error:&err];
        if (ret == NO)
        {
            printf("ad-hoc: %s\n", [[err localizedDescription] UTF8String]);
            exit(1);
        }
    }
    else
    {
        [def disassociate];
    }
    
    return 0;
}
