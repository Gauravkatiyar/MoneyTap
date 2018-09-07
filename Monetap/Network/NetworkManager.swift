//
//  NetworkManager.swift
//
//  Created by Garry Patel on 06/09/18
//  Copyright (c) . All rights reserved.
//


import Foundation
import UIKit
import Alamofire
import SwiftyJSON

typealias RequestCompletion = (_: [String:Any]?, _: AKError?) -> Void


class AKError: Error {
    struct Code {
        static let JSONParse = -100
        static let InvalidJSON = -101
        static let ServerFault = -400
        static let UnexpectedError = -500
    }
    var localizedDescription: String { return _description }
    var code: Int { return _code }
    private var _description: String
    internal var _code: Int
    
    init(code:Int, description: String) {
        self._description = description
        self._code = code
    }
}

class APIManager: NSObject {
    
    static let shared = APIManager()
    
    func request(_ requestPath: String,_ method:HTTPMethod, _ headers: HTTPHeaders?, _ parameters: [String:Any]?, withCompletion response: @escaping RequestCompletion) {
        
        let requestURL = "https://en.wikipedia.org//w/api.php?action=query&format=json&prop=pageimages%7Cpageterms&generator=prefixsearch&redirects=1&formatversion=2&piprop=thumbnail&pithumbsize=60&pilimit=50&wbptterms=description" + requestPath
        
        Alamofire.request(requestURL, method: method, parameters: nil, encoding: JSONEncoding(), headers: headers).responseJSON {
            (responseData) in
            
            var isResponseCallback = false
            var errorCode = AKError.Code.UnexpectedError
            var errorMessage = "Unexpected error from server, please try after sometime"
            
            if responseData.result.isSuccess {
                isResponseCallback = true
                if((responseData.result.value) != nil) {
                    let swiftyJsonVar = JSON(responseData.result.value!)
                    let responseData = swiftyJsonVar.dictionaryObject
                    
                    if let result = responseData {
                        isResponseCallback = true
                        response(result, nil)
                    } else {
                        errorCode = AKError.Code.InvalidJSON
                        errorMessage = "Not a valid json object in response"
                    }
                }
                else {
                    print(responseData.result)
                    errorCode = AKError.Code.InvalidJSON
                    errorMessage = "Not a valid json object in response"
                }
            } else if let error = responseData.error {
                isResponseCallback = true
                let err = AKError.init(code: 4, description: error.localizedDescription )
                response(nil, err)
            }
            
            if(isResponseCallback == false){
                if errorCode == 0 {
                    errorCode = AKError.Code.UnexpectedError
                    errorMessage = "Unexpected error from server, please try after sometime"
                }
                let err = AKError.init(code:errorCode, description:errorMessage)
                isResponseCallback = true
                response(nil, err)
            }
        }
    }
    
}
