//
//  Connectivity.swift
//  NewsApp
//
//  Created by Edhem Silajdzic on 03/09/2020.
//  Copyright © 2020 Edhem Silajdzic. All rights reserved.
//

import Foundation
import Alamofire

public class Connectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}
