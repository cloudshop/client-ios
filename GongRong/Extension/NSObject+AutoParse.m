//
//  NSObject+AutoParse.m
//  tuotianClient
//
//  Created by alankong on 15/7/21.
//  Copyright (c) 2015年 TuoTianSuDai. All rights reserved.
//

#import "NSObject+AutoParse.h"
#import <Foundation/NSObjCRuntime.h>
#import <objc/runtime.h>
#import <UIKit/UIKit.h>

@interface ClassPropertyInfo : NSObject

@property (nonatomic, strong) NSString* propertyName;
@property (nonatomic, strong) NSString* buildin;//内建基本数据类型
@property (nonatomic, strong) Class type;//属性类
@property (nonatomic, strong) NSString* protocol;//属性遵循的协议，NSArray中数据的类型

@end
@implementation ClassPropertyInfo

@end

@implementation NSObject (AutoJson)

-(NSDictionary*)toDictionary
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:3];

    Class superClass = [self superclass];
    
    while (![NSStringFromClass(superClass) isEqualToString:@"NSObject"] &&
           ![self.class isSubclassOfClass:[NSString class]] &&
           ![self.class isSubclassOfClass:[NSNumber class]] &&
           ![self.class isSubclassOfClass:[NSValue class]]) {
        [self toDictionary:dic class:superClass];
        superClass = [superClass superclass];
    }
    
    if (![self.class isSubclassOfClass:[NSString class]] &&
        ![self.class isSubclassOfClass:[NSNumber class]] &&
        ![self.class isSubclassOfClass:[NSValue class]])
    {
        [self toDictionary:dic class:[self class]];
    } else {
        dic = nil;//实际为NSString 或者NSNumber
    }
    
    return dic;
}

// 自动解析Json
- (void)parseAutomatically:(NSDictionary *)dicJson
{
    if (!dicJson || [dicJson isKindOfClass:[NSNull class]]) {
        return;
    }
    Class superClass = [self superclass];
    
    while (![NSStringFromClass(superClass) isEqualToString:@"NSObject"]) {
        [self parseAutomatically:dicJson class:superClass];
        superClass = [superClass superclass];
    }
    
    [self parseAutomatically:dicJson class:[self class]];
}

#pragma mark - private methods
-(void)toDictionary:(NSMutableDictionary*)dic class:(Class)class
{
    unsigned int propertyCount;
    objc_property_t *properties = class_copyPropertyList(class, &propertyCount);
    
    for(unsigned int i = 0; i < propertyCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        // 获取数据类型
        ClassPropertyInfo *propertyInfo = [self getVarTypeByProperty:property];
        propertyInfo.propertyName = propertyName;
        
        if (propertyInfo.type == nil) {// 基本数据类型
            id value = [self valueForKey:propertyName];
            
            if ([[value class] isSubclassOfClass:[NSNumber class]] ||
                [[value class] isSubclassOfClass:[NSString class]]) {
                [dic setObject:value forKey:propertyName];
            }
        } else if ([propertyInfo.type isSubclassOfClass:[NSString class]] ||//NSString NSNumber NSDictionary(应该为VO对像)
                   [propertyInfo.type isSubclassOfClass:[NSNumber class]] ||
                   [propertyInfo.type isSubclassOfClass:[NSDictionary class]]) {
            id value = [self valueForKey:propertyName];
            if (value) {
                [dic setObject:value forKey:propertyName];
            }
        } else if ([propertyInfo.type isSubclassOfClass:[NSArray class]]) {
            NSArray *arrItems = [self valueForKey:propertyName];
            
            if (propertyInfo.protocol) {//数组中包含需要解析的对象
                NSMutableArray *arrDest = [NSMutableArray arrayWithCapacity:arrItems.count];
                for (id item in arrItems) {
                    NSDictionary *dicItem = [item toDictionary];
                    if (!dicItem) {
                        dicItem = item;// NSString NSNumber
                    }
                    
                    [arrDest addObject:dicItem];
                }
                
                [dic setObject:arrDest forKey:propertyName];
            } else {
                if (arrItems) {// NSString NSNumber
                    [dic setObject:arrItems forKey:propertyName];
                }
            }
        } else {// 自定义类，需要嵌套解析
            id value = [self valueForKey:propertyName];
            
            NSDictionary *dicItem = [value toDictionary];
            if (dicItem) {
                [dic setObject:dicItem forKey:propertyName];
            }
        }
    }
    
    free(properties);
}

