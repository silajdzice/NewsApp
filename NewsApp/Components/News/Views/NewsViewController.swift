//
//  NewsViewController.swift
//  NewsApp
//
//  Created by Edhem Silajdzic on 29/08/2020.
//  Copyright © 2020 Edhem Silajdzic. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
class NewsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var newsViewModel: NewsViewModel
    let realm = try! Realm()
    let heightForCell: CGFloat = 140
    let colorArray = [UIColor.systemTeal, UIColor.systemYellow, UIColor.systemRed, UIColor.systemPurple, UIColor.systemOrange]
    var searchActive = false
    var cashedNews = [NewsSource.Article]()
    var isConnectedToInternet = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        newsViewModel.fetchNews()
        setupDelegates()
        activityIndicator.startAnimating()
        deleteOldArticles()
    }
    
    required init?(coder aDecoder: NSCoder) {
        newsViewModel = NewsViewModel.build()
        super.init(coder: aDecoder)
    }
    
    private func setupUI() {
        if !Connectivity.isConnectedToInternet {
            isConnectedToInternet = false
            renderCashedUI()
        }
    }
    
    private func setupDelegates(){
        newsViewModel.output = self
        tableView.delegate = self
        tableView.dataSource = self
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        
        tableView.registerCell(ofType: NewsTableViewCell.self)
    }
    
    
    private func goToDetails(article: NewsSource.Article) {
        let storyboard = UIStoryboard.detailsStoryboard()
        let detailsVC: DetailsViewController = storyboard.instantiateViewController(identifier: "DetailsViewController")
        detailsVC.detailsViewModel.article = article
        if newsViewModel.news.count == 0 {
            detailsVC.shouldSaveToDB = false
        }
        self.present(detailsVC, animated: true)
    }
    
    private func deleteOldArticles() {
        let sevenDaysAgo = Calendar.current.date(byAdding: .day, value: -7, to: Date())
        if let date = sevenDaysAgo {
            let oldObjects = realm.objects(RealmHistoryArticles.self).filter("date < %@", date)
            try! realm.write {
                realm.delete(oldObjects)
            }
        }
    }
    
    private func renderCashedUI() {
        let articles = realm.objects(RealmArticle.self)
        for article in articles {
            var item = NewsSource.Article()
            
            item.content = article.content
            item.description = article.description
            item.title = article.title
            if let url = article.urlToImage {
                item.urlToImage = URL(string: url)
            }
            item.source.name = article.source.first?.name
            
            cashedNews.append(item)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4, execute: {
            self.hideCollectionView()
            self.activityIndicator.stopAnimating()
            self.tableView.reloadData()
        })
    }
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !isConnectedToInternet {
            return cashedNews.count
        }
        return newsViewModel.news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(ofType: NewsTableViewCell.self)
        if !isConnectedToInternet {
            let item = cashedNews[indexPath.row]
            cell.setupCell(item: item)
        } else {
            let item = newsViewModel.news[indexPath.row]
            cell.setupCell(item: item)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !isConnectedToInternet {
            let item = cashedNews[indexPath.row]
            goToDetails(article: item)
        } else {
            let item = newsViewModel.news[indexPath.row]
            goToDetails(article: item)
        }
        
    }
}

extension NewsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searchActive {
            hideCollectionView()
            return 0
        } else {
            return newsViewModel.hotNews.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HotNewsCollectionView", for: indexPath) as! HotNewsCollectionView
        let item = newsViewModel.hotNews[indexPath.row]
        cell.contentViewWrapper.backgroundColor = colorArray[indexPath.row]
        cell.setupCell(item: item)
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 222, height: 260)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        goToDetails(article: newsViewModel.hotNews[indexPath.row])
    }
}

//MARK: Animations:
extension NewsViewController {
     func hideCollectionView() {
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut, animations: {
            self.collectionView.isHidden = true
            self.tableViewTopConstraint.constant = -266
            self.view.layoutSubviews()
        })
    }
    
    private func showCollectionView() {
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut, animations: {
            self.collectionView.isHidden = false
            self.tableViewTopConstraint.constant = 20
            self.view.layoutSubviews()
        })
    }
}

extension NewsViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchValue = searchBar.text else {return}
        if !isConnectedToInternet {
            self.searchBar.endEditing(true)
            showAlertDialog(alertText: Constants.warrning, alertMessage: Constants.noValidConnection)
            
            return
        }
        if searchValue == "" {
            searchActive = false
            self.searchBar.endEditing(true)
            
            showCollectionView()
            
            newsViewModel.fetchNews()
            return
        }
        searchActive = true
        self.searchBar.endEditing(true)
        newsViewModel.fetchSearchedNews(value: searchValue)
    }
}

extension NewsViewController: NewsViewModelOutput {
    func reload() {
        activityIndicator.stopAnimating()
        tableView.reloadData()
        collectionView.reloadData()
    }
    
}
