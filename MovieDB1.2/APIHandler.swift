//
//  APIHandler.swift
//  MovieDB1.2
//
//  Created by Joseph Castro on 5/23/22.
//

import Foundation
class APIHandler {
    static let shared = APIHandler()
    private init(){}
    
    func fetchData(url:URL, completionHandler: @escaping ((MovieListModel) ->Void)) {
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if data != nil && error == nil {
                DispatchQueue.global().async {
                    let decoder = JSONDecoder()
                    let model = try! decoder.decode(MovieListModel.self, from: data!)
                    let movieListModel = model
                    completionHandler(movieListModel)
                }
            }
        }.resume()
    }
}
