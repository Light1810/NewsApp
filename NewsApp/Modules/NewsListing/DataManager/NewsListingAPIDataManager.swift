//
//  NewsListingAPIDataManager.swift
//  NewsApp
//
//  Created by Aakash Decosta on 13/07/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

typealias NewsDataCompletion = (Result<APIResponse<NewsArticleData>,Error>) -> Void

class NewsListingAPIDataManager {
    init() {
    }
    // Data fetch service methods goes here
    func getNewsList(completion:@escaping NewsDataCompletion) {
        let parameters = ["country": "\(Locale.current.regionCode ?? "")" ,
                          "category": "business",
                          "apiKey": Bundle.main.infoDictionary?["API_KEY"]  as? String ?? ""]
        APIManager.shared.getData(url: "https://newsapi.org/v2/top-headlines",parameters: parameters, completion: completion)
    }
}
