//
//  MonkeyVideosTableViewController.swift
//  MonkeyDataTesting
//
//  Created by Gregory Weiss on 7/24/17.
//  Copyright © 2017 gergusa. All rights reserved.
//

import UIKit

class MonkeyVideosTableViewController: UITableViewController {
    
    var monkeyCat: MonkeyCategory!
    var monkeyVids: [MonkeyVideo]? = []
    var monkeyPlaylist: MonkeyPlaylist?
    var monkeyPlaylistInfo: MonkeyPlaylistInfo!
    var theseVideosString = client
    var playlists: [MonkeyPlaylistInfo] = []
    
    var anApiController: APIController!


    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Playlists"
        playlists = monkeyCat.playlistsInfo!
        tableView.reloadData()
        print(playlists.count)
        anApiController = APIController(delegate: self)

        tableView.tableFooterView = UIView()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return playlists.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MonkeyVideoCell", for: indexPath) as! MonkeyVideoCell
        let aPlaylist = playlists[indexPath.row]
        
        cell.titleLabel.text = aPlaylist.title
        cell.descriptionLabel.text = aPlaylist.deskript
        var unwrappedString = ""
        if let urlString = aPlaylist.image {
            unwrappedString = urlString
        }
        let url = changeStringToURL(unwrappedString)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            DispatchQueue.main.async {
                cell.monkeyImageView.image = UIImage(data: data!)
            }
        }
        // Configure the cell...

        return cell
    }
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailsSegue" {
            if let path = tableView.indexPathForSelectedRow {
               let aList = playlists[path.row]
                let destVC = segue.destination as! DetailsViewController
                guard let aTitle = aList.title, let urlString = aList.image, let deskrip = aList.deskript, let id = aList.id else { return }
                destVC.labelString = aTitle
                destVC.imageURLString = urlString
                destVC.deskriptDetails = deskrip
                destVC.thisList = id
            }
            
          //  let destVC = segue.destination as! DetailsViewController
          //  destVC.labelString = aList.title
            print("In the Segue")
        }
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
    

    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//       // let aCat = monkeyCategories[indexPath.row]
//       // let aListInfo = aCat.playlistsInfo![0]
//        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "MonkeyVideosTableViewController") as! MonkeyVideosTableViewController
//       // detailVC.monkeyCat = aCat
//       // detailVC.monkeyPlaylistInfo = aListInfo
//        self.navigationController?.pushViewController(detailVC, animated: true)
//    }
}

extension MonkeyVideosTableViewController: APIControllerProtocol {
    func gotTheVideos(withOrder value: String, theMonkeys: [MonkeyChannel]) {
        print("fidu7")
    }
    
    func gotTheseVideos(withOrder value: String, thePlaylist: MonkeyPlaylist) {
        print("123ds")
        guard let theVids = thePlaylist.videos else { return }
        for aVid in theVids {
            let image = aVid.image
            let title = aVid.title
            print(title)
        }
    }

}
