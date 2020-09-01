//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by Edhem Silajdzic on 29/08/2020.
//  Copyright © 2020 Edhem Silajdzic. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var newsSource: UILabel!
    @IBOutlet weak var newsTitle: UILabel!
    
    @IBOutlet weak var contentWrapper: UIView!
    @IBOutlet weak var imageViewWrapper: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
        // Initialization code
    }
    
    func setupView() {
        contentWrapper.layer.cornerRadius = 15.0
        contentWrapper.layer.shadowColor = UIColor.gray.cgColor
        contentWrapper.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        contentWrapper.layer.shadowRadius = 10.0
        contentWrapper.layer.shadowOpacity = 0.6
    }
    
    func setupCell(item: NewsSource.Article) {
        if let imageUrl = item.urlToImage {
            newsImageView.setThumbnailFrom("\(imageUrl)")
        }
        newsSource.text = item.source.name
        newsTitle.text = item.title
    }
}
