#import "SWGVerifyresourceApi.h"
#import "SWGQueryParamCollection.h"
#import "SWGApiClient.h"
#import "SWGResponseEntity.h"


@interface SWGVerifyresourceApi ()

@property (nonatomic, strong, readwrite) NSMutableDictionary *mutableDefaultHeaders;

@end

@implementation SWGVerifyresourceApi

NSString* kSWGVerifyresourceApiErrorDomain = @"SWGVerifyresourceApiErrorDomain";
NSInteger kSWGVerifyresourceApiMissingParamErrorCode = 234513;

@synthesize apiClient = _apiClient;

#pragma mark - Initialize methods

- (instancetype) init {
    return [self initWithApiClient:[SWGApiClient sharedClient]];
}


-(instancetype) initWithApiClient:(SWGApiClient *)apiClient {
    self = [super init];
    if (self) {
        _apiClient = apiClient;
        _mutableDefaultHeaders = [NSMutableDictionary dictionary];
    }
    return self;
}

#pragma mark -

-(NSString*) defaultHeaderForKey:(NSString*)key {
    return self.mutableDefaultHeaders[key];
}

-(void) setDefaultHeaderValue:(NSString*) value forKey:(NSString*)key {
    [self.mutableDefaultHeaders setValue:value forKey:key];
}

-(NSDictionary *)defaultHeaders {
    return self.mutableDefaultHeaders;
}

#pragma mark - Api Methods

///
/// charAndNumCode
/// 
///  @returns void
///
-(NSURLSessionTask*) charAndNumCodeUsingGETWithCompletionHandler: 
    (void (^)(NSError* error)) handler {
    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/api/verify/imagecode"];

    NSMutableDictionary *pathParams = [[NSMutableDictionary alloc] init];

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary* headerParams = [NSMutableDictionary dictionaryWithDictionary:self.apiClient.configuration.defaultHeaders];
    [headerParams addEntriesFromDictionary:self.defaultHeaders];
    // HTTP header `Accept`
    NSString *acceptHeader = [self.apiClient.sanitizer selectHeaderAccept:@[@"*/*"]];
    if(acceptHeader.length > 0) {
        headerParams[@"Accept"] = acceptHeader;
    }

    // response content type
    NSString *responseContentType = [[acceptHeader componentsSeparatedByString:@", "] firstObject] ?: @"";

    // request content type
    NSString *requestContentType = [self.apiClient.sanitizer selectHeaderContentType:@[]];

    // Authentication setting
    NSArray *authSettings = @[];

    id bodyParam = nil;
    NSMutableDictionary *formParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *localVarFiles = [[NSMutableDictionary alloc] init];

    return [self.apiClient requestWithPath: resourcePath
                                    method: @"GET"
                                pathParams: pathParams
                               queryParams: queryParams
                                formParams: formParams
                                     files: localVarFiles
                                      body: bodyParam
                              headerParams: headerParams
                              authSettings: authSettings
                        requestContentType: requestContentType
                       responseContentType: responseContentType
                              responseType: nil
                           completionBlock: ^(id data, NSError *error) {
                                if(handler) {
                                    handler(error);
                                }
                            }];
}

///
/// getVerifyCodeByPhone
/// 
///  @param phone phone 
///
///  @returns NSString*
///
-(NSURLSessionTask*) getVerifyCodeByPhoneUsingGETWithPhone: (NSString*) phone
    completionHandler: (void (^)(NSString* output, NSError* error)) handler {
    // verify the required parameter 'phone' is set
    if (phone == nil) {
        NSParameterAssert(phone);
        if(handler) {
            NSDictionary * userInfo = @{NSLocalizedDescriptionKey : [NSString stringWithFormat:NSLocalizedString(@"Missing required parameter '%@'", nil),@"phone"] };
            NSError* error = [NSError errorWithDomain:kSWGVerifyresourceApiErrorDomain code:kSWGVerifyresourceApiMissingParamErrorCode userInfo:userInfo];
            handler(nil, error);
        }
        return nil;
    }

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/api/verify/{phone}"];

    NSMutableDictionary *pathParams = [[NSMutableDictionary alloc] init];
    if (phone != nil) {
        pathParams[@"phone"] = phone;
    }

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary* headerParams = [NSMutableDictionary dictionaryWithDictionary:self.apiClient.configuration.defaultHeaders];
    [headerParams addEntriesFromDictionary:self.defaultHeaders];
    // HTTP header `Accept`
    NSString *acceptHeader = [self.apiClient.sanitizer selectHeaderAccept:@[@"*/*"]];
    if(acceptHeader.length > 0) {
        headerParams[@"Accept"] = acceptHeader;
    }

    // response content type
    NSString *responseContentType = [[acceptHeader componentsSeparatedByString:@", "] firstObject] ?: @"";

    // request content type
    NSString *requestContentType = [self.apiClient.sanitizer selectHeaderContentType:@[]];

    // Authentication setting
    NSArray *authSettings = @[];

    id bodyParam = nil;
    NSMutableDictionary *formParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *localVarFiles = [[NSMutableDictionary alloc] init];

    return [self.apiClient requestWithPath: resourcePath
                                    method: @"GET"
                                pathParams: pathParams
                               queryParams: queryParams
                                formParams: formParams
                                     files: localVarFiles
                                      body: bodyParam
                              headerParams: headerParams
                              authSettings: authSettings
                        requestContentType: requestContentType
                       responseContentType: responseContentType
                              responseType: @"NSString*"
                           completionBlock: ^(id data, NSError *error) {
                                if(handler) {
                                    handler((NSString*)data, error);
                                }
                            }];
}

