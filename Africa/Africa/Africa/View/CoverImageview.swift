//
//  CoverImageview.swift
//  Africa
//
//  Created by Dustin yang on 10/10/20.
//

import SwiftUI

struct CoverImageview: View {
    
    let coverImage : [CoverImage] = Bundle.main.decode("covers.json")
    
    var body: some View {
        TabView{
            ForEach(coverImage) { item in
                Image(item.name).resizable().scaledToFill()
            }

        }.tabViewStyle(PageTabViewStyle())
    }
}

struct CoverImageview_Previews: PreviewProvider {
    static var previews: some View {
        CoverImageview().previewLayout(.fixed(width: 400, height: 300))
    }
}
