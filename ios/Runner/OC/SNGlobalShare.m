//
//  SNGlobalShare.m
//  SportNews
//
//  Created by kkk on 2021/3/17.
//

#import "SNGlobalShare.h"

@interface SNGlobalShare ()

@property (strong, nonatomic) NSBundle *imageBundle;

@property (nonatomic, strong) NSCache *cache;

//观看视频时长
@property (nonatomic , assign) NSInteger videoTime;

@property (nonatomic,strong) NSTimer *videoTimer;

@end

@implementation SNGlobalShare


+ (instancetype)sharedInstance {
    static SNGlobalShare *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[SNGlobalShare alloc] init];
    });
    return instance;
}

- (NSArray *)initialImageArray {
    NSMutableArray *imageArray = [[NSMutableArray alloc] init];
    for (int i = 1; i < 6; i++) {
        NSString *imageName = [NSString stringWithFormat:@"火苗雪碧图1_0%d.png", i];
        UIImage *image = [self loadImageWithName:imageName bundle:self.imageBundle];
        [imageArray addObject:image];
    }
    return imageArray;
}

- (NSBundle *)imageBundle {
    if (_imageBundle) {
        return _imageBundle;
    }
    NSString *imageBundlePath = [[NSBundle mainBundle] pathForResource:@"huoImages" ofType:@"bundle"];
    _imageBundle = [NSBundle bundleWithPath:imageBundlePath];
    return _imageBundle;
}

- (UIImage *)loadImageWithName:(NSString *)name bundle:(NSBundle *)bundle {
    NSString *imageKey = [NSString stringWithFormat:@"%@-%@", name, bundle.bundleIdentifier];
    UIImage *image = [self.cache objectForKey:imageKey];
    if (!image) {
        NSString *imagePath = [NSString stringWithFormat:@"%@/%@", bundle.bundlePath, name];
        image = [UIImage imageWithContentsOfFile:imagePath];
        if (!image) {
            NSAssert(image, @"不能为空");
        }
        [self.cache setObject:image forKey:imageKey];
    }
    return image;
}
 
 
 

@end
