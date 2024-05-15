//
//  ArticlesViewController.swift
//  Squadformers
//
//  Created by Eric Schweitzer on 5/14/24.
//

// Assume this is running in the context of an actual user facing production appliction.

import UIKit

final class ArticlesViewController: UIViewController {
    var articles: [Article] = []
    @IBOutlet var tableView: UITableView!
    
    let cellReuseIdentifier = "ArticleCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(ArticleCell.self, forCellReuseIdentifier: cellReuseIdentifier)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.fetchData()
    }
    
    func fetchData() {
        APIClient.fetchArticles { [weak self] result in
            switch result {
            case .success(let articles):
                DispatchQueue.main.async {
                    self?.articles = articles
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Something went wrong", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertAction.Style.default, handler: { _ in
                        self?.fetchData()
                    }))
                    self?.present(alert, animated: true, completion: nil)
                }
            }
        }
    }

}

