//
//  ToggleStyle.swift
//  mvvm base
//
//  Created by TechGlock Software Solutions on 21/03/23.
//

import Foundation
import SwiftUI
struct ImageToggleStyle: ToggleStyle {
 
    var onImage = "checkmark.square"
    var offImage = "square"
 
    func makeBody(configuration: Self.Configuration) -> some View {

            return HStack {
                Image(systemName: configuration.isOn ? onImage : offImage)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(configuration.isOn ? .blue : .gray)
                    .font(.system(size: 20, weight: .regular, design: .default))
                    configuration.label
            }
            .onTapGesture { configuration.isOn.toggle() }

        }
}
