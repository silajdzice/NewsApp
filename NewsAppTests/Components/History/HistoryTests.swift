//
//  HistoryTests.swift
//  NewsAppTests
//
//  Created by Edhem Silajdzic on 04/09/2020.
//  Copyright © 2020 Edhem Silajdzic. All rights reserved.
//

import XCTest
@testable import NewsApp

class HistoryTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testOutletConnections() {
        let storyboard = UIStoryboard.historyStoryboard()
        let historyVC: HistoryViewController = storyboard.instantiateViewController(identifier: "HistoryViewController")
        _ = historyVC.view

        XCTAssertNotNil(historyVC.tableView)
    }
    
}
