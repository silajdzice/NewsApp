//
//  StoryboardExt.swift
//  NewsApp
//
//  Created by Edhem Silajdzic on 29/08/2020.
//  Copyright © 2020 Edhem Silajdzic. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard {
    
    static func mainStoryboard() -> UIStoryboard {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard
    }
    
    static func newsStoryboard() -> UIStoryboard {
        let storyboard = UIStoryboard(name: "News", bundle: nil)
        return storyboard
    }
    
    static func historyStoryboard() -> UIStoryboard {
        let storyboard = UIStoryboard(name: "History", bundle: nil)
        return storyboard
    }
    
    static func detailsStoryboard() -> UIStoryboard {
        let storyboard = UIStoryboard(name: "Details", bundle: nil)
        return storyboard
    }
}

