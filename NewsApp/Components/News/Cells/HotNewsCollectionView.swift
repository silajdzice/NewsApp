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
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupView()
//    }
//    var news: NewsSource.Article! {
//        didSet {
//            setupView()
//        }
//    }
    
//    func setupView() {
//        if let article = news {
//            if let imageUrl = article.urlToImage {
//                newsImageView.setThumbnailFrom("\(imageUrl)")
//            }
//            newsSource.text = article.source.name
//            newsTitle.text = article.title
//        }
//        contentViewWrapper.layer.cornerRadius = 15.0
//        contentViewWrapper.layer.shadowColor = UIColor.gray.cgColor
//        contentViewWrapper.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
//        contentViewWrapper.layer.shadowRadius = 10.0
//        contentViewWrapper.layer.shadowOpacity = 0.6
//    }
    
    func setupCell(item: NewsSource.Article) {
        if let imageUrl = item.urlToImage {
            newsImageView.setThumbnailFrom("\(imageUrl)")
        }
        newsSource.text = item.source.name
        newsTitle.text = item.title
    }
}
