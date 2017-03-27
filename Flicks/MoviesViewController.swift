//
//  ViewController.swift
//  Flicks
//
//  Created by jiafang_jiang on 3/21/17.
//  Copyright © 2017 jiafang_jiang. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD

class MoviesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

  @IBOutlet weak var alertView: UIView!
  @IBOutlet weak var tableView: UITableView!
  var refreshControl: UIRefreshControl!
  var endpoint: String = ""

  var movies: [NSDictionary]? = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.

    tableView.dataSource = self
    tableView.delegate = self
    
    refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(MoviesViewController.refreshControlAction(_:)), for: UIControlEvents.valueChanged)
    tableView.insertSubview(refreshControl, at: 0)
    
    loadData(isRefresh: false)
    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func refreshControlAction(_ refreshControl: UIRefreshControl) {
    loadData(isRefresh: true)
  }
  
  func loadData(isRefresh: Bool) {
    let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
    let urlString = "https://api.themoviedb.org/3/movie/\(endpoint)?api_key=\(apiKey)"
    let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
    
    let request = NSURLRequest(
      url: url! as URL,
      cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData,
      timeoutInterval: 10)
    
    let session = URLSession(
      configuration: URLSessionConfiguration.default,
      delegate: nil,
      delegateQueue: OperationQueue.main
    )
    
    // Display HUD right before the request is made
    if (!isRefresh) {
      MBProgressHUD.showAdded(to: self.view, animated: true)
    }
    
    let task: URLSessionDataTask = session.dataTask(
      with: request as URLRequest, completionHandler: {
        (dataOrNil, response, error) in
        
        if (!isRefresh) {
          MBProgressHUD.hide(for: self.view, animated: true)
        }

        if let data = dataOrNil {
          if let responseDictionary = try! JSONSerialization.jsonObject(
            with: data, options:[]) as? NSDictionary {
            self.movies = responseDictionary["results"] as? [NSDictionary]
            self.tableView.reloadData()
            
            if (isRefresh) {
              self.refreshControl.endRefreshing()
            }
          }
        }
        
        if error != nil || dataOrNil == nil {
          self.alertView.isHidden = false
        }
    })
    task.resume()

  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let movies = movies {
      return movies.count
    }
    return 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCellTableViewCell
    
    let baseURL = "http://image.tmdb.org/t/p/w500"
    
    let movie = movies![indexPath.row]
    let movieTitle = movie["title"] as! String
    let movieOverview = movie["overview"] as! String
    
    cell.titleLabel.text = movieTitle
    cell.overviewLabel.text = movieOverview
    cell.overviewLabel.sizeToFit()
    cell.overviewScrollView.contentSize = cell.overviewLabel.bounds.size
    
    if let posterPath = movie["poster_path"] as? String {
      let posterUrl = URL(string: baseURL + posterPath)
      cell.movieImageView.setImageWith(posterUrl!)
 
    }
    

    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    tableView.reloadRows(at: [indexPath], with: .automatic)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let cell = sender as! UITableViewCell
    let indexPath = tableView.indexPath(for: cell)
    let movie = movies![indexPath!.row]
    
    let detailViewController = segue.destination as! MovieDetailViewController
    detailViewController.movie = movie
  }

}

