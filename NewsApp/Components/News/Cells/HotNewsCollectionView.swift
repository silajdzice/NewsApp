//
//  HotNewsCollectionView.swift
//  NewsApp
//
//  Created by Edhem Silajdzic on 30/08/2020.
//  Copyright © 2020 Edhem Silajdzic. All rights reserved.
//

import Foundation
import UIKit

class HotNewsCollectionView: UICollectionViewCell {
    
    @IBOutlet weak var contentViewWrapper: UIView!
    @IBOutlet weak var newsSource: UILabel!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsImageViewWrapper: UIView!
    @IBOutlet weak var newsImageView: UIImageView!
    
    func setupCell(item: NewsSource.Article) {
        if let imageUrl = item.urlToImage {
            newsImageView.setThumbnailFrom("\(imageUrl)")
        } else {
            newsImageView.image = UIImage(named: "placeHolder")
        }
        newsSource.text = item.source.name
        newsTitle.text = item.title
    }
}
