//
//  TextFieldStyle.swift
//  promanageconstruction
//
//  Created by TechGlock Software Solutions on 28/03/23.
//

import Foundation
import SwiftUI
public struct BottomLineTextFieldStyle: TextFieldStyle {
    let color:Color
    public func _body(configuration: TextField<Self._Label>) -> some View {
        VStack() {
            configuration
            Rectangle()
                .frame(height: 0.5, alignment: .bottom)
                .foregroundColor(color)
        }
    }
}
