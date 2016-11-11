//
//  PinyinHelper.m
//  ChineseSort
//
//  Created by wenrisheng on 15/11/1.
//
//

#import "PinyinHelper.h"
#import "ChineseString.h"
#import "pinyin.h"

@implementation PinyinHelper

+ (NSArray *)sortAndBuildModelForSourceArray:(NSArray *)sourceArray proprtyName:(NSString *)propertyName
{
    //Step1:获取字符串中文字的拼音首字母并与字符串共同存放
    NSMutableArray *chineseStringsArray=[NSMutableArray array];
    NSInteger count = sourceArray.count;
    for(int i = 0; i < count; i++){
        ChineseString *chineseString=[[ChineseString alloc]init];
        id model = [sourceArray objectAtIndex:i];
        NSString *sortStr;
        if (propertyName.length > 0) {
            sortStr = [model objectForKey:propertyName];
        } else {
            sortStr = model;
        }
        
        // 存放模型
        chineseString.originModel = model;
        
        // 存放原始字符串
        chineseString.string = sortStr;
        if(chineseString.string==nil){
            chineseString.string=@"";
        }
        
        // 存放拼音首字母
        if(![chineseString.string isEqualToString:@""]){
            NSString *pinYinResult=[NSString string];
            for(int j=0;j<chineseString.string.length;j++){
                NSString *singlePinyinLetter=[[NSString stringWithFormat:@"%c",pinyinFirstLetter([chineseString.string characterAtIndex:j])]uppercaseString];
                pinYinResult=[pinYinResult stringByAppendingString:singlePinyinLetter];
            }
            chineseString.pinYin = pinYinResult;
        }else{
            chineseString.pinYin=@"";
        }
        [chineseStringsArray addObject:chineseString];
    }
    
    
    //Step2:按照拼音首字母对这些Strings进行排序
    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"pinYin" ascending:YES]];
    [chineseStringsArray sortUsingDescriptors:sortDescriptors];
    
    //Step3对排好序的数组进行模型构建
    NSMutableArray *sortArray = [NSMutableArray array];
    NSString *curPinYinHead = @"---";;
    for(int i=0;i<[chineseStringsArray count];i++){
        ChineseString *chineseString=[chineseStringsArray objectAtIndex:i];
//        NSString *string = chineseString.string;
        id originModel = chineseString.originModel;
        NSString *pinYin = chineseString.pinYin;
        NSString *singlePinyinLetter = @"";
        if (pinYin.length >= 1) {
            singlePinyinLetter =[pinYin substringToIndex:1];
        }
     
        
        // 如果当前拼音首字母不等于循环模型的拼音首字母，说明当前循环进入到下一个字母的循环
        if (![curPinYinHead isEqualToString:singlePinyinLetter]) {
            NSMutableDictionary *model = [NSMutableDictionary dictionary];
            [model setValue:singlePinyinLetter forKey:WSPinyinKey];
            NSMutableArray *valueArray = [NSMutableArray array];
            [valueArray addObject:originModel];
            [model setValue:valueArray forKey:WSPinyinValue];
            [sortArray addObject:model];
            curPinYinHead = singlePinyinLetter;
            
        // 当前拼音字母还是等于循环模型首字母，说明当前循环还是在原来的首字母序列
        } else {
            NSMutableDictionary *model = [sortArray objectAtIndex:sortArray.count - 1];
            NSMutableArray *valueArray = [model objectForKey:WSPinyinValue];
            [valueArray addObject:originModel];
        }
    }
    
    return sortArray;
    
//    // Step4:如果有需要，再把排序好的内容从ChineseString类中提取出来
//    NSMutableArray *result=[NSMutableArray array];
//    for(int i=0;i<[chineseStringsArray count];i++){
//        [result addObject:((ChineseString*)[chineseStringsArray objectAtIndex:i]).string];
//    }
//    
//    
//    
//    for (int i = 0; i < sortArray.count; i++) {
//        NSDictionary *model = [sortArray objectAtIndex:i];
//        NSString *key = [model objectForKey:@"key"];
//        NSArray *array = [model objectForKey:@"value"];
//        NSString *value =[NSString string];
//        for (int j = 0; j < array.count; j++) {
//            NSString *tempStr = [array objectAtIndex:j];
//            value =  [value stringByAppendingString:tempStr];
//            value = [value stringByAppendingString:@","];
//        }
//        NSLog(@"key:%@ value:%@", key, value);
//    }
}

@end
