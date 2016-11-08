//
//  SearchService.swift
//  PizzaMe
//
//  Copyright © 2016 Charles Schwab & Co., Inc. All rights reserved.
//

import Foundation

typealias SearchServiceCompletionHandler = (_ response: SearchServiceResponse?, _ error: NSError?) -> Void

class SearchService {
    
    func resultsByZip(zipCode: String, completion: @escaping SearchServiceCompletionHandler) {
        let servicePath = "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20local.search%20where%20zip%3D%27\(zipCode)%27%20and%20query%3D%27pizza%27&format=json&diagnostics=false&callback="
        guard let url = URL(string: servicePath) else {
            return
        }
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil, error as NSError?)
            }
            if let response = response as? HTTPURLResponse {
                guard response.statusCode == 200 else  {
                    completion(nil, error as NSError?)
                    return
                }
                guard let data = data else {
                    completion(nil, error as NSError?)
                    return
                }
                let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
                let response = SearchServiceResponse(response: json as? [String:AnyObject])
                completion(response, nil)
            }
        }
        task.resume()
    }
}
