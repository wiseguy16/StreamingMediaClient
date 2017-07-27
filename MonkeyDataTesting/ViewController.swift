//
//  ViewController.swift
//  MonkeyDataTesting
//
//  Created by Gregory Weiss on 7/20/17.
//  Copyright © 2017 gergusa. All rights reserved.
//

import UIKit
protocol APIControllerProtocol
{
    func gotTheVideos(withOrder value: String, theMonkeys: [MonkeyChannel])
    func gotTheseVideos(withOrder value: String, thePlaylist: MonkeyPlaylist)
}

let backupString = "NOT AVAILABLE"
let backupURLString = "//placeimg.com/320/180/tech/grayscale"



class ViewController: UIViewController {
    
    var backupURL: URL?
    
    @IBOutlet weak var liveLabel: UILabel!
    @IBOutlet weak var liveImageView: UIImageView!
    
    @IBOutlet weak var liveDeskriptLabel: UILabel!
    
    
    @IBOutlet weak var bgBlurImageView: UIImageView!
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var organizationLabel: UILabel!
    @IBOutlet weak var whiteLabel: UILabel!
    @IBOutlet weak var themeLabel: UILabel!
    @IBOutlet weak var imageLabel: UILabel!
    
    @IBOutlet weak var monkeyTableView: UITableView!
    
    var arrayOfVideos: [Video] = []
    var monkeys: [MonkeyChannel] = []
    var monkeyCategories: [MonkeyCategory] = []
    var theseVideosString = client
    var apiStrings: [String] = []

    var anApiController: APIController!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = clientTitle
        anApiController = APIController(delegate: self)
        anApiController.getVideoFullServicesDataFromVimeo(theseVideosString)
        backupURL = URL(string: backupURLString)
        monkeyTableView.tableFooterView = UIView()
        CoreDataManager.fetchObj()
       // anApiController.getAllVideoDataFromMonkey()

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ImagesSegue" {
            let destVC = segue.destination as! MonkeyImagesViewController
            guard let pics = monkeys[0].images else { return }
            destVC.monkeyPics = pics
            
        }
        else if segue.identifier == "CategoriesSegue" {
            let destVC = segue.destination as! MonkeyCategoryViewController
            if monkeys.count > 0 {
             let theChannel = monkeys.first
                destVC.monkeyChannel = theChannel
            }
            
        }
        else if segue.identifier == "SearchSegue" {
            let destVC = segue.destination as! SearchViewController
            destVC.title = "Search Videos"
            print("Went to searching")
            
        }
    }


}

extension ViewController: APIControllerProtocol {
    func gotTheVideos(withOrder value: String, theMonkeys: [MonkeyChannel])
    {
        if value == "a"
        {
            monkeys = theMonkeys
            if monkeys.count > 0 {
                let firstMonkey = monkeys[0]
                guard let image = firstMonkey.image else { return }
                guard let liveStream = firstMonkey.liveStreams else { return }
                
                let liveTitle = liveStream.first?.title ?? backupString
                liveLabel.text = liveTitle
                
                let liveDeskript = liveStream.first?.deskript ?? backupString
                liveDeskriptLabel.text = liveDeskript
                
                let aStringURL = liveStream.first?.image ?? backupURLString
                let liveURL = changeStringToURL(aStringURL)
                let url = changeStringToURL(image)
                
                if let cats = firstMonkey.categories {
                    for cat in cats {
                        monkeyCategories.append(cat)
                    }
                    monkeyTableView.reloadData()

                }
                
                DispatchQueue.global().async {
                    let data = try? Data(contentsOf: url) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                    let dataLive = try? Data(contentsOf: liveURL)
                    DispatchQueue.main.async {
                        self.mainImageView.image = UIImage(data: data!)
                        self.bgBlurImageView.image = UIImage(data: data!)
                        self.addBlur(onImage: self.bgBlurImageView)
                        self.liveImageView.image = UIImage(data: dataLive!)
                        self.addShadowToImageView(imageView: self.liveImageView)
                    }
                }
                
                self.view.setNeedsDisplay()
            }            
        }
    }
    
    func gotTheseVideos(withOrder value: String, thePlaylist: MonkeyPlaylist) {
        print("ufgw9")
    }
    


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Videos On Demand - Categories"
    }
     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return monkeyCategories.count
    }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MonkeyCell", for: indexPath) as! MonkeyCell
        let aCat = monkeyCategories[indexPath.row]
        cell.monkeyLabel.text = aCat.title
        if let urlString = aCat.image {
            let url = changeStringToURL(urlString)
           // print(url)
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
        monkeyTableView.deselectRow(at: indexPath, animated: true)
        let aCat = monkeyCategories[indexPath.row]
        if aCat.playlistsInfo != nil  {
            if (aCat.playlistsInfo?.count)! > 0 {
                if let aListInfo = aCat.playlistsInfo?[0]  {
                    let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "MonkeyVideosTableViewController") as! MonkeyVideosTableViewController
                    detailVC.monkeyCat = aCat
                    detailVC.monkeyPlaylistInfo = aListInfo
                    self.navigationController?.pushViewController(detailVC, animated: true)
                }
            } else {
                print("not the droids you are looking for")
                anApiController.networkAlert()
            }
        } else {
            print("not the droids you are looking for")
            anApiController.networkAlert()
        }
        
//        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "MonkeyVideosTableViewController") as! MonkeyVideosTableViewController
//        detailVC.monkeyCat = aCat
//        detailVC.monkeyPlaylistInfo = aListInfo
//        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
   
}

extension UIViewController {
    
    func addBlur(onImage bgView: UIImageView) {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bgView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        bgView.addSubview(blurEffectView)
    }
    
    func changeStringToURL(_ sizeAsString: String) -> URL {
        let localBackupURLString = "https://placeimg.com/320/180/tech/grayscale"
        let localBackupURL = URL(string: localBackupURLString)
        var newString = ""
        if sizeAsString == "" {
            newString = localBackupURLString
        } else {
            newString = "http:" + sizeAsString
        }
        let url = URL(string: newString) ?? localBackupURL
        return url!
    }
    
    func addShadowToImageView(imageView: UIImageView) {
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOpacity = 1
        imageView.layer.shadowOffset = CGSize.zero
        imageView.layer.shadowRadius = 10
        imageView.layer.shadowPath = UIBezierPath(rect: imageView.bounds).cgPath
        imageView.layer.shouldRasterize = false
        imageView.layer.cornerRadius = 10
    }
    


}

