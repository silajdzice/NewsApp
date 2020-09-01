//
//  UIImageExt.swift
//  NewsApp
//
//  Created by Edhem Silajdzic on 29/08/2020.
//  Copyright © 2020 Edhem Silajdzic. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    func setThumbnailFrom(_ url: String) {
        let urlImage = URL(string: url)
        self.kf.setImage(with: urlImage)
    }
}
