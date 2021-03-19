//
//  Constant.swift
//  Daily_task_widget_ios
//
//  Created by Dustin yang on 3/14/21.
//

import SwiftUI



let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()


// UI
var backgroundGradient : LinearGradient {
    return LinearGradient(gradient: Gradient(colors: [Color.pink, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
}
