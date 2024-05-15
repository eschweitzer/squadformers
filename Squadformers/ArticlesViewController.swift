//
//  ViewController.swift
//  Squadformers
//
//  Created by Eric Schweitzer on 5/14/24.
//

// Assume this is running in the context of an actual user facing production appliction.

import UIKit

final class ArticlesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private var articles: [Article] = []
    private var tableView: UITableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        // set up the cell identifiers
        fetchData()
    }
    
    func fetchData() {
      // use weak self?
        APIClient.fetchArticles { [weak self] result in
            switch result {
            case .success(let articles):
                DispatchQueue.main.async {
                    self?.articles = articles
                    self?.tableView.reloadData()
                }
            case .failure(let error):
            // show error alert with retry button
                print(error)
            }
        }
    }

// use a class extension
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      // return empty cell if dequeueReusableCell fails
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as? ArticleCell {
           cell.textLabel.text = articles[indexPath.row].title
        }
        return cell
    }
}

// put from here down in a different file (view model)
struct Article {
    let title: String
}

class APIClient {
  // add error handling
    static func fetchArticles(completion: @escaping (Result<[Article], Error>) -> Void) {
        let sampleArticles = [Article(title: "iOS Development"), Article(title: "SwiftUI Essentials")]
        completion(.success(sampleArticles))
    }
}

