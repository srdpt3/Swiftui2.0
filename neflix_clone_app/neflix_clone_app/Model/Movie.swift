//
//  Movie.swift
//  neflix_clone_app
//
//  Created by Dustin yang on 1/17/21.
//

import Foundation

struct Movie: Identifiable {
    var id: String
    var name: String
    var thumbnailURL: URL
    
    var categories: [String]
}
