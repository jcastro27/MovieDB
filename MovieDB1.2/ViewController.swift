//
//  ViewController.swift
//  MovieDB1.2
//
//  Created by Joseph Castro on 5/23/22.
//


import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var movieTableView: UITableView!
    var apiHandler = APIHandler.shared
    var movieViewModel:MovieViewModel?
    var model:[Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieViewModel = MovieViewModel()
        guard let url = URL(string: constant.MovieUrl.rawValue) else {fatalError()}
        movieViewModel?.fetchData(url: url, completionHandler: {
            DispatchQueue.main.async {
                self.movieTableView.reloadData()
            }
        })
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom < height {
            print(" you reached end of the table")
            movieViewModel?.updatePage()
       // https://api.themoviedb.org/3/discover/movie?api_key=23b928acfbffc0bad339bdc2ed966728&page=2
            guard let url = URL(string: constant.MovieUrl.rawValue + "&page=\(movieViewModel?.page ?? 1)") else {fatalError()}
            movieViewModel?.fetchData(url: url, completionHandler: {
                DispatchQueue.main.async {
                    self.movieTableView.reloadData()
                }
            })
        }
    }
    //MARK: UIUITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieViewModel?.getRawCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = movieTableView.dequeueReusableCell(withIdentifier: "MovieCell", for:indexPath) as? MovieTableViewCell
        let movie = movieViewModel?.getMovie(index: indexPath.row)
        //set all properties of VC
        cell?.titleLabel.text = "Title: \(movie?.title ?? "N/A")"
        cell?.scoreLabel.text = "Popularity Score: \(String(movie?.popularity ?? 0.0))"
        cell?.releaseLable.text = "Release Date: \(movie?.release_date ?? "N/A")"
        cell?.contentLabel.text = movie?.overview ?? "N/A"
        ImageDownloader.shared.getImage(url: constant.IMAGE_BASE_URL.rawValue + (movie?.poster_path)!) { image in
            DispatchQueue.main.async {
                cell?.MovieImgView.image = image
            }
        }
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tapped any cell would present DetailVC
        let sb = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = sb.instantiateViewController(identifier: "DetailViewController") as? DetailViewController,
              let movieViewModel = self.movieViewModel,
              let movie = movieViewModel.getMovie(index: indexPath.row) else {return}
        vc.setMovie(movie: movie)
        present(vc, animated: true, completion: nil)
        
        
    }
    
    
}
