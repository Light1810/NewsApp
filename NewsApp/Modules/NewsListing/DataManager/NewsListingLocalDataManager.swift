//
//  NewsListingLocalDataManager.swift
//  NewsApp
//
//  Created by Aakash Decosta on 13/07/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import CoreData

class NewsListingLocalDataManager {
    let database = DatabaseManager.shared
    init() {
    }
    // Data fetch service methods goes here
    func fetchNewsFromLocalDb() -> [NewArticle] {
        return database.fetch(NewArticle.self)
    }
    func saveToLocalDB(data: NewsArticleData) {
        guard let newsArticle = database.addData(NewArticle.self) else { return }
        newsArticle.author = data.author ?? ""
        newsArticle.newsDescription = data.description ?? ""
        newsArticle.title = data.title ?? ""
        newsArticle.url = data.url ?? ""
        newsArticle.urlToImage = data.urlToImage ?? ""
        newsArticle.publishedAt = data.publishedAt ?? ""
        newsArticle.content = data.content ?? ""
        database.save()
    }
}
