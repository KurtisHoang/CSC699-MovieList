//
//  MoviesViewController.swift
//  CSC699Hwk1
//
//  Created by Kurtis Hoang on 2/6/19.
//  Copyright © 2019 Kurtis Hoang. All rights reserved.
//

import UIKit
import AlamofireImage

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //created an array of dictionary 
    var movies = [[String:Any]]()
    
    //tableview variable
    @IBOutlet weak var flixsterTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        flixsterTableView.dataSource = self
        flixsterTableView.delegate = self
        
        //movie api
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
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
                self.movies = dataDictionary["results"] as! [[String:Any]]
                
                // TODO: Get the array of movies
                // TODO: Store the movies in a property to use elsewhere
                // TODO: Reload your table view data
                self.flixsterTableView.reloadData()
            }
        }
        
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //create the cell and cast its as a movie cell
        let cell = flixsterTableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        
        //set the current row movie
        let movie = movies[indexPath.row]
        //get the title, synopsis, and image of the movie
        let title = movie["title"] as! String
        let sysnopsis = movie["overview"] as! String
        
        //set title and synopsis
        cell.titleLabel.text = title
        cell.synopsisLabel.text = sysnopsis
        
        //get data for image path
        let baseurl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseurl + posterPath)
        
        cell.posterView.af_setImage(withURL: posterUrl!)
        
        return cell
    }
    
    /*
     manually editing the cell height through storyboard
     adjust the cell to desired height
     click the cell and then click the ruler (size inspector)
     copy the row height
     click on tableview and then click the ruler (size inspector)
     un check the automatic for height
     paste row height in tableview row height
     */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
