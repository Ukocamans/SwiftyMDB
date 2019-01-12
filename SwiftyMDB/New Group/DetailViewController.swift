//
//  DetailViewController.swift
//  SwiftyMDB
//
//  Created by Umurcan on 12.01.2019.
//  Copyright © 2019 Umurcan. All rights reserved.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {

    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var imgPoster: UIImageView!
    
    @IBOutlet weak var lblGenre: UILabel!
    @IBOutlet weak var lblPlot: UILabel!
    
    var viewModel: DetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureUI()
    }
    
    func configureUI() {
        title = viewModel?.title
        
        lblTitle.text = viewModel?.title
        imgPoster.sd_setImage(with: viewModel?.imageURL, completed: nil)
        lblGenre.text = viewModel?.genre
        lblPlot.text = viewModel?.plot
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
