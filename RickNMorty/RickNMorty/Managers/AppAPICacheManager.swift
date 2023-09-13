//
//  AppAPICacheManager.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 13.09.2023.
//

import Foundation

/// Manages in memory session scoped API caches
final class AppAPICacheManager {
    // API URL: Data
    private var cacheDictionary: [AppEndpoint: NSCache<NSString,NSData>] = [:]
    // made AppEndpoint hashable to write instead of string
    
    private var cache = NSCache<NSString,NSData> ()

    init() {
        setUpCache()
    }
    
    public func cachedResponse(for endpoint: AppEndpoint, url:URL?) -> Data? {
        guard let targetCache = cacheDictionary[endpoint], let url = url else {return nil}
        
        let key = url.absoluteString as NSString
        return targetCache.object(forKey: key) as? Data
    }
    
    public func setCache(for endpoint: AppEndpoint, url:URL?, data:Data) {
        guard let targetCache = cacheDictionary[endpoint], let url = url else {return}
        
        let key = url.absoluteString as NSString
        targetCache.setObject(data as NSData, forKey: key)
    }
    
    private func setUpCache(){
        AppEndpoint.allCases.forEach { endpoint in
            cacheDictionary[endpoint] = NSCache<NSString,NSData> ()
        }
    }
}
