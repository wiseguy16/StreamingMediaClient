//
//  MonkeyImagesViewController.swift
//  MonkeyDataTesting
//
//  Created by Gregory Weiss on 7/20/17.
//  Copyright © 2017 gergusa. All rights reserved.
//

import UIKit

class MonkeyImagesViewController: UIViewController {
    var monkeyPics: MonkeyImage?
    
    @IBOutlet weak var largeImage: UIImageView!
    @IBOutlet weak var mediumImage: UIImageView!
    @IBOutlet weak var smallImage: UIImageView!
    
    @IBOutlet weak var thumbImage: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Different Images"
        
        
        if monkeyPics != nil {
            let sizes = monkeyPics
            guard let large = sizes?.large else { return }
            let lrgURL = changeStringToURL(large)
            guard let medium = sizes?.medium else { return }
            let medURL = changeStringToURL(medium)
            guard let small = sizes?.small else { return }
            let smlURL = changeStringToURL(small)
            guard let thumb = sizes?.thumb else { return }
            let thmbURL = changeStringToURL(thumb)
            
            setImages(with: lrgURL, url2: medURL, url3: smlURL, url4: thmbURL)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setImages(with url1: URL, url2: URL, url3: URL, url4: URL) {
        DispatchQueue.global().async {
            let data1 = try? Data(contentsOf: url1) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            let data2 = try? Data(contentsOf: url2) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            let data3 = try? Data(contentsOf: url3) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            let data4 = try? Data(contentsOf: url4) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch

            DispatchQueue.main.async {
                self.largeImage.image = UIImage(data: data1!)
                self.mediumImage.image = UIImage(data: data2!)
                self.smallImage.image = UIImage(data: data3!)
                self.thumbImage.image = UIImage(data: data4!)
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
