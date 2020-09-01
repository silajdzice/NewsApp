//
//  HistoryViewController.swift
//  NewsApp
//
//  Created by Edhem Silajdzic on 29/08/2020.
//  Copyright © 2020 Edhem Silajdzic. All rights reserved.
//

import Foundation
import UIKit

class HistoryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let heightForCell: CGFloat = 140
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupDelegates(){
        //newsViewModel.output = self
        tableView.delegate = self
        tableView.dataSource = self
//        collectionView.delegate = self
//        collectionView.dataSource = self
//        searchBar.delegate = self

        tableView.registerCell(ofType: NewsTableViewCell.self)
    }
}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
     
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return newsViewModel.news.count
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueCell(ofType: NewsTableViewCell.self)
//        let item = newsViewModel.news[indexPath.row]
//        cell.setupCell(item: item)
//        return cell
        let cell = UITableViewCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //goToDetails(article: newsViewModel.news[indexPath.row])
    }
}
