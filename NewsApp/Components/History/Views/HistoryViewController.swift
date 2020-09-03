//
//  HistoryViewController.swift
//  NewsApp
//
//  Created by Edhem Silajdzic on 29/08/2020.
//  Copyright © 2020 Edhem Silajdzic. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class HistoryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let heightForCell: CGFloat = 140
    let realm = try! Realm()
    var news = [NewsSource.Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
        
        render()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func render() {
        let articles = realm.objects(RealmArticle.self)
        for article in articles {
            var item = NewsSource.Article()
            
            item.content = article.content
            item.description = article.description
            item.title = article.title
            item.urlToImage = URL(string: article.urlToImage!)
            if let source = article.source {
                item.source.name = source.name
            }
            
            news.append(item)
        }
    }
    
    private func setupDelegates(){
        tableView.delegate = self
        tableView.dataSource = self

        tableView.registerCell(ofType: NewsTableViewCell.self)
    }
    
    private func goToDetails(article: NewsSource.Article) {
        let storyboard = UIStoryboard.detailsStoryboard()
        let detailsVC: DetailsViewController = storyboard.instantiateViewController(identifier: "DetailsViewController")
        detailsVC.detailsViewModel.article = article
        self.present(detailsVC, animated: true)
    }
}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
     
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(ofType: NewsTableViewCell.self)
        cell.setupCell(item: news[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goToDetails(article: news[indexPath.row])
    }
}
