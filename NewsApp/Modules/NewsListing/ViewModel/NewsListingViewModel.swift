//
//  NewsListingViewModel.swift
//  NewsApp
//
//  Created by Aakash Decosta on 13/07/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol NewsListingAPIResponseDelegate: AnyObject {
    func handleNewsListingAPI(data: [NewsArticleData] )
    func handleNewsListing()
    func handleAPIError(_ error: Error)
}

class NewsListingViewModel {
    weak var apiResponseDelegate: NewsListingAPIResponseDelegate?
    lazy var localDataManager = NewsListingLocalDataManager()
    lazy var apiDataManager = NewsListingAPIDataManager()
    
    var dependency: NewsListingDependency?
    
    var news: [NewArticle] = []

    
    init() {
    }
    // Data fetch service methods goes here
    func isFirstLaunch() -> Bool {
        let hasBeenLaunchedBeforeFlag = "hasBeenLaunchedBeforeFlag"
        let isFirstLaunch = UserDefaults.standard.bool(forKey: hasBeenLaunchedBeforeFlag)
        if (!isFirstLaunch) {
            UserDefaults.standard.set(true, forKey: hasBeenLaunchedBeforeFlag)
            UserDefaults.standard.synchronize()
        }
        return !isFirstLaunch
    }
    func getNewsAPI() {
        apiDataManager.getNewsList { [weak self] response in
            guard let weakSelf = self else {
                return
            }
            switch response {
            case .failure(let error):
                weakSelf.apiResponseDelegate?.handleAPIError(error)
                ()
            case .success(let response):
                if let data = response.articles {
                    weakSelf.apiResponseDelegate?.handleNewsListingAPI(data: data)
                    //
                }
            }
        }
    }
    func addNewDB(item:NewsArticleData) {
        localDataManager.saveToLocalDB(data: item)
    }
    
    func getDBNews() {
        news = localDataManager.fetchNewsFromLocalDb()
        apiResponseDelegate?.handleNewsListing()
    }
}
