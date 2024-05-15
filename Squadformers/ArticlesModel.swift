//
//  ArticlesModel.swift
//  Squadformers
//
//  Created by Eric Schweitzer on 5/14/24.
//

import Foundation

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
