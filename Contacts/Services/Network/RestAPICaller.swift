//
//  RestAPICaller.swift
//  MTTReProject
//
//  Created by Evghenii Nicolaev on 1/29/16.
//  Copyright © 2016 Endava. All rights reserved.
//

import Foundation
import AFNetworking

@objc protocol RestAPIProtocol {
    /**
     * Do an http GET request to url specified
     *
     * @param url String?
     */
    func doGet(url:String, callback:(NSError?, Dictionary<String, AnyObject>?) -> ()) -> NSURLSessionDataTask
    /**
     * Do an http POST request to url specified
     *
     * @param url String?
     * @param data NSData? http body
     */
    optional func doPost(url:String, data:NSData?) -> String
}

class RestAPICaller: NSObject, RestAPIProtocol {
    
    private var sessionManager:AFHTTPSessionManager
    
    override init() {
        sessionManager = AFHTTPSessionManager()
        sessionManager.responseSerializer.acceptableContentTypes = [ "application/json", "text/plain" ]
    }
    
    // MARK: RestAPIProtocol
    func doGet(url:String, callback:(NSError?, Dictionary<String, AnyObject>?) -> ()) -> NSURLSessionDataTask {
        var error:NSError?
        let request = AFJSONRequestSerializer().requestWithMethod("GET", URLString: url, parameters: nil, error: &error)
        
        let task = sessionManager.dataTaskWithRequest(request) { (response, responseObject, error) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                callback(error, responseObject as? Dictionary<String, AnyObject>)
            })
        }
        
        task.resume()
        return task
    }
    
}
