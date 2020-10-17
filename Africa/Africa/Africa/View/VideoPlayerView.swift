//
//  VideoPlayerView.swift
//  Africa
//
//  Created by Dustin yang on 10/17/20.
//

import SwiftUI
import AVKit

struct VideoPlayerView: View {
    
    var videoSelected : String
    var videTitle : String
    var body: some View {
//        VideoPlayer(player: AVPlayer(url: Bundle.main.url(forResource: "cheetah", withExtension: "mp4")!))
        VStack {
            VideoPlayer(player: playVideo(fileName: videoSelected, fileFormat: ".mp4")){
//                Text(videTitle)
            }.overlay(Image("logo").resizable().scaledToFit().frame(width: 32, height: 32).padding(.top, 6).padding(.horizontal,8),alignment: .topLeading)
        }.accentColor(.accentColor).navigationBarTitle(videTitle, displayMode: .inline)
    }
}

struct VideoPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            VideoPlayerView(videoSelected: "lion", videTitle: "Lion")

        }
    }
}
