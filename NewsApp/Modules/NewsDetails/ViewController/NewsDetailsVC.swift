//
//  NewsDetailsVC.swift
//  NewsApp
//
//  Created by Aakash Decosta on 13/07/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class NewsDetailsVC: UIViewController {
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblAuthor: UILabel!
    @IBOutlet weak var lblContent: UILabel!
    // MARK: Instance variables
	lazy var viewModel = NewsDetailsViewModel()
    // MARK: - View Life Cycle Methods
	override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.apiResponseDelegate = self
        setupData()

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
    @IBAction func tappedViewWeb(_ sender: UIButton) {
       openNewWebsite()
    }
    @IBAction func tapepdBackBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    deinit {
       debugPrint("\(self) deinitialized")
    }
}

// MARK: - Load from storyboard with dependency
extension NewsDetailsVC {
    class func loadFromXIB(withDependency dependency: NewsDetailsDependency? = nil) -> NewsDetailsVC? {
        let storyboard = UIStoryboard(name: "NewsDetails", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "NewsDetailsVC") as? NewsDetailsVC else {
            return nil
        }
        viewController.viewModel.dependency = dependency
        return viewController
    }
}

// MARK: - NewsDetailsAPIResponseDelegate
extension NewsDetailsVC: NewsDetailsAPIResponseDelegate {
}

extension NewsDetailsVC {
    func setupData() {
        let userPlaceholder = UIImage(named: "new_placeholder")
        let imageUrl = URL(string: viewModel.dependency?.newsData.urlToImage ?? "")
        newsImage.sd_setImage(with: imageUrl , placeholderImage:  userPlaceholder)
        lblTitle.text = viewModel.dependency?.newsData.title
        lblAuthor.text = viewModel.dependency?.newsData.author
        lblDate.text = viewModel.dependency?.newsData.publishedAt
        lblContent.text = viewModel.dependency?.newsData.newsDescription
    }
    
    func openNewWebsite() {
        guard let url = URL(string: viewModel.dependency?.newsData.url ?? "") else {
          return
        }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}