- (void)parseAutomatically:(NSDictionary *)dicJson class:(Class)class
{
    // 如果Json数据无效,产生Sentry Json
    if(dicJson == nil) {
        dicJson = [NSDictionary dictionary];
    }
    
    // 获取property
    unsigned int propertyCount;
    objc_property_t *properties = class_copyPropertyList(class, &propertyCount);
    for(unsigned int i = 0; i < propertyCount; i++) {
        // 获取Var
        objc_property_t property = properties[i];
        NSString* propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        Ivar iVar = class_getInstanceVariable([self class], [propertyName UTF8String]);
        if(iVar == nil) {
            // 采用另外一种方法尝试获取
            iVar = class_getInstanceVariable([self class], [[NSString stringWithFormat:@"_%@", propertyName] UTF8String]);
        }
        
        if (iVar == nil) {
            continue;
        }
        
        // 通过propertyName去Json中寻找Value
        id jsonValue = [dicJson objectForKey:propertyName];//NSString, NSNumber, NSArray, NSDictionary, or NSNull
        
        // 获取数据类型
        ClassPropertyInfo *propertyInfo = [self getVarTypeByProperty:property];
        propertyInfo.propertyName = propertyName;
        
        if ([jsonValue isKindOfClass:[NSNull class]]) {// 空对象，不进行处理，让对象继续保持为nil
        } else if ([jsonValue isKindOfClass:[NSString class]] ||
                   [jsonValue isKindOfClass:[NSNumber class]]) {// NSString, NSNumber
            // 赋值
            [self setIVar:iVar  propertyInfo:propertyInfo value:jsonValue];
        } else if ([jsonValue isKindOfClass:[NSDictionary class]]) {
            // 创建对象
            Class varClass = propertyInfo.type;
            id varObject = [[varClass alloc] init];
            
            // 递归进行下层解析
            [varObject parseAutomatically:jsonValue];
            
            // 赋值
            object_setIvar(self, iVar, varObject);//不需要类型转换
        } else if([jsonValue isKindOfClass:[NSArray class]]) {
            if(propertyInfo.protocol != nil) {
                
                Class objClass = NSClassFromString(propertyInfo.protocol);
                NSArray* arrObjects = [self.class parseArrayAutomatically:jsonValue withObjectClass:objClass];
                
                if (arrObjects) {
                    object_setIvar(self, iVar, arrObjects);
                }
            }  else {
                // NSString, NSNumber类型的数组，并且声明数组没指定类型，直接赋值(最好指定类型，否则没法自动类型转换)
                [self setIVar:iVar  propertyInfo:propertyInfo value:jsonValue];
            }
        }
    }
    
    free(properties);
}

// 自动解析JsonArray
+ (NSArray *)parseArrayAutomatically:(NSArray *)arrJson withObjectClass:(Class)objectClass
{
    NSMutableArray *arrObjects = [NSMutableArray arrayWithCapacity:5];
    
    // 基本数据类型
    if([objectClass isSubclassOfClass:[NSString class]] || [objectClass isSubclassOfClass:[NSNumber class]]) {
        for(NSInteger i = 0; i < [arrJson count]; i++) {
            id item = [arrJson objectAtIndex:i];
            id transformedObj = [self.class tranformObject:item toTypeOfClass:objectClass];
            [arrObjects addObject:transformedObj];
        }
    } else if ([objectClass isSubclassOfClass:[NSNull class]]) {
        //不处理
    } else if ([objectClass isSubclassOfClass:[NSArray class]]) {//数组中包含数组???(不会的吧)
        
    } else {// VO对象
        for(NSInteger i = 0; i < [arrJson count]; i++) {
            id item = [arrJson objectAtIndex:i];
            NSDictionary *dicJsonItem = item;
            id varObject = [[objectClass alloc] init];
            // 递归解析
            [varObject parseAutomatically:dicJsonItem];
            [arrObjects addObject:varObject];
        }
    }
    return arrObjects;
}

