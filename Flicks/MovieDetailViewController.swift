//
//  MovieDetailViewController.swift
//  Flicks
//
//  Created by jiafang_jiang on 3/25/17.
//  Copyright © 2017 jiafang_jiang. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

  @IBOutlet weak var detailMovieImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var overviewLabel: UILabel!
  
  @IBOutlet weak var scrollView: UIScrollView!
  
  @IBOutlet weak var infoView: UIView!
  var movie: NSDictionary!
		
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: infoView.frame.origin.y + infoView.frame.size.height)
    
    titleLabel.text = movie["title"] as? String
    overviewLabel.text = movie["overview"] as? String
    overviewLabel.sizeToFit()
    
    let baseURL = "http://image.tmdb.org/t/p/w500"

    if let posterPath = movie["poster_path"] as? String {
      let posterUrl = URL(string: baseURL + posterPath)
      detailMovieImageView.setImageWith(posterUrl!)
    }
  }

  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }
  

  /*
  // MARK: - Navigation

  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      // Get the new view controller using segue.destinationViewController.
      // Pass the selected object to the new view controller.
  }
  */

}
