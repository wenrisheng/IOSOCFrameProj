//
//  PinyinHelper.h
//  ChineseSort
//
//  Created by wenrisheng on 15/11/1.
//
//

#import <Foundation/Foundation.h>

#define WSPinyinKey       @"WSPinyinKey"     //  当前模型的字母key
#define WSPinyinValue     @"WSPinyinValue"   //  当前模型的对应的排序数组

@interface PinyinHelper : NSObject

/**
 *  按拼音首字母进行排序并按字母进行分组构建模型
 *
 *  @param sourceArray 需要排序的中英文模型数组
 *  @param propertyName 模型中要排序的属性
 *
 *  @return 排好顺序的模型，返回的是一个NSDictionary,相关的key见上面
 */
+ (NSArray *)sortAndBuildModelForSourceArray:(NSArray *)sourceArray proprtyName:(NSString *)propertyName;

@end
