//
//  File.swift
//  
//
//  Created by TechGlock Software Solutions on 11/04/23.
//

import Foundation
import SwiftUI

public protocol SheetEnum: Identifiable {
    associatedtype Body: View

    @ViewBuilder
     func view(coordinator: SheetStack<Self>) -> Body
}

public final class SheetStack<Sheet: SheetEnum>: ObservableObject {
    
    public  init(){
        
    }
    
    @Published var currentSheet: Sheet?
    private var sheetStack: [Sheet] = []

    @MainActor
   public func presentSheet(_ sheet: Sheet) {
        sheetStack.append(sheet)
        currentSheet = sheet
    }

    @MainActor
   public func sheetDismissed() {
        sheetStack.removeFirst()

        if let nextSheet = sheetStack.first {
            currentSheet = nextSheet
        }
    }
}

public struct SheetNavigator<Sheet: SheetEnum>: ViewModifier {
    @StateObject var coordinator: SheetStack<Sheet>

    public func body(content: Content) -> some View {
        content
            .sheet(item: $coordinator.currentSheet, onDismiss: {
                coordinator.sheetDismissed()
            }, content: { sheet in
                sheet.view(coordinator: coordinator)
                    
            })
    }
}
public extension View {
    func sheetNavigator<Sheet: SheetEnum>(navigator: SheetStack<Sheet>) -> some View {
        modifier(SheetNavigator(coordinator: navigator))
    }
}
