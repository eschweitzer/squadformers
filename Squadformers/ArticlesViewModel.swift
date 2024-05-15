//
//  ArticlesViewModel.swift
//  Squadformers
//
//  Created by Eric Schweitzer on 5/14/24.
//

import UIKit

extension ArticlesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as? ArticleCell {
           cell.text = articles[indexPath.row].title
            return cell
        }
        
        return UITableViewCell()
    }
    
}

class ArticleCell: UITableViewCell {
    
    var text: String? {
        didSet {
            textLabel?.text = text
        }
    }
    
}
