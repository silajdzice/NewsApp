//
//  NetworkServiceMock.swift
//  NewsAppTests
//
//  Created by Edhem Silajdzic on 04/09/2020.
//  Copyright © 2020 Edhem Silajdzic. All rights reserved.
//

import Foundation
import Alamofire

class NetworkServiceMock: NetworkService {
    override class func sharedInstance() -> NetworkServiceMock {
        struct __ { static let _sharedInstance = NetworkServiceMock() }
        return __._sharedInstance
    }
    
    override func request<T>(endpoint: String, responseType: T.Type, httpMethod: HTTPMethod = .get, headers: HTTPHeaders? = nil) where T : Decodable {
        let data = try! Data(contentsOf: URL(fileURLWithPath: endpoint))
        let response = try! JSONDecoder().decode(responseType, from: data)
        delegate?.responseSuccess(response)
    }
}
