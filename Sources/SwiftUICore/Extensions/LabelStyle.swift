//
//  LabelStyle.swift
//  mvvm base
//
//  Created by TechGlock Software Solutions on 22/03/23.
//

import Foundation
import SwiftUI
public struct HStackLabelStyle: LabelStyle {
    public func makeBody(configuration: Configuration) -> some View {
    HStack {
        configuration.title
        configuration.icon
    }
  }
}

public extension LabelStyle where Self == HStackLabelStyle {
     static var hStack: HStackLabelStyle {
     HStackLabelStyle()
  }
}
