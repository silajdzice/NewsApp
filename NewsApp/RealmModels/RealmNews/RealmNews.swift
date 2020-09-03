//
//  RealmNews.swift
//  NewsApp
//
//  Created by Edhem Silajdzic on 02/09/2020.
//  Copyright © 2020 Edhem Silajdzic. All rights reserved.
//

import RealmSwift

class RealmArticle: Object {
    let source = List<RealmSource>()
    @objc dynamic var author: String? = ""
    @objc dynamic var title: String? = ""
    @objc dynamic var arDescription: String? = ""
    @objc dynamic var url: String? = ""
    @objc dynamic var urlToImage: String? = ""
    @objc dynamic var publishedAt: String? = ""
    @objc dynamic var content: String? = ""

}


class RealmSource: Object {
    @objc dynamic var id: String? = ""
    @objc dynamic var name: String? = ""
}

