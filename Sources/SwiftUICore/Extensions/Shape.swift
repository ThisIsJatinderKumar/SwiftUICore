//
//  Shape.swift
//  mvvm base
//
//  Created by TechGlock Software Solutions on 21/03/23.
//

import Foundation
import SwiftUI
extension Shape {
func fill<Fill: ShapeStyle, Stroke: ShapeStyle>(_ fillStyle: Fill, strokeBorder strokeStyle: Stroke, lineWidth: Double = 1) -> some View {
    self
        .stroke(strokeStyle, lineWidth: lineWidth)
        .background(self.fill(fillStyle))
    }
    
  
}
