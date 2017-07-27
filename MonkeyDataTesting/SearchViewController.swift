//
//  SearchViewController.swift
//  MonkeyDataTesting
//
//  Created by Gregory Weiss on 7/27/17.
//  Copyright © 2017 gergusa. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation
import AVKit

class SearchViewController: UIViewController {
    var foundVideos: [RawVideo] = []
    
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var resultsLabel: UILabel!
    @IBOutlet weak var resultsTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.becomeFirstResponder()

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

extension SearchViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if searchTextField.text != nil  {
            if searchTextField.text!.characters.count > 0 {
              foundVideos = CoreDataManager.searchAndFetchObjs(from: searchTextField.text!)
                print(foundVideos.count)
                resultsLabel.text = "Results found for: " + searchTextField.text!
                
            }
        }
        self.view.endEditing(true)
        resultsTableView.reloadData()
        return true
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "Videos On Demand - Categories"
//    }
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return foundVideos.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultsCell", for: indexPath) as! ResultsCell
        let aRVid = foundVideos[indexPath.row]
        cell.titleLabel.text = aRVid.title
        cell.deskriptLabel.text = aRVid.deskript
        
        if let urlString = aRVid.image {
            let url = changeStringToURL(urlString)
            // print(url)
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                DispatchQueue.main.async {
                    cell.resultImageView.image = UIImage(data: data!)
                }
            }
            
        }
        
        // Configure the cell...
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        resultsTableView.deselectRow(at: indexPath, animated: true)
        let aRVid = foundVideos[indexPath.row]
        if let file = aRVid.videoM3U8 {
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


