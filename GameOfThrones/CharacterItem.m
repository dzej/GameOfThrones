//
//  characterItem.m
//  GameOfThrones
//
//  Created by tooshyo on 10/15/15.
//  Copyright © 2015 tooshyo. All rights reserved.
//

#import "CharacterItem.h"

@implementation CharacterItem

- (id) initWithTitle:(NSString *)title {
    self = [super init];
    
    if ( self ){
        self.title = title;
        self.abstract = nil;
        self.thumbnail = nil;
    }
    
    return self;
}

+ (id) blogPostWithTitle:(NSString *)title {
    return [[self alloc] initWithTitle:title];
}

- (NSURL *) thumbnailURL {
    return [NSURL URLWithString:self.thumbnail];
}


@end
