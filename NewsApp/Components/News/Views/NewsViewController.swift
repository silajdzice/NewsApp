//
//  NewsViewController.swift
//  NewsApp
//
//  Created by Edhem Silajdzic on 29/08/2020.
//  Copyright © 2020 Edhem Silajdzic. All rights reserved.
//

import Foundation
import UIKit

class NewsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableViewTopConstraint: NSLayoutConstraint!
    
    var newsViewModel: NewsViewModel
    let heightForCell: CGFloat = 140
    let colorArray = [UIColor.systemTeal, UIColor.systemYellow, UIColor.systemRed, UIColor.systemPurple, UIColor.systemOrange]
    var searchActive = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsViewModel.fetchNews()
        setupDelegates()
    }
    
    required init?(coder aDecoder: NSCoder) {
        newsViewModel = NewsViewModel.build()
        super.init(coder: aDecoder)
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
        self.present(detailsVC, animated: true)
    }
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsViewModel.news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(ofType: NewsTableViewCell.self)
        let item = newsViewModel.news[indexPath.row]
        cell.setupCell(item: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goToDetails(article: newsViewModel.news[indexPath.row])
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
    private func hideCollectionView() {
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
        tableView.reloadData()
        collectionView.reloadData()
    }
    
}
