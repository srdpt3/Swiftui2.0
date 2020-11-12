//
//  Cart.swift
//  Food App
//
//  Created by Dustin yang on 11/9/20.
//

import SwiftUI

struct Cart: Identifiable {
    
    var id = UUID().uuidString
    var item: Item
    var quantity: Int
}
