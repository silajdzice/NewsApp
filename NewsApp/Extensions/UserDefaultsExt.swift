//
//  UserDefaultsExt.swift
//  NewsApp
//
//  Created by Edhem Silajdzic on 01/09/2020.
//  Copyright © 2020 Edhem Silajdzic. All rights reserved.
//

import Foundation

extension UserDefaults {
    enum UserDefaultKeys: String {
        case regionCode
        case regionCodeForSearch
    }
    
    func getRegionCode() -> String {
        if let token = string(forKey: UserDefaultKeys.regionCode.rawValue) {
            return token
        }
        return ""
    }
    
    func setRegionCode(value: String?) {
        set(value, forKey: UserDefaultKeys.regionCode.rawValue)
        synchronize()
    }
    
//    func getRegionCodeForSearch() -> String {
//        if let token = string(forKey: UserDefaultKeys.regionCodeForSearch.rawValue) {
//            return token
//        }
//        return ""
//    }
//    
//    func setRegionCodeForSearch(value: String?) {
//        set(value, forKey: UserDefaultKeys.regionCodeForSearch.rawValue)
//        synchronize()
//    }
}

/**
 Example of using this extenstion:
 for setting login state:
 UserDefaults.standard.setLoginStatus(value: true)
 
 for getting login state:
 UserDefaults.standard.getLoginStatus()
 */
