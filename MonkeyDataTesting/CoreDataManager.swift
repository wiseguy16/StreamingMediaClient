//
//  CoreDataManager.swift
//  UsersAndPsswds
//
//  Created by Gregory Weiss on 7/23/17.
//  Copyright © 2017 gergusa. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager: NSObject {
    private class func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    class func storeObj(with title: String, date: String, deskript: String, image: String, videoM3U8: String) {
        let context = getContext()
        guard let entity = NSEntityDescription.entity(forEntityName: "RawVideoEntity", in: context) else { return }
        let managedObj = NSManagedObject(entity: entity, insertInto: context)
        managedObj.setValue(title, forKey: "title")
        managedObj.setValue(date, forKey: "date")
        managedObj.setValue(deskript, forKey: "deskript")
        managedObj.setValue(image, forKey: "image")
        managedObj.setValue(videoM3U8, forKey: "videoM3U8")

        
        do {
            try context.save()
            print("saved this: \(title) \(deskript)")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    class func fetchObj() -> [RawVideo] {
        var rawArray = [RawVideo]()
        
        let fetchRequest: NSFetchRequest<RawVideoEntity> = RawVideoEntity.fetchRequest()
        
        do {
            
            let fetchResult = try getContext().fetch(fetchRequest)
            
            for item in fetchResult {
                
                if let title = item.title, let date = item.date, let deskript = item.deskript, let image = item.image, let videoM3U8 = item.videoM3U8 {
                    
                    let vid = RawVideo(title: title, date: date, deskript: deskript, image: image, videoM3U8: videoM3U8)
                    
                    rawArray.append(vid)
                }
            }
           // print(fetchResult)
        } catch {
            print(error.localizedDescription)
        }
        for vid in rawArray {
            print(vid.image!)
        }
        
        return rawArray
        
    }

}
