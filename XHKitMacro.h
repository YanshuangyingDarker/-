//
//  XKitMacro.h
//  XUIKit
//
//  Created by Xaviar on 15/11/24.
//  Copyright © 2015年 Xaviar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sys/time.h>
#import <pthread.h>

#ifndef XKitMacro_h
#define XKitMacro_h

#ifdef __cplusplus
#define XH_EXTERN_C_BEGIN  extern "C" {
#define XH_EXTERN_C_END  }
#else
#define XH_EXTERN_C_BEGIN
#define XH_EXTERN_C_END
#endif

#ifndef RGB
#define RGB(r,g,b) RGBA(r,g,b,1)
#endif 

#ifndef RGBA
#define RGBA(r,g,b,a) [UIColor \
colorWithRed:r/255.0 \
green:g/255.0 \
blue:b/255.0 alpha:a]
#endif

#define SINGLE_LINE_WIDTH           (1.0 / [UIScreen mainScreen].scale)
#define SINGLE_LINE_ADJUST_OFFSET   ((1.0 / [UIScreen mainScreen].scale) / 2)

#ifndef DEVICE_WIDTH
#define DEVICE_WIDTH [UIScreen mainScreen].bounds.size.width
#endif
#ifndef DEVICE_HEIGHT
#define DEVICE_HEIGHT [UIScreen mainScreen].bounds.size.height
#endif
///usage  CGFloat xPos = 5;
///UIView *view = [[UIView alloc] initWithFrame:CGrect(x - SINGLE_LINE_ADJUST_OFFSET, 0, SINGLE_LINE_WIDTH, 100)];

/*
 *  System Versioning Preprocessor Macros
 */

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


XH_EXTERN_C_BEGIN

#ifndef XH_CLAMP // return the clamped value
#define XH_CLAMP(_x_, _low_, _high_)  (((_x_) > (_high_)) ? (_high_) : (((_x_) < (_low_)) ? (_low_) : (_x_)))
#endif

#ifndef XH_SWAP // swap two value
#define XH_SWAP(_a_, _b_)  do { __typeof__(_a_) _tmp_ = (_a_); (_a_) = (_b_); (_b_) = _tmp_; } while (0)
#endif

#define XAssertNil(condition, description, ...) NSAssert(!(condition), (description), ##__VA_ARGS__)
#define XCAssertNil(condition, description, ...) NSCAssert(!(condition), (description), ##__VA_ARGS__)

#define XAssertNotNil(condition, description, ...) NSAssert((condition), (description), ##__VA_ARGS__)
#define XCAssertNotNil(condition, description, ...) NSCAssert((condition), (description), ##__VA_ARGS__)

#define XAssertMainThread() NSAssert([NSThread isMainThread], @"This method must be called on the main thread")
#define XCAssertMainThread() NSCAssert([NSThread isMainThread], @"This method must be called on the main thread")

#ifdef DEBUG
#ifdef NSLog
#define XHLog(fmt, ...) NSLog(fmt, ##__VA_ARGS__);
#else
#define XHLog(fmt, ...) NSLog(@"\n#TYError ERROR: %s  [Line %d] \n" fmt, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#endif
#else
#define XHLog(...)
#endif

#define PATH_OF_APP_HOME    NSHomeDirectory()
#define PATH_OF_TEMP        NSTemporaryDirectory()
#define PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define PATH_OF_LIBRARY_SUPPORT    [NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES) objectAtIndex:0]

#import <Availability.h>
#undef  __AVAILABILIXH_INTERNAL_WEAK_IMPORT
#define __AVAILABILIXH_INTERNAL_WEAK_IMPORT \
__attribute__((weak_import,deprecated("API newer than Deployment Target.")))


/**
 Add this macro before each category implementation, so we don't have to use
 -all_load or -force_load to load object files from static libraries that only
 contain categories and no classes.
 More info: http://developer.apple.com/library/mac/#qa/qa2006/qa1490.html .
 ******************************************************************************A*
 Example:
 XHSYNTH_DUMMY_CLASS(NSString_XHAdd)
 */
#ifndef XHSYNTH_DUMMY_CLASS
#define XHSYNTH_DUMMY_CLASS(_name_) \
@interface XHSYNTH_DUMMY_CLASS_ ## _name_ : NSObject @end \
@implementation XHSYNTH_DUMMY_CLASS_ ## _name_ @end
#endif


