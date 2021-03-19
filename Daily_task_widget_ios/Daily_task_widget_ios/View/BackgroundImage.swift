//
//  BackgroundImage.swift
//  Daily_task_widget_ios
//
//  Created by Dustin yang on 3/16/21.
//

import SwiftUI

struct BackgroundImage: View {
    var body: some View {
        Image("disney").antialiased(true).resizable().scaledToFill().ignoresSafeArea(.all)
    }
}

struct BackgroundImage_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundImage()
    }
}
