//
//  News.swift
//  NewsApp
//
//  Created by Edhem Silajdzic on 29/08/2020.
//  Copyright © 2020 Edhem Silajdzic. All rights reserved.
//

import Foundation

struct NewsSource: Decodable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]

    struct Article: Decodable {
        let source: Source
        let author: String?
        let title: String?
        let description: String?
        let url: URL?
        let urlToImage: URL?
        let publishedAt: String?
        let content: String?
        
        init(source: Source? = nil, author: String? = nil,title: String? = nil, description: String? = nil, url: URL? = nil, urlToImage: URL? = nil, publishedAt: String? = nil, content: String? = nil) {
            self.source = source ?? NewsSource.Article.Source.init()
            self.author = author
            self.title = title
            self.description = description
            self.url = url
            self.urlToImage = urlToImage
            self.publishedAt = publishedAt
            self.content = content
        }
        
        struct Source: Decodable {
            let id: String?
            let name: String?
            
            init(id: String? = nil, name: String? = nil) {
                self.id = id
                self.name = name
            }
        }
    }
    
}

struct SelfArticle: Decodable {
    let source: Source
    let author: String?
    let title: String?
    let description: String?
    let url: URL?
    let urlToImage: URL?
    let publishedAt: String?
    let content: String?
    
    init(source: Source? = nil, author: String? = nil,title: String? = nil, description: String? = nil, url: URL? = nil, urlToImage: URL? = nil, publishedAt: String? = nil, content: String? = nil) {
        self.source = source!
        self.author = author
        self.title = title
        self.description = description
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
        self.content = content
    }
}

struct Source: Decodable {
    let id: String?
    let name: String?
    
    init(id: String? = nil, name: String? = nil) {
    self.id = id
    self.name = name
    }
}
