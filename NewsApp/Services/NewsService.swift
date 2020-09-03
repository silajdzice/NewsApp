//
//  NewsService.swift
//  NewsApp
//
//  Created by Edhem Silajdzic on 29/08/2020.
//  Copyright © 2020 Edhem Silajdzic. All rights reserved.
//

import Foundation
import Alamofire

class NewsService {
    
    let networkService = NetworkService.sharedInstance()
    let countryCode = UserDefaults.standard.getRegionCode()
    
    init() {}

    func getEducationsWith<T: Decodable>(type: String? = API.Endpoint.topHeadlines.endpoint, _ response: T.Type, q: String? = nil, _ sources: String? = nil, _ language: String? = nil, _ category: String? = nil) {

        var urlComponents = URLComponents()
        guard let path = type else {return}
        urlComponents.path = path
        
        var urlQueryItems = [
            URLComponent.createQueryItem(item: .apiKey, and: API.apiKey),
        ]
        if let q = q {
                let query = URLComponent.createQueryItem(item: .q, and: q)
            urlQueryItems.append(query)
        }
        if let sources = sources {
            let query = URLComponent.createQueryItem(item: .sources, and: sources)
            urlQueryItems.append(query)
        }
        if let language = language {
            let query = URLComponent.createQueryItem(item: .language, and: language)
            urlQueryItems.append(query)
        }
        if let category = category {
            let query = URLComponent.createQueryItem(item: .category, and: category)
            urlQueryItems.append(query)
        }

        if path == API.Endpoint.topHeadlines.endpoint {
            let query = URLComponent.createQueryItem(item: .country, and: countryCode)
            urlQueryItems.append(query)
        }
        

        urlComponents.queryItems = urlQueryItems
        let endpoint = API.baseUrl + urlComponents.url!.absoluteString
        networkService.request(endpoint: endpoint, responseType: response.self, httpMethod: .get)
    }
}
