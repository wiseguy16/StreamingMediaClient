//
//  RawVideo.swift
//  MonkeyDataTesting
//
//  Created by Gregory Weiss on 7/26/17.
//  Copyright © 2017 gergusa. All rights reserved.
//

import Foundation

class RawVideo {
    var title: String?
   // var idString: String? = ""
    var date: String?
    var deskript: String?
    var image: String?
    var videoM3U8: String?
    
    init() {
        title = ""
        date = ""
        deskript = ""
        image = ""
        videoM3U8 = ""
    }
    
    init(title: String, date: String, deskript: String, image: String, videoM3U8: String) {
        self.title = title
        self.date = date
        self.deskript = deskript
        self.image = image
        self.videoM3U8 = videoM3U8
    }
}

/*
 "title": "The Wilderness Experience",
 "id": "23052",
 "urlTitle": "z2fpdcwu",
 "date": "1500782400",
 "editDate": "1500993744",
 "details": {
 "description": "Dr. Jim Henry, senior pastor of First Baptist Orlando for 29 years, shares an encouraging message about God's provisions for his people through tough times. Dr. Henry discusses a chapter from Exodus and how to survive the wilderness by following God.",
 "image": "http://images.streammonkey.com/2017_specialguest_04_The-Wilderness-Experience.jpg",
 "author": "",
 "explicit": "Clean",
 "video": {
 "name": "2017-07-23_The-Wilderness-Experience.mp4",
 "size": "0",
 "duration": "0",
 "children": "4",
 "hls": "http://VH76jkn-vh.akamaihd.net/i/transcoded/2017-07-23_The-Wilderness-Experience.mp4/,0,1,2,3,.mp4.csmil/master.m3u8?",
 "download": "http://download.streammonkey.com/VH76jkn/transcoded/2017-07-23_The-Wilderness-Experience.mp4/0.mp4"
 },
 "player": {
 
 
 */
