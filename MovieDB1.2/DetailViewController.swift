//
//  DetailViewController.swift
//  MovieDB1.2
//
//  Created by Joseph Castro on 5/23/22.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var detailImgView: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    
    @IBOutlet weak var contentView: UITextView!
    
    @IBOutlet weak var titleLabel: UILabel!
    var movieScore: String?
    var language: String?
    var dateofRelease: String?
    var content: String?
    var titleofmovie:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailImgView.layer.cornerRadius = 25.0
        detailImgView.layer.masksToBounds = true
        
        scoreLabel.text = movieScore
        releaseDateLabel.text = dateofRelease
        contentView.text = content
        titleLabel.text = titleofmovie
        languageLabel.text = language

    }
    
    func setMovie(movie:Movie) {
        titleofmovie = movie.title ?? ""
        movieScore = "Score: \(movie.popularity ?? 0.0)"
        language = "Language: \(movie.original_language ?? "N/A")"
        dateofRelease = "Release Date: \(movie.release_date ?? "N/A")"
        content = movie.overview ?? ""

        ImageDownloader.shared.getImage(url: "https://image.tmdb.org/t/p/w500" + (movie.backdrop_path)!) { image in
            DispatchQueue.main.async {
                self.detailImgView.image = image
            }
        }
    }
    

    

}
