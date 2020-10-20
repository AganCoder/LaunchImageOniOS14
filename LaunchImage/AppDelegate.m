//
//  AppDelegate.m
//  LaunchImage
//
//  Created by Noah on 2020/10/19.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

/// 系统启动图缓存路径
- (NSString *)launchImageCacheDirectory {

    NSString *bundleID = [NSBundle mainBundle].infoDictionary[@"CFBundleIdentifier"];
    NSFileManager *fm = [NSFileManager defaultManager];

    // iOS13之前
    NSString *cachesDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *snapshotsPath = [[cachesDirectory stringByAppendingPathComponent:@"Snapshots"] stringByAppendingPathComponent:bundleID];
    if ([fm fileExistsAtPath:snapshotsPath]) {
        return snapshotsPath;
    }

    // iOS13
    NSString *libraryDirectory = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
    snapshotsPath = [NSString stringWithFormat:@"%@/SplashBoard/Snapshots/%@ - {DEFAULT GROUP}", libraryDirectory, bundleID];
    if ([fm fileExistsAtPath:snapshotsPath]) {
        return snapshotsPath;
    }

    return nil;
}

/// 系统缓存启动图后缀名
- (BOOL)isSnapShotName:(NSString *)name {
    // 新系统后缀
    NSString *snapshotSuffixs = @".ktx";
    if ([name hasSuffix:snapshotSuffixs]) {
        return YES;
    }
    // 老系统后缀
    snapshotSuffixs = @".png";
    if ([name hasSuffix:snapshotSuffixs]) {
        return YES;
    }
    return NO;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    NSString *path= [self launchImageCacheDirectory];
    NSLog(@"%@", path);

    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:path])
    {

        NSMutableArray *cacheImageNames = [NSMutableArray array];

        for (NSString *name in [fm contentsOfDirectoryAtPath:path error:nil])
        {
            if ([self isSnapShotName:name])
            {
                NSLog(@"name = %@", name);
                [cacheImageNames addObject:name];
            }
        }
    }
    else
    {
        NSLog(@" NOT exist ");
    }


    return YES;
}


@end
