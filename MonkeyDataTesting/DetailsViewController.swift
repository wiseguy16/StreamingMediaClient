//
//  DetailsViewController.swift
//  MonkeyDataTesting
//
//  Created by Gregory Weiss on 7/25/17.
//  Copyright © 2017 gergusa. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var labelString = ""
    var imageURLString = ""
    var deskriptDetails = ""
    
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var deskripDetailsLabel: UILabel!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        detailsLabel.text = labelString
        deskripDetailsLabel.text = deskriptDetails
        let url = changeStringToURL(imageURLString)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            DispatchQueue.main.async {
                self.detailImageView.image = UIImage(data: data!)
            }
        }


        // Do any additional setup after loading the view.
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
