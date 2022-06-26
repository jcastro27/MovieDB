//
//  MovieViewModel.swift
//  MovieDB1.2
//
//  Created by Joseph Castro on 5/23/22.
//

import Foundation

class MovieViewModel {
    var apiHandler = APIHandler.shared
    var movies:[Movie] = []
    var page = 1

    
    func fetchData(url:URL,completionHandler: @escaping (()->Void)) {
        apiHandler.fetchData(url: url) { model in
            self.movies.append(contentsOf:model.results)
            completionHandler()
        }
    }
    
    func getRawCount() -> Int? {
        return movies.count
    }
    func updatePage(){
        page = page + 1
        
    }
    
    func getMovie(index:Int) -> Movie? {
        let movie = movies[index]
        return Movie(id: movie.id, popularity: movie.popularity, release_date: movie.release_date, title: movie.title, overview: movie.overview,original_language: movie.original_language, poster_path: movie.poster_path, backdrop_path: movie.backdrop_path)
    }
}
struct MoviePage: Codable {
    let page: Int
    let results: [Movie]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