/**
 Synthsize a dynamic object property in @implementation scope.
 It allows us to add custom properties to existing classes in categories.
 
 @param association  ASSIGN / RETAIN / COPY / RETAIN_NONATOMIC / COPY_NONATOMIC
 @warning #import <objc/runtime.h>
 *******************************************************************************
@code
 @interface NSObject (MyAdd)
 @property (nonatomic, retain) UIColor *myColor;
 @end
 
 #import <objc/runtime.h>
 @implementation NSObject (MyAdd)
 XSYNTH_DYNAMIC_PROPERXH_OBJECT(myColor, setMyColor, RETAIN, UIColor *)
 @end
 */
#ifndef XHSYNTH_DYNAMIC_PROPERXH_OBJECT
#define XHSYNTH_DYNAMIC_PROPERXH_OBJECT(_getter_, _setter_, _association_, _type_) \
- (void)_setter_ : (_type_)object { \
[self willChangeValueForKey:@#_getter_]; \
objc_setAssociatedObject(self, _cmd, object, OBJC_ASSOCIATION_ ## _association_); \
[self didChangeValueForKey:@#_getter_]; \
} \
- (_type_)_getter_ { \
return objc_getAssociatedObject(self, @selector(_setter_:)); \
}
#endif

/**
 Synthsize a weak or strong reference.
 
@code
 @weakify(self)
 [self doSomething^{
 @strongify(self)
 if (!self) return;
 ...
 }];
 
 */
#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif

/**
 Profile time cost.
 @param block     code to benchmark
 @param complete  code time cost (millisecond)
 
 Usage:
 XHenchmark(^{
 // code
 }, ^(double ms) {
 NSLog("time cost: %.2f ms",ms);
 });
 
 */
static inline void XHBenchmark(void (^block)(void), void (^complete)(double ms)) {
    // <QuartzCore/QuartzCore.h> version
    /*
     extern double CACurrentMediaTime (void);
     double begin, end, ms;
     begin = CACurrentMediaTime();
     block();
     end = CACurrentMediaTime();
     ms = (end - begin) * 1000.0;
     complete(ms);
     */
    
    // <sys/time.h> version
    struct timeval t0, t1;
    gettimeofday(&t0, NULL);
    block();
    gettimeofday(&t1, NULL);
    double ms = (double)(t1.tv_sec - t0.tv_sec) * 1e3 + (double)(t1.tv_usec - t0.tv_usec) * 1e-3;
    complete(ms);
}

/**
 Get compile timestamp.
 @return NSData
 */
static inline NSDate *XHCompileTime() {
    NSString *timeStr = [NSString stringWithFormat:@"%s %s",__DATE__, __TIME__];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM dd yyyy HH:mm:ss"];
    [formatter setLocale:locale];
    return [formatter dateFromString:timeStr];
}

/**
 Returns a dispatch_time delay from now.
 */
static inline dispatch_time_t dispatch_time_delay(NSTimeInterval second) {
    return dispatch_time(DISPATCH_TIME_NOW, (int64_t)(second * NSEC_PER_SEC));
}

/**
 Whether in main queue/thread.
 */
static inline bool dispatch_is_main_queue() {
    return pthread_main_np() != 0;
}

/**
 Submits a block for asynchronous execution on a main queue and returns immediately.
 */
static inline void dispatch_async_on_main_queue(void (^block)(void)) {
    if (pthread_main_np()) {
        block();
    } else {
        dispatch_async(dispatch_get_main_queue(), block);
    }
}

/**
 Submits a block for execution on a main queue and waits until the block completes.
 */
static inline void dispatch_sync_on_main_queue(void (^block)(void)) {
    if (pthread_main_np()) {
        block();
    } else {
        dispatch_sync(dispatch_get_main_queue(), block);
    }
}

/**
 Initialize a pthread mutex.
 */
static inline void pthread_mutex_init_recursive(pthread_mutex_t *mutex, bool recursive) {
#define XHMUTEX_ASSERT_ON_ERROR(x_) do { \
__unused volatile int res = (x_); \
assert(res == 0); \
} while (0)
    assert(mutex != NULL);
    if (!recursive) {
        XHMUTEX_ASSERT_ON_ERROR(pthread_mutex_init(mutex, NULL));
    } else {
        pthread_mutexattr_t attr;
        XHMUTEX_ASSERT_ON_ERROR(pthread_mutexattr_init (&attr));
        XHMUTEX_ASSERT_ON_ERROR(pthread_mutexattr_settype (&attr, PTHREAD_MUTEX_RECURSIVE));
        XHMUTEX_ASSERT_ON_ERROR(pthread_mutex_init (mutex, &attr));
        XHMUTEX_ASSERT_ON_ERROR(pthread_mutexattr_destroy (&attr));
    }
#undef XHMUTEX_ASSERT_ON_ERROR
}

XH_EXTERN_C_END
#endif
