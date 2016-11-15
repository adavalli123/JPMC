//
//  RequestProvider.swift
//  Test
//
//  Created by Srikanth Adavalli on 5/31/16.
//  Copyright © 2016 Srikanth Adavalli. All rights reserved.
//

import Foundation

protocol RequestProvider {
    func getShoppingItemsRequest() -> NSURLRequest?
    func createURLWithComponents(item: Items) -> NSURLRequest?
}

class RequestProviderImpl: RequestProvider {
    func getShoppingItemsRequest() -> NSURLRequest? {
        let urlString: NSMutableURLRequest = NSMutableURLRequest(URL: NSURL(string: "https://itunes.apple.com/search?term=tom+waits")!)
        return NSMutableURLRequest(URL: urlString.URL!)
    }
    
    func createURLWithComponents(item: Items) -> NSURLRequest? {
        let urlComponents = NSURLComponents()
        urlComponents.scheme = "https";
        urlComponents.host = "lyrics.wikia.com";
        urlComponents.path = "/api.php";
        
        let funcQuery = NSURLQueryItem(name: "func", value: "getSong")
        let artistQuery = NSURLQueryItem(name: "artist", value: item.artistName)
        let songQuery = NSURLQueryItem(name: "song", value: item.trackName)
        let formatQuery = NSURLQueryItem(name: "fmt", value: "xml")
        urlComponents.queryItems = [funcQuery, artistQuery, songQuery, formatQuery]
        
        return NSURLRequest(URL: urlComponents.URL!)
    }
}