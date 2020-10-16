//
//  CartView.swift
//  Custom_Swipe_to_delete
//
//  Created by Dustin yang on 10/10/20.
//

import SwiftUI

struct CartView: View {
    var body: some View {
        VStack{
            HStack(spacing: 20){
                Button(action: {}, label: {
                    Image(systemName: "chevron.left").font(.system(size: 26, weight: .heavy)).foregroundColor(.black)
                })
                
                Text("My Cart").font(.title).fontWeight(.heavy).foregroundColor(.black)
                Spacer()
                
                
                
                
            }.padding()
            Spacer(minLength: 0)
        }.background(Color.gray.ignoresSafeArea())
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