/*
NSString 的方法
@property (readonly) double     doubleValue;
@property (readonly) float      floatValue;
@property (readonly) int        intValue;
@property (readonly) NSInteger  integerValue;
@property (readonly) long long  longLongValue;
@property (readonly) BOOL       boolValue;
*/

//设置值前先校验是否可以转换
- (void) setIVar:(Ivar)iVar propertyInfo:(ClassPropertyInfo*)propertyInfo value:(id)valueObj
{
    if (propertyInfo.type != nil) {
        id transFormValue = [self.class tranformObject:valueObj toTypeOfClass:propertyInfo.type];
        object_setIvar(self, iVar, transFormValue);
    } else if ([valueObj isKindOfClass:[NSString class]] || [valueObj isKindOfClass:[NSNumber class]]) {// 支持基本数据类型
        void* address = [self getIvarPointer:propertyInfo.propertyName];
        if ([propertyInfo.buildin isEqualToString:@"c"]) {//NSBool
            char* charAddress = address;
            *charAddress = [valueObj charValue];
        } else if ([propertyInfo.buildin isEqualToString:@"i"]) {
            int* intAddress = address;
            *intAddress = [valueObj intValue];
        } else if ([propertyInfo.buildin isEqualToString:@"s"]) {
            short* shortAddress = address;
            *shortAddress = [valueObj intValue];
        } else if ([propertyInfo.buildin isEqualToString:@"l"]) {
            long* longAddress = address;
            *longAddress = [valueObj integerValue];
        } else if ([propertyInfo.buildin isEqualToString:@"q"]) {
            long long* longLongAddress = address;
            *longLongAddress = [valueObj longLongValue];
        } else if ([propertyInfo.buildin isEqualToString:@"C"]) {
            unsigned char* unsignedCharAddress = address;
            *unsignedCharAddress = [valueObj unsignedCharValue];
        } else if ([propertyInfo.buildin isEqualToString:@"I"]) {
            unsigned int* unsignedIntAddress = address;
            *unsignedIntAddress = [valueObj intValue];
        } else if ([propertyInfo.buildin isEqualToString:@"S"]) {
            unsigned short* unsignedShortAddress = address;
            *unsignedShortAddress = [valueObj shortValue];
        } else if ([propertyInfo.buildin isEqualToString:@"L"]) {
            unsigned long* unsignedLongAddress = address;
            *unsignedLongAddress = [valueObj integerValue];
        } else if ([propertyInfo.buildin isEqualToString:@"Q"]) {
            unsigned long long* unsignedLongLongAddress = address;
            *unsignedLongLongAddress = [valueObj longLongValue];
        } else if ([propertyInfo.buildin isEqualToString:@"f"]) {
            float* floatAddress = address;
            *floatAddress = [valueObj floatValue];
        } else if ([propertyInfo.buildin isEqualToString:@"d"]) {
            double* doubleAddress = address;
            *doubleAddress = [valueObj doubleValue];
        } else if ([propertyInfo.buildin isEqualToString:@"B"]) {
            BOOL* boolAddress = address;
            *boolAddress = [valueObj boolValue];
        } else {
            NSLog(@"unsupport buildin type!!");
        }
    } else {
        NSLog(@"unsupport class type: %@!!", [valueObj class]);
    }
}

- (void*)getIvarPointer:(NSString*)propertyName
{
    if (propertyName.length <= 0) {
        return 0;
    }
    
    Ivar ivar = class_getInstanceVariable(self.class, propertyName.UTF8String);
    if (!ivar) {
        ivar = class_getInstanceVariable(self.class, [[NSString stringWithFormat:@"_%@", propertyName] UTF8String]);
    }
    
    if (!ivar) {
        return 0;
    }
    return (uint8_t*)(__bridge void*)self + ivar_getOffset(ivar);
}

