//
//  Tab.swift
//  Animated Sticky Header With Scrollable Tabs
//
//  Created by Dustin yang on 1/10/21.
//


import SwiftUI

// Tab Model With Tab Items....

struct Tab: Identifiable {
    
    var id = UUID().uuidString
    var tab : String
    var foods: [Food]
}
var tabsItems = [

    Tab(tab: "Order Again", foods: foods.shuffled()),
    Tab(tab: "Picked For You", foods: foods.shuffled()),
    Tab(tab: "Starters", foods: foods.shuffled()),
    Tab(tab: "Side", foods: foods.shuffled()),
]
