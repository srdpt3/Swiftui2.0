//
//  HomeViewModel.swift
//  Animated Sticky Header With Scrollable Tabs
//
//  Created by Dustin yang on 1/10/21.
//


import SwiftUI

class HomeViewModel: ObservableObject{
    @Published var offset: CGFloat = 0
    
    // Selected Tab....
    @Published var selectedtab = tabsItems.first!.tab
}
