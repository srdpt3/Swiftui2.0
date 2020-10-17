//
//  VideoModel.swift
//  Africa
//
//  Created by Dustin yang on 10/17/20.
//

import Foundation

struct Video: Codable, Identifiable{
    let id : String
    let name : String
    let headline : String
    
    
    //Computed Property
    
    var thumnail : String {
        "video-\(id)"
    }
}


