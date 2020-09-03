//
//  ViewModelBase.swift
//  NewsApp
//
//  Created by Edhem Silajdzic on 29/08/2020.
//  Copyright © 2020 Edhem Silajdzic. All rights reserved.
//

import Foundation

class BaseViewModel {
    var networkService: NetworkService
    
    init(service: NetworkService) {
        self.networkService = service
    }
}
