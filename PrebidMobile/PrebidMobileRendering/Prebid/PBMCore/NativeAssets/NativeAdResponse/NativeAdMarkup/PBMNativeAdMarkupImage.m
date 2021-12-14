/*   Copyright 2018-2021 Prebid.org, Inc.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import "PBMNativeAdMarkupImage.h"

#import "PBMConstants.h"
#import "PBMLog.h"

@implementation PBMNativeAdMarkupImage

- (instancetype)initWithUrl:(NSString *)url {
    if (!(self = [super init])) {
        return nil;
    }
    _url = [url copy];
    return self;
}

- (nullable instancetype)initWithJsonDictionary:(PBMJsonDictionary *)jsonDictionary
                                          error:(NSError * _Nullable __autoreleasing * _Nullable)error
{
    if (!(self = [super init])) {
        return nil;
    }
    _imageType = jsonDictionary[@"type"];
    _width = jsonDictionary[@"w"];
    _height = jsonDictionary[@"h"];
    _url = [jsonDictionary[@"url"] copy];
    _ext = jsonDictionary[@"ext"];
    
    if (!_url) {
        PBMLogWarn(@"Required property 'url' is absent in jsonDict for nativeAsset.image");
    }
    if (error) {
        *error = nil;
    }
    return self;
}

- (BOOL)isEqual:(id)object {
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    PBMNativeAdMarkupImage *other = object;
    BOOL (^ const objComparator)(id (^)(id)) = ^BOOL(id (^extractor)(id)) {
        id lhs = extractor(self);
        id rhs = extractor(other);
        return (lhs == nil) ? (rhs == nil) : [lhs isEqual:rhs];
    };
    return ((self == other)
            || (self.imageType == other.imageType
                && objComparator(^(PBMNativeAdMarkupImage *src) { return src.width; })
                && objComparator(^(PBMNativeAdMarkupImage *src) { return src.height; })
                && objComparator(^(PBMNativeAdMarkupImage *src) { return src.url; })
                && objComparator(^(PBMNativeAdMarkupImage *src) { return src.ext; })
                )
            );
}

@end