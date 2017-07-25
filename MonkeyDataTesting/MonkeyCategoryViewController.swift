//
//  MonkeyCategoryViewController.swift
//  MonkeyDataTesting
//
//  Created by Gregory Weiss on 7/20/17.
//  Copyright © 2017 gergusa. All rights reserved.
//

import UIKit

class MonkeyCategoryViewController: UIViewController {
    var monkeyChannel: MonkeyChannel?
    
    @IBOutlet weak var cat1Label: UILabel!
    @IBOutlet weak var cat1Descrip: UILabel!
    @IBOutlet weak var cat2Label: UILabel!
    @IBOutlet weak var cat2Descrip: UILabel!
    
    @IBOutlet weak var img1: UIImageView!
    
    @IBOutlet weak var img2: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Categories"
        guard let aChannel = monkeyChannel else { return }
        cat1Label.text = aChannel.categories?[0].title
        cat1Descrip.text = aChannel.categories?[0].deskript
        cat2Label.text = aChannel.categories?[1].title
        cat2Descrip.text = aChannel.categories?[1].deskript
        
        let firstURL = changeStringToURL((aChannel.categories?[0].images?.medium)!)
        let secondURL = changeStringToURL((aChannel.categories?[1].images?.medium)!)
        setImages(with: firstURL, url2: secondURL)
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setImages(with url1: URL, url2: URL) {
        DispatchQueue.global().async {
            let data1 = try? Data(contentsOf: url1) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            let data2 = try? Data(contentsOf: url2) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            
            DispatchQueue.main.async {
                self.img1.image = UIImage(data: data1!)
                self.img2.image = UIImage(data: data2!)
            }
        }
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
