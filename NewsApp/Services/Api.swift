//
//  Api.swift
//  NewsApp
//
//  Created by Edhem Silajdzic on 29/08/2020.
//  Copyright © 2020 Edhem Silajdzic. All rights reserved.
//

import Foundation

class API {
    static let apiKey = "49c8541b9f824053bf158a85b920dfcf"
    static let baseUrl = "https://newsapi.org/v2/"
    
    enum Endpoint {
        case topHeadlines
        case everything
        
        var endpoint: String {
            switch self {
            case .topHeadlines:
                return "top-headlines"
            case .everything:
                return "everything"
            }
        }
    }
}

class URLComponent {
    enum QueryItem {
        case apiKey
        case q
        case sources
        case language
        case country
        case category
        
        var item: String {
            switch self {
            case .apiKey:
                return "apiKey"
            case .q:
                return "q"
            case .sources:
                return "sources"
            case .language:
                return "language"
            case .country:
                return "country"
            case .category:
                return "category"
            }
        }
    }
    
    static func createQuery(item: QueryItem, and data: String) -> [String: String] {
        return [item.item: data]
    }
    
    static func createQueryItem(item: QueryItem, and data: String) -> URLQueryItem {
        return URLQueryItem(name: item.item, value: data)
    }
}


extension URLComponents {
    mutating func setQueryItems(with parameters: [String: String]) {
        self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
}
