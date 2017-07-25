//
//  MonkeyVideo.swift
//  MonkeyDataTesting
//
//  Created by Gregory Weiss on 7/24/17.
//  Copyright © 2017 gergusa. All rights reserved.
//

import Foundation

class MonkeyVideo {
    var id: String? = ""
    var count: Int? = 0
    var date: String? = ""
    var title: String? = ""
    var deskript: String? = ""
    var author: String? = ""
    var image: String? = ""
    var images: MonkeyImage?
    var genre: String? = ""
    var explicit: String? = ""
    var file: [[String: AnyObject]]? = []
    var player: [String]? = []
    var times: [String]? = []
    var external: [String]? = []
    var m3u8file: String? = ""
    
//    init(dictionary: [String: AnyObject]) {
//        self.id = dictionary["id"] as? String
//        self.count = dictionary["count"] as? Int
//        self.date = dictionary["date"] as? String
//        self.title = dictionary["title"] as? String
//        self.deskript = dictionary["description"] as? String
//        self.author = dictionary["author"] as? String
//        self.image = dictionary["image"] as? String
//        self.images = makeMonkeyImage(from: dictionary["images"] as! [String: AnyObject])
//        self.genre = dictionary["genre"] as? String
//        self.explicit = dictionary["explicit"] as? String
//        self.file = dictionary["file"] as? [[String: AnyObject]]
//        self.player = dictionary["player"] as? [String]
//        self.times = dictionary["times"] as? [String]
//        self.external = dictionary["external"] as? [String]
//        self.m3u8file = makeTheVideoRef(from: dictionary["file"] as! [[String: AnyObject]])
//        
//    }
}

//extension MonkeyVideo {
//    func makeMonkeyImage(from dict: [String: AnyObject]) -> MonkeyImage {
//        let imagesDict = dict
//        let large = imagesDict["1280x720"] as? String
//        let medium = imagesDict["720x405"] as? String
//        let small = imagesDict["360x203"] as? String
//        let thumb = imagesDict["100x56"] as? String
//        
//        let picStrings = MonkeyImage()
//        picStrings.large = large
//        picStrings.medium = medium
//        picStrings.small = small
//        picStrings.thumb = thumb
//        
//        return picStrings
//    }
//    
//    func makeTheVideoRef(from array:[[String: AnyObject]]) -> String {
//        var m3u8Ref = ""
//        for videoDict in array {
//            //let hds = liveDict["hds"] as? String
//            if let hls = videoDict["hls"] as? String {
//                m3u8Ref = hls
//            }
//        }
//        return m3u8Ref
//    }
//
//
//}
