//
//  SearchViewController.swift
//  MonkeyDataTesting
//
//  Created by Gregory Weiss on 7/27/17.
//  Copyright © 2017 gergusa. All rights reserved.
//

import UIKit
import CoreData

class SearchViewController: UIViewController {
    var foundVideos: [RawVideo] = []
    
    
    @IBOutlet weak var searchTextField: UITextField!

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
                
            }
        }
        self.view.endEditing(true)
        return true
    }
}

