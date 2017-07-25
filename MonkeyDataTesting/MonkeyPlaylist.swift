//
//  MonkeyPlaylist.swift
//  MonkeyDataTesting
//
//  Created by Gregory Weiss on 7/20/17.
//  Copyright © 2017 gergusa. All rights reserved.
//

import Foundation

class MonkeyPlaylist {
    var id: String? = ""
    var count: Int? = 0
    var date: String? = ""
    var title: String? = ""
    var deskript: String? = ""
    var image: String? = ""
    var images: MonkeyImage?
    var genre: String? = ""
    var videos: [MonkeyVideo]? = []
    
        init(dictionary: [String: AnyObject]) {
            self.id = dictionary["id"] as? String
            self.count = dictionary["count"] as? Int
            self.date = dictionary["date"] as? String
            self.title = dictionary["title"] as? String
            self.deskript = dictionary["description"] as? String
            self.image = dictionary["image"] as? String
            self.images = makeMonkeyImage(from: dictionary["images"] as! [String: AnyObject])
            self.genre = dictionary["genre"] as? String
            self.videos = makeVideos(from: dictionary["videos"] as! [[String: AnyObject]])
    }

    
}

extension MonkeyPlaylist {
    
    func makeMonkeyImage(from dict: [String: AnyObject]) -> MonkeyImage {
        let imagesDict = dict
        let large = imagesDict["1280x720"] as? String
        let medium = imagesDict["720x405"] as? String
        let small = imagesDict["360x203"] as? String
        let thumb = imagesDict["100x56"] as? String
        
        let picStrings = MonkeyImage()
        picStrings.large = large
        picStrings.medium = medium
        picStrings.small = small
        picStrings.thumb = thumb
        
        return picStrings
    }
    
    func makeVideos(from array:[[String: AnyObject]]) -> [MonkeyVideo] {
        var monkeyVidArray: [MonkeyVideo] = []
        for videoDict in array {
            
            let id = videoDict["id"] as? String
            let count = videoDict["count"] as? Int
            let date = videoDict["date"] as? String
            let title = videoDict["title"] as? String
            let deskript = videoDict["description"] as? String
            let author = videoDict["author"] as? String
            let image = videoDict["image"] as? String
            let images = makeMonkeyImage(from: videoDict["images"] as! [String: AnyObject])
            let genre = videoDict["genre"] as? String
            let explicit = videoDict["explicit"] as? String
            let file = videoDict["file"] as? [[String: AnyObject]]
            let m3u8File = makeTheVideoRef(from: videoDict["file"] as! [[String: AnyObject]])
            
            let aVideo = MonkeyVideo()
            aVideo.id = id
            aVideo.count = count
            aVideo.date = date
            aVideo.title = title
            aVideo.deskript = deskript
            aVideo.author = author
            aVideo.image = image
            aVideo.images = images
            aVideo.genre = genre
            aVideo.explicit = explicit
            aVideo.file = file
            aVideo.m3u8file = m3u8File
            
            monkeyVidArray.append(aVideo)
        }
        
        return monkeyVidArray
    }
    

    
    func makeTheVideoRef(from array:[[String: AnyObject]]) -> String {
        var m3u8Ref = ""
        for videoDict in array {
            //let hds = liveDict["hds"] as? String
            if let hls = videoDict["hls"] as? String {
                m3u8Ref = hls
            }
        }
        return m3u8Ref
    }

}
