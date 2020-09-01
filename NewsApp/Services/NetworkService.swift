//
//  NetworkService.swift
//  NewsApp
//
//  Created by Edhem Silajdzic on 29/08/2020.
//  Copyright © 2020 Edhem Silajdzic. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class NetworkService: NSObject {
    
    class func sharedInstance() -> NetworkService {
        struct __ { static let _sharedInstance = NetworkService() }
        return __._sharedInstance
    }
    
    override init() {
        self.session = Session()
    }
    
    weak var delegate: ResponseServiceDelegate?
    var session: Session
    
    func request<T: Decodable>(endpoint: String, responseType: T.Type, httpMethod: HTTPMethod = .get, headers: HTTPHeaders? = nil) {
        session.request(endpoint, method: httpMethod, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: responseType) { response in
                switch response.result {
                    case .failure(let error):
                        guard let responseData = response.data else {return}
                        let message = String(data: responseData, encoding: String.Encoding.utf8)
                            self.delegate?.responseFailed(error, message)
                    case .success(let dataResponse):
                        self.delegate?.responseSuccess(dataResponse)
                }
        }
    }
}

