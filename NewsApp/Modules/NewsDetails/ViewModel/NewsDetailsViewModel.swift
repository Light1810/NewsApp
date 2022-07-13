//
//  NewsDetailsViewModel.swift
//  NewsApp
//
//  Created by Aakash Decosta on 13/07/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol NewsDetailsAPIResponseDelegate: AnyObject {
}

class NewsDetailsViewModel {
    weak var apiResponseDelegate: NewsDetailsAPIResponseDelegate?
    lazy var localDataManager = NewsDetailsLocalDataManager()
    lazy var apiDataManager = NewsDetailsAPIDataManager()
    
    var dependency: NewsDetailsDependency?
    
    init() {
    }

}