//基本类型转换(NSString NSNumber)
+ (id) tranformObject:(id)object toTypeOfClass:(Class)class
{
    id transformedObject = object;
    
    Class baseClass = [self.class classByResolvingClusterClasses:class];
    Class objBaseClass = [self.class classByResolvingClusterClasses:[object class]];
    
    if (![object isKindOfClass:baseClass]) {
        NSString* selectorName = [NSString stringWithFormat:@"%@From%@:",
                                  class,
                                  objBaseClass];
        //        NSLog(@"transform selector: %@", selectorName);
        SEL selector = NSSelectorFromString(selectorName);
        if ([NSObject respondsToSelector:selector]) {
            transformedObject = [NSObject performSelector:selector withObject:object];
            if (transformedObject) {
                return transformedObject;
            }
        }else{
            NSLog(@"transform value type failed! - class %@", [self class]);
        }
    }
    
    return transformedObject;
}

- (ClassPropertyInfo *)getVarTypeByProperty:(objc_property_t )property
{
    NSString* propertyType = nil;
    ClassPropertyInfo *propertyInfo = [[ClassPropertyInfo alloc] init];
    const char *attrs = property_getAttributes(property);
    NSString* propertyAttributes = @(attrs);
    NSArray* attributeItems = [propertyAttributes componentsSeparatedByString:@","];
    
    // 只读属性read-only
    if ([attributeItems containsObject:@"R"]) {
        return nil;
    }
    
    NSScanner* scanner = [NSScanner scannerWithString: propertyAttributes];
    [scanner scanUpToString:@"T" intoString: nil];
    [scanner scanString:@"T" intoString:nil];
    
    if ([scanner scanString:@"@\"" intoString: &propertyType]) {
        
        [scanner scanUpToCharactersFromSet:[NSCharacterSet characterSetWithCharactersInString:@"\"<"]
                                intoString:&propertyType];
        
        propertyInfo.type = NSClassFromString(propertyType);
        while ([scanner scanString:@"<" intoString:NULL]) {
            
            NSString* protocolName = nil;
            
            [scanner scanUpToString:@">" intoString: &protocolName];
            propertyInfo.protocol = protocolName;
            
            [scanner scanString:@">" intoString:NULL];
        }
    } else if ([scanner scanString:@"{" intoString: &propertyType]) {
        [scanner scanUpToCharactersFromSet:[NSCharacterSet characterSetWithCharactersInString:@"="]
                                intoString:&propertyType];
        propertyInfo.buildin = propertyType;
    } else {
        [scanner scanUpToCharactersFromSet:[NSCharacterSet characterSetWithCharactersInString:@","]
                                intoString:&propertyType];
        propertyInfo.buildin = propertyType;
    }
    
    return propertyInfo;
}

#pragma mark - private methods

+(Class)classByResolvingClusterClasses:(Class)sourceClass
{
    if ([sourceClass isSubclassOfClass:[NSString class]]) {
        return [NSString class];
    }
    
    if ([sourceClass isSubclassOfClass:[NSNumber class]]) {
        return [NSNumber class];
    }
    
    if ([sourceClass isSubclassOfClass:[NSArray class]]) {
        return [NSArray class];
    }
    
    if ([sourceClass isSubclassOfClass:[NSDictionary class]]) {
        return [NSDictionary class];
    }
    
    return sourceClass;
}

#pragma mark - NSMutableString <-> NSString
+(NSMutableString*)NSMutableStringFromNSString:(NSString*)string
{
    return [NSMutableString stringWithString:string];
}

#pragma mark - NSMutableArray <-> NSArray
+(NSMutableArray*)NSMutableArrayFromNSArray:(NSArray*)array
{
    return [NSMutableArray arrayWithArray:array];
}

#pragma mark - NSMutableDictionary <-> NSDictionary
+(NSMutableDictionary*)NSMutableDictionaryFromNSDictionary:(NSDictionary*)dict
{
    return [NSMutableDictionary dictionaryWithDictionary:dict];
}

#pragma mark - string <-> number
+(NSNumber*)NSNumberFromNSString:(NSString*)string
{
    return [NSNumber numberWithFloat: [string doubleValue]];
}

+(NSString*)NSStringFromNSNumber:(NSNumber*)number
{
    return [number stringValue];
}

#pragma mark - string <-> url
+(NSURL*)NSURLFromNSString:(NSString*)string
{
    return [NSURL URLWithString:string];
}

@end