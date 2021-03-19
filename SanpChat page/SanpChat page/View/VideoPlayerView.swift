//
//  VideoPlayerView.swift
//  SanpChat page
//
//  Created by Dustin yang on 1/16/21.
//
import SwiftUI
import AVKit

// Im Going to use native AV Video Player since SwiftUI Video Player Has not having enough features...

struct VideoPlayerView: UIViewControllerRepresentable {
    
    var player: AVPlayer
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        
        let controller = AVPlayerViewController()
        controller.player = player
//        controller.
        controller.videoGravity = .resizeAspectFill
        controller.showsPlaybackControls = false
        return controller
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        
    }
}
