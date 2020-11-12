//
//  ContentView.swift
//  FoodDelivery
//
//  Created by Dustin yang on 11/9/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            
            Home()
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
