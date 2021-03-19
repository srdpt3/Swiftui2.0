//
//  Video.swift
//  SanpChat page
//
//  Created by Dustin yang on 1/16/21.
//
import SwiftUI
import AVKit

// Video Model And Model Videos...

struct Video: Identifiable {
    var id = UUID().uuidString
    var player: AVPlayer
}

// Getting URL From Bundle...
func getBundleURL(fileName: String)->URL{
    let bundle = Bundle.main.path(forResource: fileName, ofType: "mp4")
    
    return URL(fileURLWithPath: bundle!)
}

var videos = [
    
    Video(player: AVPlayer(url: getBundleURL(fileName: "video12"))),
    Video(player: AVPlayer(url: getBundleURL(fileName: "video10"))),

    Video(player: AVPlayer(url: getBundleURL(fileName: "video11"))),

    Video(player: AVPlayer(url: getBundleURL(fileName: "video2"))),
    Video(player: AVPlayer(url: getBundleURL(fileName: "video3"))),
    Video(player: AVPlayer(url: getBundleURL(fileName: "video4"))),
    Video(player: AVPlayer(url: getBundleURL(fileName: "video5"))),
    Video(player: AVPlayer(url: getBundleURL(fileName: "video6"))),
    Video(player: AVPlayer(url: getBundleURL(fileName: "video7"))),
    Video(player: AVPlayer(url: getBundleURL(fileName: "video8"))),
    Video(player: AVPlayer(url: getBundleURL(fileName: "video15"))),

]
