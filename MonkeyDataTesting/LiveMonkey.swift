//
//  LiveMonkey.swift
//  MonkeyDataTesting
//
//  Created by Gregory Weiss on 7/20/17.
//  Copyright © 2017 gergusa. All rights reserved.
//

import Foundation

class LiveMonkey {
    var id: String? = ""
    var count: Int? = 0
    var date: String? = ""
    var title: String? = ""
    var deskript: String? = ""
    var image: String? = ""
    var images: MonkeyImage?
    var player: [[String: AnyObject]]? = []
    var liveVideoM3U8: String? = ""
    var backup: String? = ""
    var monetization: String? = ""
    var preroll: [[String: AnyObject]]? = []
    var offline: [[String: AnyObject]]? = []
}



/*
{
    "id": "asba97bb",
    "count": 1,
    "date": "2017-06-26T13:37:00-04:00",
    "title": "Live Streaming",
    "description": "Watch and participate in live streaming events every week including Sunday morning worship experiences at 8:30, 9:45, and 11:05am ET!",
    "image": "//images.streammonkey.com/1280x720/live_sunday_worship_experiences_1920x1080.jpg",
    "images": {
        "1280x720": "//images.streammonkey.com/1280x720/live_sunday_worship_experiences_1920x1080.jpg",
        "720x405": "//images.streammonkey.com/720x405/live_sunday_worship_experiences_1920x1080.jpg",
        "360x203": "//images.streammonkey.com/360x203/live_sunday_worship_experiences_1920x1080.jpg",
        "100x56": "//images.streammonkey.com/100x56/live_sunday_worship_experiences_1920x1080.jpg"
    },
    "player": [
    {
    "auto_start": "Yes",
    "skin": "Seven",
    "progress_bar": "No",
    "aspect": "16:9",
    "quality": "Size",
    "volume": "Yes"
    }
    ],
    "video": [
    {
    "hds": "http://VH76jkn-lh.akamaihd.net/z/First Baptist Cleveland_1@513267/manifest.f4m",
    "hls": "http://VH76jkn-lh.akamaihd.net/i/clevelandfbc_1@513267/master.m3u8?play-only=primary&attributes=on"
    }
    ],
    "backup": "Yes",
    "monetization": "No",
    "preroll": [
    
    ],
    "offline": [
    
    ]
}
*/
