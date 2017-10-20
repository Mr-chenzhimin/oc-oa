//
//  HGPhotoWall.h
//  PhotoDemo
//
//  Created by Harry on 12-12-6.
//  Copyright (c) 2012年 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HGPhotoWallDelegate <NSObject>

- (void)photoWallPhotoTaped:(NSUInteger)index;
- (void)photoWallMovePhotoFromIndex:(NSInteger)index toIndex:(NSInteger)newIndex;
- (void)photoWallAddAction;
- (void)photoWallAddFinish;
- (void)photoWallDeleteFinish;

@end

@interface HGPhotoWall : UIView

@property (assign) id<HGPhotoWallDelegate> delegate;

@property (strong, nonatomic) NSMutableArray *arrayPhotos;

- (void)setPhotos:(NSArray*)photos;
- (void)setEditModel:(BOOL)canEdit;
- (void)addPhoto:(NSString*)string;

- (void)addPhotoImage:(UIImage *)image;

- (void)deletePhotoByIndex:(NSUInteger)index;

- (void)addPhotoImage:(UIImage *)image withUserData:(NSMutableDictionary *) userData;


@end
