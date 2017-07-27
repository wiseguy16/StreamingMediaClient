//
//  DetailsViewController.swift
//  MonkeyDataTesting
//
//  Created by Gregory Weiss on 7/25/17.
//  Copyright © 2017 gergusa. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class DetailsViewController: UIViewController {
    
    var labelString = ""
    var imageURLString = ""
    var deskriptDetails = ""
    var thisList = ""
    var videos: [MonkeyVideo] = []
    
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var deskripDetailsLabel: UILabel!
    
    @IBOutlet weak var detailsTableView: UITableView!
    
    var anApiController: APIController!


    override func viewDidLoad() {
        super.viewDidLoad()
        anApiController = APIController(delegate: self)
        
        anApiController.getVideoDataFromMonkey(thisList)
        


        detailsLabel.text = labelString
        deskripDetailsLabel.text = deskriptDetails
        let url = changeStringToURL(imageURLString)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            DispatchQueue.main.async {
                self.detailImageView.image = UIImage(data: data!)
            }
        }
        
        detailsTableView.tableFooterView = UIView()


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


extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "Videos On Demand - Categories"
//    }
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return videos.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailVideoCell", for: indexPath) as! DetailVideoCell
        let aVid = videos[indexPath.row]
        cell.titleLabel.text = aVid.title
        cell.descriptionLabel.text = aVid.deskript
        if let urlString = aVid.image {
            let url = changeStringToURL(urlString)
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                DispatchQueue.main.async {
                    cell.monkeyImageView.image = UIImage(data: data!)
                }
            }
        }
        // Configure the cell...
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        detailsTableView.deselectRow(at: indexPath, animated: true)
        let aVid = videos[indexPath.row]
        if let file = aVid.m3u8file {
            let theURL = "http:" + file
            let videoURL = URL(string: theURL)
            let player = AVPlayer(url: videoURL!)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            self.present(playerViewController, animated: true) {
                playerViewController.player?.play()
            }
        }
    }
    
    
}

extension DetailsViewController: APIControllerProtocol {
    func gotTheVideos(withOrder value: String, theMonkeys: [MonkeyChannel]) {
        print("fidu7")
    }
    
    func gotTheseVideos(withOrder value: String, thePlaylist: MonkeyPlaylist) {
        print(value)
        guard let theVids = thePlaylist.videos else { return }
        videos = theVids
//        for vid in videos {
//            guard let title = vid.title, let date = vid.date, let deskript = vid.deskript, let image = vid.image, let videoM3U8 = vid.m3u8file else { return }
//            
//    //****** THIS IS WHERE CURRENT DATABASE STORAGE HAPPENS  **********************
//            CoreDataManager.storeObj(with: title, date: date, deskript: deskript, image: image, videoM3U8: videoM3U8)
//        }
        detailsTableView.reloadData()

    }
    
}


