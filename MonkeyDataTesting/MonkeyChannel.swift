//
//  Monkey.swift
//  MonkeyDataTesting
//
//  Created by Gregory Weiss on 7/20/17.
//  Copyright © 2017 gergusa. All rights reserved.
//

import Foundation
import UIKit

class MonkeyChannel {
    
    var id: String? = ""
    var date: String? = ""
    var title: String? = ""
    var organization: String? = ""
    var whiteLabel: Bool? = true
    var theme: String? = ""
    var image: String? = ""
    var images: MonkeyImage?
    var featured: [[String: AnyObject]]?
    var categories: [MonkeyCategory]? = []
    var liveStreams: [LiveMonkey]? = []
    
    init(dictionary: [String: AnyObject]) {
        self.id = dictionary["id"] as? String
        self.date = dictionary["date"] as? String
        self.title = dictionary["title"] as? String
        self.organization = dictionary["organization"] as? String
        self.whiteLabel = dictionary["whitelabel"] as? Bool
        self.theme = dictionary["theme"] as? String
        self.image = dictionary["image"] as? String
        
        if dictionary["images"] != nil {
            self.images = makeMonkeyImage(from: dictionary["images"] as! [String: AnyObject])
        }
        
        if dictionary["featured"] != nil {
            if dictionary["featured"]!.count > 0 {
                // FIX ME!!!!
                print("you have features!")
            }
        }
        
        if dictionary["categories"] != nil {
            let catArray = dictionary["categories"] as! [[String: AnyObject]]
            for catDict in catArray {
                let cat = makeMonkeyCategory(from: catDict)
                categories?.append(cat)
            }
        }
        
        if dictionary["livestreams"] != nil {
            let liveArray = dictionary["livestreams"] as! [[String: AnyObject]]
            for liveDict in liveArray {
                let liveMonkey = makeLiveStream(from: liveDict)
                liveStreams?.append(liveMonkey)
            }
        
        }
    }
    
}


extension MonkeyChannel {
    
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
    
    func makeMonkeyCategory(from dict:[String: AnyObject]) -> MonkeyCategory {
        let catDict = dict
        let id = catDict["id"] as? String
        let count = catDict["count"] as? Int
        let date = catDict["date"] as? String
        let title = catDict["title"] as? String
        let deskript = catDict["description"] as? String
        let image = catDict["image"] as? String
        let images = makeMonkeyImage(from: catDict["images"] as! [String: AnyObject])
        let playlistsArray = makePlaylistInfo(from: catDict["playlists"] as! [[String: AnyObject]])
        
        let aCategory = MonkeyCategory()
        aCategory.id = id
        aCategory.count = count
        aCategory.date = date
        aCategory.title = title
        aCategory.deskript = deskript
        aCategory.image = image
        aCategory.images = images
        aCategory.playlistsInfo = playlistsArray
        
        return aCategory
    }
    
    func makeLiveStream(from dict:[String: AnyObject]) -> LiveMonkey {
        let liveDict = dict
        let id = liveDict["id"] as? String
        let count = liveDict["count"] as? Int
        let date = liveDict["date"] as? String
        let title = liveDict["title"] as? String
        let deskript = liveDict["description"] as? String
        let image = liveDict["image"] as? String
        let images = makeMonkeyImage(from: liveDict["images"] as! [String: AnyObject])
        let player = liveDict["player"] as? [[String: AnyObject]] // Fix ME!!!
        let video = makeTheVideoRef(from: liveDict["video"] as! [[String: AnyObject]])
        let backup = liveDict["backup"] as? String
        let monetization = liveDict["monetization"] as? String
        let preroll = liveDict["preroll"] as? [[String: AnyObject]]
        let offline = liveDict["offline"] as? [[String: AnyObject]]
        
        let aLiveStream = LiveMonkey()
        aLiveStream.id = id
        aLiveStream.count = count
        aLiveStream.date = date
        aLiveStream.title = title
        aLiveStream.deskript = deskript
        aLiveStream.image = image
        aLiveStream.images = images
        aLiveStream.player = player
        aLiveStream.liveVideoM3U8 = video
        aLiveStream.backup = backup
        aLiveStream.monetization = monetization
        aLiveStream.preroll = preroll
        aLiveStream.offline = offline

        return aLiveStream
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
    
    func makePlaylistInfo(from array:[[String: AnyObject]]) -> [MonkeyPlaylistInfo] {
        var infoArray: [MonkeyPlaylistInfo] = []
        for infoDict in array {
            let id = infoDict["id"] as? String
            let count = infoDict["count"] as? Int
            let date = infoDict["date"] as? String
            let title = infoDict["title"] as? String
            let deskript = infoDict["description"] as? String
            let image = infoDict["image"] as? String
            let images = makeMonkeyImage(from: infoDict["images"] as! [String: AnyObject])
            let genre = infoDict["genre"] as? String
            
            let aListInfo = MonkeyPlaylistInfo()
            aListInfo.id = id
            aListInfo.count = count
            aListInfo.date = date
            aListInfo.title = title
            aListInfo.deskript = deskript
            aListInfo.image = image
            aListInfo.images = images
            aListInfo.genre = genre
            
            infoArray.append(aListInfo)
        }
        return infoArray
        
    }

    
}
