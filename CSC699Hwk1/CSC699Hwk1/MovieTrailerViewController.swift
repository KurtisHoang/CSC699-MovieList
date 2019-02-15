//
//  MovieTrailerViewController.swift
//  CSC699Hwk1
//
//  Created by Kurtis Hoang on 2/12/19.
//  Copyright © 2019 Kurtis Hoang. All rights reserved.
//

import UIKit
import WebKit

class MovieTrailerViewController: UIViewController {

    @IBOutlet weak var movieTrailerView: WKWebView!
    
    
    var movie: [String:Any] = [:]
    var movieId: String!
    let baseURL = "https://www.youtube.com/watch?v="
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //movie video api
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(String(movieId))/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                //get the results from the dataDictionary and store in movies
                //cast as an array of dictionary
            
                let movies = dataDictionary["results"] as! [[String:Any]]
                for var i in 0..<movies.count
                {
                    var currTrailer = movies[i]
                    let type = currTrailer["type"] as! String
                    if(type == "Trailer")
                    {
                        self.movie = movies[i]
                        i = movies.count
                    }
                }

                let movieKey = self.movie["key"] as! String
                let trailerURL = URL(string: self.baseURL + movieKey)
                let urlRequest = URLRequest(url: trailerURL!)
                self.movieTrailerView.load(urlRequest)
            }
        }
        
        task.resume()
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
