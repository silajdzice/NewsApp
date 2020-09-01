//
//  DetailsViewModel.swift
//  NewsApp
//
//  Created by Edhem Silajdzic on 30/08/2020.
//  Copyright © 2020 Edhem Silajdzic. All rights reserved.
//

import Foundation

class DetailsViewModel: BaseViewModel{
    
    var article = NewsSource.Article()
    
    static func build() -> DetailsViewModel {
        return DetailsViewModel(service: NetworkService.sharedInstance())
    }
    
}
