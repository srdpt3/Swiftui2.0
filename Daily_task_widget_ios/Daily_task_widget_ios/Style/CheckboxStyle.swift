//
//  CheckboxStyle.swift
//  Daily_task_widget_ios
//
//  Created by Dustin yang on 3/18/21.
//

import SwiftUI

struct CheckboxStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        return HStack{
            Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                .foregroundColor(configuration.isOn ? .pink : .primary)
                .font(.system(size: 30, weight: .semibold,design: .rounded))
                .onTapGesture {
                    configuration.isOn.toggle()
                }
            configuration.label
        }
    }
}

struct CheckboxStyle_Previews: PreviewProvider {
    static var previews: some View {
        Toggle("placeholder labe", isOn:.constant(false))
            .toggleStyle(CheckboxStyle())
            .padding().previewLayout(.sizeThatFits)
    }
}
