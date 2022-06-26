//
//  Extension.swift
//  MovieDB1.2
//
//  Created by Joseph Castro on 5/23/22.
//


import Foundation
import UIKit
enum constant: String{
    case MovieUrl = "https://api.themoviedb.org/3/discover/movie?api_key=e36bfdb34adab771ab365a00ef795574"
    case  IMAGE_BASE_URL = "https://image.tmdb.org/t/p/w500"
}

class ImageDownloader {
    static let shared = ImageDownloader()
    private init() {}
    let imageCache = NSCache<NSString, UIImage>()

    func getImage(url: String?, completion:@escaping (UIImage) -> ()) {
        guard let url = url else {
            completion(UIImage(named: "template")!)
            return
        }

        if let cached = imageCache.object(forKey: url as NSString) {
            completion(cached)
        }

        DispatchQueue.global(qos: .background).async {
            if let dataUrl = URL(string: url) {
                do {
                    let data = try Data(contentsOf: dataUrl)
                    if let image = UIImage(data: data) {
                        self.imageCache.setObject(image, forKey: url as NSString)
                        completion(image)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            } else {
                completion(UIImage(named: "template")!)
            }
        }
    }
}
