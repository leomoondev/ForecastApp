//
//  JSONParser.swift
//  ForecastApp
//
//  Created by Hyung Jip Moon on 2017-05-21.
//  Copyright © 2017 leomoon. All rights reserved.
//

import Foundation

class JSONParser {
    
    lazy var config: URLSessionConfiguration = URLSessionConfiguration.default
    lazy var session: URLSession = URLSession(configuration: self.config)
    let queryURL: NSURL

    init(url: NSURL) {
        self.queryURL = url
    }
    
    typealias JSON = [String: AnyObject]
    
    typealias JSONDictionaryCompletion = (JSON?) -> Void

    func jsonTask(completion: @escaping JSONDictionaryCompletion) {
        
        let request: NSURLRequest = NSURLRequest(url: queryURL as URL)
        let dataTask = session.dataTask(with: request as URLRequest) {
            ( data, response, error) in
            
            // Check HTTP response for successful GET request
            
            if let httpResponse = response as? HTTPURLResponse {
                
                switch(httpResponse.statusCode) {
                case 200:
                    // Create JSON object w/ data
                    do {
                        let jsonDictionary = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: AnyObject]
                        completion(jsonDictionary)
                        
                    }catch {
                        print("json error: \(error)")
                        
                    }
                default:
                    print("GET request not successful. HTTP status code: \(httpResponse.statusCode)")
                }
                
            } else {
                print("Error: Not a valid HTTP response")
            }
        }
        
        dataTask.resume()
    }
}