///
/// smsCode
/// 
///  @param phone phone 
///
///  @returns SWGResponseEntity*
///
-(NSURLSessionTask*) smsCodeUsingGETWithPhone: (NSString*) phone
    completionHandler: (void (^)(SWGResponseEntity* output, NSError* error)) handler {
    // verify the required parameter 'phone' is set
    if (phone == nil) {
        NSParameterAssert(phone);
        if(handler) {
            NSDictionary * userInfo = @{NSLocalizedDescriptionKey : [NSString stringWithFormat:NSLocalizedString(@"Missing required parameter '%@'", nil),@"phone"] };
            NSError* error = [NSError errorWithDomain:kSWGVerifyresourceApiErrorDomain code:kSWGVerifyresourceApiMissingParamErrorCode userInfo:userInfo];
            handler(nil, error);
        }
        return nil;
    }

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/api/verify/smscode"];

    NSMutableDictionary *pathParams = [[NSMutableDictionary alloc] init];

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if (phone != nil) {
        queryParams[@"phone"] = phone;
    }
    NSMutableDictionary* headerParams = [NSMutableDictionary dictionaryWithDictionary:self.apiClient.configuration.defaultHeaders];
    [headerParams addEntriesFromDictionary:self.defaultHeaders];
    // HTTP header `Accept`
    NSString *acceptHeader = [self.apiClient.sanitizer selectHeaderAccept:@[@"*/*"]];
    if(acceptHeader.length > 0) {
        headerParams[@"Accept"] = acceptHeader;
    }

    // response content type
    NSString *responseContentType = [[acceptHeader componentsSeparatedByString:@", "] firstObject] ?: @"";

    // request content type
    NSString *requestContentType = [self.apiClient.sanitizer selectHeaderContentType:@[]];

    // Authentication setting
    NSArray *authSettings = @[];

    id bodyParam = nil;
    NSMutableDictionary *formParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *localVarFiles = [[NSMutableDictionary alloc] init];

    return [self.apiClient requestWithPath: resourcePath
                                    method: @"GET"
                                pathParams: pathParams
                               queryParams: queryParams
                                formParams: formParams
                                     files: localVarFiles
                                      body: bodyParam
                              headerParams: headerParams
                              authSettings: authSettings
                        requestContentType: requestContentType
                       responseContentType: responseContentType
                              responseType: @"SWGResponseEntity*"
                           completionBlock: ^(id data, NSError *error) {
                                if(handler) {
                                    handler((SWGResponseEntity*)data, error);
                                }
                            }];
}

///
/// smsValidate
/// 
///  @param phone phone 
///
///  @param smsCode smsCode 
///
///  @returns NSDictionary<NSString*, NSObject*>*
///
-(NSURLSessionTask*) smsValidateUsingGETWithPhone: (NSString*) phone
    smsCode: (NSString*) smsCode
    completionHandler: (void (^)(NSDictionary<NSString*, NSObject*>* output, NSError* error)) handler {
    // verify the required parameter 'phone' is set
    if (phone == nil) {
        NSParameterAssert(phone);
        if(handler) {
            NSDictionary * userInfo = @{NSLocalizedDescriptionKey : [NSString stringWithFormat:NSLocalizedString(@"Missing required parameter '%@'", nil),@"phone"] };
            NSError* error = [NSError errorWithDomain:kSWGVerifyresourceApiErrorDomain code:kSWGVerifyresourceApiMissingParamErrorCode userInfo:userInfo];
            handler(nil, error);
        }
        return nil;
    }

    // verify the required parameter 'smsCode' is set
    if (smsCode == nil) {
        NSParameterAssert(smsCode);
        if(handler) {
            NSDictionary * userInfo = @{NSLocalizedDescriptionKey : [NSString stringWithFormat:NSLocalizedString(@"Missing required parameter '%@'", nil),@"smsCode"] };
            NSError* error = [NSError errorWithDomain:kSWGVerifyresourceApiErrorDomain code:kSWGVerifyresourceApiMissingParamErrorCode userInfo:userInfo];
            handler(nil, error);
        }
        return nil;
    }

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/api/verify/smsvalidate"];

    NSMutableDictionary *pathParams = [[NSMutableDictionary alloc] init];

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if (phone != nil) {
        queryParams[@"phone"] = phone;
    }
    if (smsCode != nil) {
        queryParams[@"smsCode"] = smsCode;
    }
    NSMutableDictionary* headerParams = [NSMutableDictionary dictionaryWithDictionary:self.apiClient.configuration.defaultHeaders];
    [headerParams addEntriesFromDictionary:self.defaultHeaders];
    // HTTP header `Accept`
    NSString *acceptHeader = [self.apiClient.sanitizer selectHeaderAccept:@[@"*/*"]];
    if(acceptHeader.length > 0) {
        headerParams[@"Accept"] = acceptHeader;
    }

    // response content type
    NSString *responseContentType = [[acceptHeader componentsSeparatedByString:@", "] firstObject] ?: @"";

    // request content type
    NSString *requestContentType = [self.apiClient.sanitizer selectHeaderContentType:@[]];

    // Authentication setting
    NSArray *authSettings = @[];

    id bodyParam = nil;
    NSMutableDictionary *formParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *localVarFiles = [[NSMutableDictionary alloc] init];

    return [self.apiClient requestWithPath: resourcePath
                                    method: @"GET"
                                pathParams: pathParams
                               queryParams: queryParams
                                formParams: formParams
                                     files: localVarFiles
                                      body: bodyParam
                              headerParams: headerParams
                              authSettings: authSettings
                        requestContentType: requestContentType
                       responseContentType: responseContentType
                              responseType: @"NSDictionary<NSString*, NSObject*>*"
                           completionBlock: ^(id data, NSError *error) {
                                if(handler) {
                                    handler((NSDictionary<NSString*, NSObject*>*)data, error);
                                }
                            }];
}



@end
