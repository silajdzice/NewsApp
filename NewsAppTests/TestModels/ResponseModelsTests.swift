//
//  ResponseModelsTests.swift
//  NewsAppTests
//
//  Created by Edhem Silajdzic on 04/09/2020.
//  Copyright © 2020 Edhem Silajdzic. All rights reserved.
//

import XCTest
import Alamofire
@testable import NewsApp

class ResponseModelsTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testNewsModel() throws {
        let testBundle = Bundle(for: type(of: self))
        guard let filePath = testBundle.path(forResource: "News", ofType: "json") else {fatalError("Can't find News.json file")}
        mockNetworkService(filePath, NewsSource.self)
    }
    
    private func mockNetworkService<T: Decodable>(_ filePath: String, _ response: T.Type) {
        let service = NetworkServiceMock.sharedInstance()
        service.delegate = self
        service.request(endpoint: filePath, responseType: response.self)
    }
}


extension ResponseModelsTests: ResponseServiceDelegate {
    func responseSuccess<T>(_ response: T?) where T : Decodable {
        if let res = response as? NewsSource {
            if let status = res.status {
                XCTAssertEqual(status, "ok")
            } else {
              XCTAssert(false)
            }
        }
    }
    
    func responseFailed(_ error: Error?, _ message: String?) {}
}
