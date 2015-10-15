//
//  CustomTableViewCell.h
//  GameOfThrones
//
//  Created by tooshyo on 10/15/15.
//  Copyright © 2015 tooshyo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailView;
@property (weak, nonatomic) IBOutlet UILabel *characterName;
@property (weak, nonatomic) IBOutlet UILabel *characterAbstract;



@end
