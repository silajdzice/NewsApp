//
//  DetailsTests.swift
//  NewsAppTests
//
//  Created by Edhem Silajdzic on 04/09/2020.
//  Copyright © 2020 Edhem Silajdzic. All rights reserved.
//

import XCTest
@testable import NewsApp

class DetailsTests: XCTestCase {
    
    var sut: DetailsViewModel? = nil
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = DetailsViewModel(service: NetworkServiceMock.sharedInstance())
        loadArticle()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }
    
    private func loadArticle() {
        let testBundle = Bundle(for: type(of: self))
        guard let filePath = testBundle.path(forResource: "SingleArticle", ofType: "json") else {fatalError("Can't find article.json file")}
        
        let data = try! Data(contentsOf: URL(fileURLWithPath: filePath))
        let article = try! JSONDecoder().decode(NewsSource.Article.self, from: data)
        sut!.article = article
    }
    
    func testOutletConnections() {
        let storyboard = UIStoryboard.detailsStoryboard()
        let detailsVC: DetailsViewController = storyboard.instantiateViewController(identifier: "DetailsViewController")
        _ = detailsVC.view

        XCTAssertNotNil(detailsVC.articleImageView)
        XCTAssertNotNil(detailsVC.contentWrapper)
        XCTAssertNotNil(detailsVC.articleImageViewWrapper)
        XCTAssertNotNil(detailsVC.articleSource)
        XCTAssertNotNil(detailsVC.articleTitle)
        XCTAssertNotNil(detailsVC.textView)

    }
    
    func testArticleTitle() {
        XCTAssertEqual("NHL Highlights | 2nd Round, Game 6: Golden Knights vs. Canucks  Sept 3, 2020  SPORTSNET", sut!.article.title)
    }
    
    func testArticlePublishedAt() {
        XCTAssertEqual("20200904T04:46:44Z", sut!.article.publishedAt)
    }
}
