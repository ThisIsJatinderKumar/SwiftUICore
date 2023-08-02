//
//  List.swift
//  promanageconstruction
//
//  Created by TechGlock Software Solutions on 03/04/23.
//

import Foundation
import SwiftUI
struct ClearListBackgroundModifier: ViewModifier {

    @ViewBuilder
    func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            content.scrollContentBackground(.hidden)
        } else {
            content
        }
    }
}
