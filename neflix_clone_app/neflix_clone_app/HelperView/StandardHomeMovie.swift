//
//  StandardHomeMovie.swift
//  neflix_clone_app
//
//  Created by Dustin yang on 1/17/21.
//
import SwiftUI
import struct Kingfisher.KFImage
struct StandardHomeMovie: View {
    var movie: Movie
    
    var body: some View {
        KFImage(movie.thumbnailURL)
            .resizable()
            .scaledToFill()
    }
}

struct StandardHomeMovie_Previews: PreviewProvider {
    static var previews: some View {
        StandardHomeMovie(movie: exampleMovie1)
    }
}
