//
//  TEPagingViewIcon.m
//  TinderPageView
//
//  Created by Timothy Edwards on 09/10/2015.
//  Copyright © 2015 Timothy Edwards. All rights reserved.
//

#import "TESlidingPageViewIcon.h"

@implementation TEPagingViewIcon

-(void)setIconSize:(CGSize)iconSize{
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, iconSize.width, iconSize.height)];
}

-(CGSize)iconSize{
    return self.frame.size;
}

@end
