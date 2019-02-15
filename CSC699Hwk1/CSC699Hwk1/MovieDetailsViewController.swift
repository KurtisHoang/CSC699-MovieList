//
//  MovieDetailsViewController.swift
//  CSC699Hwk1
//
//  Created by Kurtis Hoang on 2/9/19.
//  Copyright © 2019 Kurtis Hoang. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    var movie: [String:Any]!
    var num: Int!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        titleLabel.text = movie["title"] as? String
        synopsisLabel.text = movie["overview"] as? String
        releaseDateLabel.text = "Release Date: " + (movie["release_date"] as? String)!
        
        //
        titleLabel.sizeToFit()
        synopsisLabel.sizeToFit()
        
        //get data for image path
        let baseurl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseurl + posterPath)
        
        posterView.af_setImage(withURL: posterUrl!)
        
        //backdrop image
        let backdropPath = movie["backdrop_path"] as! String
        let backdropUrl = URL(string: "https://image.tmdb.org/t/p/w780" + backdropPath)
        
        backdropView.af_setImage(withURL: backdropUrl!)
    }
    
    @IBAction func didTap(_ sender: Any) {
        if(num == 1)
        {
            performSegue(withIdentifier: "trailerSegue1", sender: nil)
        } else if(num == 2)
        {
            performSegue(withIdentifier: "trailerSegue2", sender: nil)
        }
        
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if let destination = segue.destination as? MovieTrailerViewController
        {
            destination.movieId = String(movie["id"] as! Int)
        }
    }
    

}
