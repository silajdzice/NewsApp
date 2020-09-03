//
//  DetailsViewController.swift
//  NewsApp
//
//  Created by Edhem Silajdzic on 30/08/2020.
//  Copyright © 2020 Edhem Silajdzic. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var contentWrapper: UIView!
    @IBOutlet weak var articleImageViewWrapper: UIView!
    @IBOutlet weak var articleSource: UILabel!
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    var detailsViewModel: DetailsViewModel
    let realm = try! Realm()
    var shouldSaveToDB = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        createAndSaveArticle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        detailsViewModel = DetailsViewModel.build()
        super.init(coder: aDecoder)
    }
    
    private func createAndSaveArticle(){
        if shouldSaveToDB {
            let article = RealmHistoryArticles()
            realm.beginWrite()

            article.arDescription = detailsViewModel.article.description
            article.title = detailsViewModel.article.title
            
            article.urlToImage = detailsViewModel.article.urlToImage?.absoluteString
            article.content = detailsViewModel.article.content
            
            let date = Date()
            article.date = date
            
            let sources = RealmHistoryArticlesSource()
            sources.name = detailsViewModel.article.source.name
            article.source.append(sources)
            
            realm.add(article)
            try! realm.commitWrite()
        }
    }
    
    func setupView() {
        contentWrapper.setGradientBackground(.bottomDetailsBackgroundColor, .topDetailsBackgroundColor)
        
        if let imageUrl = detailsViewModel.article.urlToImage {
            articleImageView.setThumbnailFrom("\(imageUrl)")
        } else {
            articleImageView.image = UIImage(named: "placeHolder")
        }
        articleSource.text = detailsViewModel.article.source.name
        articleTitle.text = detailsViewModel.article.title
        textView.text = detailsViewModel.article.content
    }
}
