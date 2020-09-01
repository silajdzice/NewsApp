//
//  DetailsViewController.swift
//  NewsApp
//
//  Created by Edhem Silajdzic on 30/08/2020.
//  Copyright © 2020 Edhem Silajdzic. All rights reserved.
//

import Foundation
import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var articlePublishedDate: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var contentWrapper: UIView!
    @IBOutlet weak var articleImageViewWrapper: UIView!
    @IBOutlet weak var articleSource: UILabel!
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    var detailsViewModel: DetailsViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        detailsViewModel = DetailsViewModel.build()
        super.init(coder: aDecoder)
    }
    
    func setupView() {
        contentWrapper.setGradientBackground(.bottomDetailsBackgroundColor, .topDetailsBackgroundColor)
        
        if let imageUrl = detailsViewModel.article.urlToImage {
            articleImageView.setThumbnailFrom("\(imageUrl)")
        }
        articleSource.text = detailsViewModel.article.source.name
        articleTitle.text = detailsViewModel.article.title
        textView.text = detailsViewModel.article.content
        articlePublishedDate.text = detailsViewModel.article.publishedAt
    }
}
