//
//  NewsListingVC.swift
//  NewsApp
//
//  Created by Aakash Decosta on 13/07/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class NewsListingVC: UIViewController {
    // MARK: Instance variables
    @IBOutlet weak var tableView: UITableView!
    lazy var viewModel = NewsListingViewModel()
    let refreshControl = UIRefreshControl()
    
    // MARK: - View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.apiResponseDelegate = self
        tableViewSetup()
        if viewModel.isFirstLaunch() {
            self.viewModel.getNewsAPI()
        } else {
            self.viewModel.getDBNews()
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    // MARK: Deinitialization
    deinit {
        debugPrint("\(self) deinitialized")
    }
}

// MARK: - Load from storyboard with dependency
extension NewsListingVC {
    class func loadFromXIB(withDependency dependency: NewsListingDependency? = nil) -> NewsListingVC? {
        let storyboard = UIStoryboard(name: "NewsListing", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "NewsListingVC") as? NewsListingVC else {
            return nil
        }
        viewController.viewModel.dependency = dependency
        return viewController
    }
}

// MARK: - NewsListingAPIResponseDelegate
extension NewsListingVC: NewsListingAPIResponseDelegate {
    func handleNewsListingAPI(data: [NewsArticleData]) {
        DispatchQueue.main.async {
            data.forEach({self.viewModel.addNewDB(item: $0)})
            self.viewModel.getDBNews()
        }
    }
    
    func handleNewsListing() {
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
            self.tableView.reloadData()
        }
    }
    
    func handleAPIError(_ error: Error) {
        print(error)
    }
    
}

extension NewsListingVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTVC", for: indexPath) as? NewsTVC else { return UITableViewCell() }
        cell.cellData = viewModel.news[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.news.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = viewModel.news[indexPath.row]
        let dependency = NewsDetailsDependency(newsData: item)
        guard let vc = NewsDetailsVC.loadFromXIB(withDependency: dependency) else { return }
        navigationController?.pushViewController(vc, animated: true)
    }
}


extension NewsListingVC {
    func tableViewSetup() {
        tableView.dataSource = self
        tableView.delegate = self
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    @objc func refresh(_ sender: AnyObject) {
        self.viewModel.getNewsAPI()
    }
}
