//
//  JSONParser.swift
//  ForecastApp
//
//  Created by Hyung Jip Moon on 2017-05-21.
//  Copyright © 2017 leomoon. All rights reserved.
//

import Foundation

class JSONParser {
    
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    typealias JSON = [String: AnyObject]
    
    //typealias JSONTaskCompletionHandler = (JSON?, DarkSkyError?) -> Void
    typealias JSONDictionaryCompletion = (JSON?) -> Void

    func jsonTask(with request: URLRequest, completionHandler completion: @escaping JSONDictionaryCompletion) -> URLSessionDataTask {
        let task = session.dataTask(with: request) { data, response, error in
            
            // Convert to HTTP Response
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil)
                return
            }
            
            if httpResponse.statusCode == 200 {
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject]
                        completion(json)
                    } catch {
                        completion(nil)
                    }
                } else {
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
        
        return task
    }
}
