//
//  HideKeyboardExtension.swift
//  Daily_task_widget_ios
//
//  Created by Dustin yang on 3/15/21.
//

import SwiftUI

#if canImport(UIKit)
extension View{
    func hidKeyboard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#endif
