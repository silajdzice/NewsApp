//
//  RealmHistoryArticles.swift
//  NewsApp
//
//  Created by Edhem Silajdzic on 03/09/2020.
//  Copyright © 2020 Edhem Silajdzic. All rights reserved.
//

import Foundation
import RealmSwift

class RealmHistoryArticles: Object {
    let source = List<RealmHistoryArticlesSource>()
    @objc dynamic var author: String? = ""
    @objc dynamic var title: String? = ""
    @objc dynamic var arDescription: String? = ""
    @objc dynamic var url: String? = ""
    @objc dynamic var urlToImage: String? = ""
    @objc dynamic var publishedAt: String? = ""
    @objc dynamic var content: String? = ""
    @objc dynamic var date: Date? = nil
}


class RealmHistoryArticlesSource: Object {
    @objc dynamic var id: String? = ""
    @objc dynamic var name: String? = ""
}
