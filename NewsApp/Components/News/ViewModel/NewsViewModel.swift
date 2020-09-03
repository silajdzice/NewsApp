//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by Edhem Silajdzic on 29/08/2020.
//  Copyright © 2020 Edhem Silajdzic. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift

class NewsViewModel: BaseViewModel {
    
    let realm = try! Realm()
    var news = [NewsSource.Article]()
    var hotNews = [NewsSource.Article]()
    var output: NewsViewModelOutput?
    var isSearchCalled = false
    
    static func build() -> NewsViewModel {
        return NewsViewModel(service: NetworkService.sharedInstance())
    }
    
    func fetchNews() {
        let service = NewsService()
        service.networkService.delegate = self
        service.getEducationsWith(NewsSource.self)
    }
    
    func fetchSearchedNews(value: String) {
        let service = NewsService()
        service.networkService.delegate = self
        service.getEducationsWith(type: API.Endpoint.everything.endpoint,NewsSource.self, q: value)
    }
    
    func casheArticles(items: NewsSource) {
        deleteNewsFromCashe()
        
        realm.beginWrite()
        for item in items.articles {
            let article = RealmArticle()
            article.arDescription = item.description
            article.title = item.title
            
            article.urlToImage = item.urlToImage?.absoluteString
            article.content = item.content
            
            let sources = RealmSource()
            sources.name = item.source.name
            article.source.append(sources)
            
            realm.add(article)
        }
        
        try! realm.commitWrite()
    }
    
    private func deleteNewsFromCashe() {
        let allNewsObjects = realm.objects(RealmArticle.self)

        try! realm.write {
            realm.delete(allNewsObjects)
        }
    }
}

extension NewsViewModel: ResponseServiceDelegate {
    func responseSuccess<T>(_ response: T?) where T : Decodable {
        hotNews.removeAll()
        news.removeAll()
        if let newsResponse = response as? NewsSource {
            let articles = newsResponse.articles
            for (index, article) in articles.enumerated() {
                let item = NewsSource.Article(source: article.source, author: article.author, title: article.title, description: article.description, url: article.url, urlToImage: article.urlToImage, publishedAt: article.publishedAt, content: article.content)
                if !isSearchCalled {
                    casheArticles(items: newsResponse)
                    if index < 5 {
                        hotNews.append(item)
                    } else {
                        news.append(item)
                    }
                } else {
                    news.append(item)
                }
            }
            output?.reload()
        }
    }
    
    func responseFailed(_ error: Error?, _ message: String?) {
        print("NewsViewModel - \(message ?? "")")
    }
    
}
