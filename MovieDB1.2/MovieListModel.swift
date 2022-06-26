//
//  MovieListModel.swift
//  MovieDB1.2
//
//  Created by Joseph Castro on 5/23/22.
//

import Foundation
struct MovieListModel: Codable {
    var results: [Movie] = []
}

struct Movie: Codable {
    var id: Int?
    var popularity: Double?
    var release_date: String?
    var title: String?
    var overview: String?
    var original_language: String?
    var poster_path: String?
    var backdrop_path: String?
}


