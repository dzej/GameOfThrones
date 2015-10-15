//
//  characterItem.h
//  GameOfThrones
//
//  Created by tooshyo on 10/15/15.
//  Copyright © 2015 tooshyo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CharacterItem : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *abstract;
@property (nonatomic, strong) NSString *thumbnail;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSURL *url;

// Designated Initializer
- (id) initWithTitle:(NSString *)title;
+ (id) blogPostWithTitle:(NSString *)title;

- (NSURL *) thumbnailURL;

@end