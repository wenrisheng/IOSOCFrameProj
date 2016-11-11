//
//  WSFileUtil.m
//  WSBase
//
//  Created by wrs on 15/7/7.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import "WSFileUtil.h"

@implementation WSFileUtil

+ (NSString *)getResourcePathInBundleWithName:(NSString *)name type:(NSString *)type
{
    NSString *resourcePath = [[NSBundle mainBundle] pathForResource:name ofType:type];
    return resourcePath;
}

+ (BOOL)createDirectoryAtPath:(NSString *)dirPath{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDirectory;
    if(![fileManager fileExistsAtPath:dirPath isDirectory:&isDirectory]){//如果不存在则创建目录
        return [fileManager createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    if (!isDirectory) {//存在但不是目录
        return NO;
    }
    
    return YES;
}

+ (BOOL)createFileAtPath:(NSString *)path withContent:(NSData *)content{
    NSString *dirPath = [path stringByDeletingLastPathComponent];
    if ([WSFileUtil createDirectoryAtPath:dirPath]) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        return [fileManager createFileAtPath:path contents:content attributes:nil];
    }
    
    return NO;
}

+ (BOOL)appendToFileAtPath:(NSString *)path withContent:(NSData *)content{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDirectory;
    if ([fileManager fileExistsAtPath:path isDirectory:&isDirectory]) {
        if (isDirectory) {
            return NO;
        }
    } else {
        return [WSFileUtil createFileAtPath:path withContent:content];
    }
    
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:path];
    [fileHandle seekToEndOfFile];
    [fileHandle writeData:content];
    [fileHandle closeFile];
    return YES;
}

+ (BOOL)deleteFileAtPath:(NSString *)path
{
     NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL fileExist = [fileManager fileExistsAtPath:path];
    if (fileExist) {
        NSError *err;
       return [fileManager removeItemAtPath:path error:&err];
    } else {
        return YES;
    }
}

+ (NSString *)getItemNameAtPath:(NSString *)path{
    if ([path hasSuffix:@"/"]) {
        path = [path substringToIndex:path.length - 1];
    }
    NSRange range = [path rangeOfString:@"/" options:NSBackwardsSearch];
    if (range.location != NSNotFound) {
        return [path substringFromIndex:range.location + 1];
    }
    
    return path;
}

+ (NSString *)getExtOfFile:(NSString *)filePath{
    NSString *fileName = [WSFileUtil getItemNameAtPath:filePath];
    NSRange range = [fileName rangeOfString:@"." options:NSBackwardsSearch];
    if (range.location != NSNotFound) {
        return [fileName substringFromIndex:range.location + 1];
    }
    
    return @"";
}

+ (NSString *)getMIMETypeWithExt:(NSString *)ext{
    ext = [ext lowercaseString];
    if ([ext isEqualToString:@"pdf"]) {
        return @"application/pdf";
    } else if ([ext isEqualToString:@"doc"]) {
        return @"application/msword";
    } else if ([ext isEqualToString:@"docx"]) {
        return @"application/vnd.openxmlformats-officedocument.wordprocessingml.document";
    } else if ([ext isEqualToString:@"xls"]) {
        return @"application/vnd.ms-excel";
    } else if ([ext isEqualToString:@"xlsx"]) {
        return @"application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
    } else if ([ext isEqualToString:@"ppt"]) {
        return @"application/mspowerpoint";
    } else if ([ext isEqualToString:@"pptx"]) {
        return @"application/vnd.openxmlformats-officedocument.presentationml.presentation";
    } else if ([ext isEqualToString:@"bmp"]) {
        return @"application/x-bmp";
    } else if ([ext isEqualToString:@"ico"]) {
        return @"application/x-icon";
    } else if ([ext isEqualToString:@"jpg"] || [ext isEqualToString:@"jpeg"]) {
        return @"image/jpeg";
    } else if ([ext isEqualToString:@"png"]) {
        return @"image/png";
    } else if ([ext isEqualToString:@"gif"]) {
        return @"image/gif";
    } else if ([ext isEqualToString:@"txt"]) {
        return @"text/plain";
    } else if ([ext isEqualToString:@"rtf"]) {
        return @"application/rtf";
    } else if ([ext isEqualToString:@"html"] || [ext isEqualToString:@"htm"]) {
        return @"text/html";
    } else if ([ext isEqualToString:@"xml"]) {
        return @"text/xml";
    } else if ([ext isEqualToString:@"xhtml"]) {
        return @"application/xhtml+xml";
    } else {
        return nil;
    }
}

+ (BOOL)createFileAtFilePath:(NSString *)filePath contents:(NSData *)data attributes:(NSDictionary<NSString *,id> *)attr
{
    
    NSArray *pathArray = [filePath componentsSeparatedByString:@"/"];
    NSString *fileName = [pathArray lastObject];
    NSString *dirPath = [filePath substringToIndex:(filePath.length - fileName.length)];
    
    // 判断文件夹是否存在，不存在就创建
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL dirExit = [fileManager fileExistsAtPath:dirPath isDirectory:(&isDir)];
    if (!dirExit || !isDir) {
        NSError *error = nil;
        [fileManager createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            NSLog(@"创建文件夹失败！:%@", error);
            return NO;
        }
    }
    
    BOOL createSuc = [fileManager createFileAtPath:filePath contents:data attributes:attr];
    return createSuc;
}

+ (NSString *)getFileContentInBundleWithResource:(NSString *)name ofType:(NSString *)ext
{
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSString *filePath = [mainBundle pathForResource:name ofType:ext];
   return [self getFileContentWithFilePath:filePath];
}

+ (NSString *)getFileContentWithFilePath:(NSString *)filePath
{
    NSError *readFileError = nil;
    NSString *fileContent = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&readFileError];
    if (readFileError) {
        NSLog(@"读取文件错误：%@", readFileError);
    }
    return fileContent;
}

@end
