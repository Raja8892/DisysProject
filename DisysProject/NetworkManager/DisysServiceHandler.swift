//
//  DisysServiceHandler.swift
//  DisysProject
//
//  Created by Moses on 12/08/19.
//  Copyright © 2019 Raja Inbam. All rights reserved.
//

import Alamofire

class DisysServiceHandler: NSObject {
    
    
    class func loginService(with postData:[String: Any], SuccessCallBack: @escaping (_ result: Bool , _ resposne: [String:Any])-> (), failureCallBack:@escaping (_ error: Error)-> ()){
        
        let headers = [
            "Content-Type":DisysConstant.content_Type,
            "consumer-key":DisysConstant.consumer_key,
            "consumer-secret":DisysConstant.consumer_secret
        ]
        
        Alamofire.request(DisysConstant.URLConstant.loginURL, method: .post, parameters: postData, encoding: URLEncoding.default, headers: headers)
            
            .responseJSON { (response)-> Void in
                response.result.withValue({ (responseValue) in
                    SuccessCallBack(true , response.result.value as? [String:Any] ?? [:])
                })
                
                response.result.ifFailure {
                    let error = response.result.error
                    failureCallBack(error!)
                }
        }
    }
    
    class func getFeedData(SuccessCallBack: @escaping (_ result: Bool, _ response: [String:Any]?) -> (),failureBlock:@escaping (_ error: Error) -> ()) {
        
        let headers = [
            "Content-Type":DisysConstant.content_Type,
            "consumer-key":DisysConstant.consumer_key,
            "consumer-secret":DisysConstant.consumer_secret
        ]
        
        Alamofire.request(DisysConstant.URLConstant.newsFeedURL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers)
            .responseJSON { (response)-> Void in
                
                response.result.withValue({ (responseValue) in
                    SuccessCallBack(true , response.result.value as? [String:Any])
                })

                response.result.ifFailure {
                    let error = response.result.error
                    failureBlock(error!)
                }
        }
    }
    
}
