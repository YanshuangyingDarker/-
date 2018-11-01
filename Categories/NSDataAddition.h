//
//  NSData+Addition.h
//  XUIKit
//
//  Created by Xaviar on 15/11/24.
//  Copyright © 2015年 Xaviar. All rights reserved.
//

/**
 Provide hash, encrypt, encode and some common method for `NSData`.
 */

#import <Foundation/Foundation.h>

@interface NSData (Addition)

#pragma mark - Hash
///=============================================================================
/// @name Hash
///=============================================================================
/**
 Returns a lowercase NSString for md5 hash.
 */
- (NSString *)md5String;

/**
 Returns a lowercase NSString for sha1 hash.
 */
- (NSString *)sha1String;

/**
 Returns a lowercase NSString for hmac using algorithm md5 with key.
 @param key  The hmac key.
 */
- (NSString *)hmacMD5StringWithKey:(NSString *)key;

/**
 Returns a lowercase NSString for hmac using algorithm sha1 with key.
 @param key  The hmac key.
 */
- (NSString *)hmacSHA1StringWithKey:(NSString *)key;

/**
 Returns a lowercase NSString for crc32 hash.
 */
- (NSString *)crc32String;

/**
 Returns crc32 hash.
 */
- (uint32_t)crc32;


#pragma mark - Encrypt and Decrypt
///=============================================================================
/// @name Encrypt and Decrypt
///=============================================================================

/**
 Returns an encrypted NSData using AES.
 
 @param key   A key length of 16, 24 or 32 (128, 192 or 256bits).
 
 @param iv    An initialization vector length of 16(128bits).
 Pass nil when you don't want to use iv.
 
 @return      An NSData encrypted, or nil if an error occurs.
 */
- (NSData *)aes256EncryptWithKey:(NSData *)key iv:(NSData *)iv;

/**
 Returns an decrypted NSData using AES.
 
 @param key   A key length of 16, 24 or 32 (128, 192 or 256bits).
 
 @param iv    An initialization vector length of 16(128bits).
 Pass nil when you don't want to use iv.
 
 @return      An NSData decrypted, or nil if an error occurs.
 */
- (NSData *)aes256DecryptWithkey:(NSData *)key iv:(NSData *)iv;


#pragma mark - Encode and decode
///=============================================================================
/// @name Encode and decode
///=============================================================================

/**
 Returns string decoded in UTF8.
 */
- (NSString *)utf8String;

/**
 Returns a uppercase NSString in HEX.
 */
- (NSString *)hexString;

/**
 Returns an NSData from hex string.
 
 @param hexString   The hex string which is case insensitive.
 
 @return a new NSData, or nil if an error occurs.
 */
+ (NSData *)dataWithHexString:(NSString *)hexString;

/**
 Returns an NSString for base64 encoded.
 */
- (NSString *)base64EncodedString;

/**
 Returns an NSData from base64 encoded string.
 
 @warning This method has been implemented in iOS7.
 
 @param base64EncodedString  The encoded string.
 */
+ (NSData *)dataWithBase64EncodedString:(NSString *)base64EncodedString;

/**
 Returns an NSDictionary or NSArray for decoded self.
 Returns nil if an error occurs.
 */
- (id)jsonValueDecoded;


#pragma mark - Inflate and deflate
///=============================================================================
/// @name Inflate and deflate
///=============================================================================

/**
 Decompress data from gzip data.
 @return Inflated data.
 */
- (NSData *)gzipInflate;

/**
 Comperss data to gzip in default compresssion level.
 @return Deflated data.
 */
- (NSData *)gzipDeflate;

/**
 Decompress data from zlib-compressed data.
 @return Inflated data.
 */
- (NSData *)zlibInflate;

/**
 Comperss data to zlib-compressed in default compresssion level.
 @return Deflated data.
 */
- (NSData *)zlibDeflate;


#pragma mark - Others
///=============================================================================
/// @name Others
///=============================================================================

/**
 Create data from the file in main bundle (similar to [UIImage imageNamed:]).
 
 @param name The file name (in main bundle).
 
 @return A new data create from the file.
 */
+ (NSData *)dataNamed:(NSString *)name;

@end
