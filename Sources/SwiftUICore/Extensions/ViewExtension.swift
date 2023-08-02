

import Foundation
import SwiftUI

public extension View {
    
    
    func validate<Rule>(_ value: Binding<Rule.Value>, rule: Rule, validation: @escaping (Rule.ValidationResult) -> Void) -> some View where Rule: ValidationRule {
        
        self
            .onChange(of: value.wrappedValue) { value in
                let result = rule.validate(value)
                validation(result)
            }
            .onSubmit {
                let result = rule.validate(value.wrappedValue)
                if case .success(let validated) = result {
                    if value.wrappedValue != validated {
                        value.wrappedValue = validated // update value
                    }
                }
            }
    }
    
     func border(_ color: Color, width: CGFloat, cornerRadius: CGFloat) -> some View {
        overlay(RoundedRectangle(cornerRadius: cornerRadius).stroke(color, lineWidth: width))
    }
    
   
     func clearListBackground() -> some View {
        modifier(ClearListBackgroundModifier())
    }
    
     func backgroundCapsuleFill(color:Color)->some View{
        self.background(
                Capsule()
                    .strokeBorder(color,lineWidth: 0)
                    .background(color)
                    .clipped()
            ).clipShape(Capsule())
    }
    
    func backgroundCapsuleLinearGradient(color:Color)->some View{
       self.background(
               Capsule()
                   .strokeBorder(color,lineWidth: 0)
                   .background{
                       LinearGradient(gradient: Gradient(colors: [color.opacity(0.6), color.opacity(0.8), color]), startPoint: .leading, endPoint: .trailing)
                   }.clipped()
           ).clipShape(Capsule())
   }
    
     func backgroundRoundedFill(color:Color,radius:CGFloat)->some View{
        self.background(RoundedRectangle(cornerRadius: radius).fill(color))
    }
    
     func backgroundLinearGradient(color:Color)->some View{
        self.background{
            LinearGradient(gradient: Gradient(colors: [color.opacity(0.6), color.opacity(0.8), color]), startPoint: .leading, endPoint: .trailing)
        }
    }
    
    func linearGradient(color:Color)->some View{
        LinearGradient(gradient: Gradient(colors: [color.opacity(0.6), color.opacity(0.8), color]), startPoint: .leading, endPoint: .trailing)
    }
    
     func backgroundCapsuleStroke(color:Color,stroke:Color,lineWidth:Double = 0.8)->some View{
        self.background(
                Capsule()
                    .strokeBorder(stroke,lineWidth: lineWidth)
                    .background(color)
                    .clipped()
            ).clipShape(Capsule())
    }
    
     func applyAnimation<V>(value: V) -> some View where V : Equatable{
        // self.animation(.spring(response: 1.0), value: value)
         self.animation(.spring(), value: value)
    }
    
    var springAnimation:Animation{
        .spring()
    }
    
    @ViewBuilder
     func addShadow(color:Color)->some View{
        shadow(color: color.opacity(0.3), radius: 5, x: 0, y: 3)
            .shadow(color: color.opacity(0.2), radius: 2, x: 0, y: 1)
    }
    
    func bottomSheet<Content: View>(
        isPresented: Binding<Bool>,
        height: CGFloat,
        topBarHeight: CGFloat = 30,
        topBarCornerRadius: CGFloat? = nil,
        shadowColor: Color = Color.black,
        backgroundColor: Color = Color(.systemBackground),
        contentBackgroundColor: Color = Color(.systemBackground),
        topBarBackgroundColor: Color = Color(.systemBackground),
        showTopIndicator: Bool = true,
        onDismiss: (() -> Void)? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        ZStack {
            self
            BottomSheet(isPresented: isPresented,
                        height: height,
                        topBarHeight: topBarHeight,
                        topBarCornerRadius: topBarCornerRadius,
                        backgroundColor: backgroundColor,
                        shadowColor: shadowColor,
                        topBarBackgroundColor: topBarBackgroundColor,
                        contentBackgroundColor: contentBackgroundColor,
                        showTopIndicator: showTopIndicator,
                        onDismiss: onDismiss,
                        content: content)
        }
    }
    
    func bottomSheet<Item: Identifiable, Content: View>(
        item: Binding<Item?>,
        height: CGFloat,
        topBarHeight: CGFloat = 30,
        topBarCornerRadius: CGFloat? = nil,
        shadowColor: Color = Color.black,
        backgroundColor: Color = Color(.systemBackground),
        contentBackgroundColor: Color = Color(.systemBackground),
        topBarBackgroundColor: Color = Color(.systemBackground),
        showTopIndicator: Bool = true,
        onDismiss: (() -> Void)? = nil,
        @ViewBuilder content: @escaping (Item) -> Content
    ) -> some View {
        let isPresented = Binding {
            item.wrappedValue != nil
        } set: { value in
            if !value {
                item.wrappedValue = nil
            }
        }
        
        return bottomSheet(
            isPresented: isPresented,
            height: height,
            topBarHeight: topBarHeight,
            topBarCornerRadius: topBarCornerRadius,
            shadowColor: shadowColor,
            backgroundColor: backgroundColor,
            contentBackgroundColor: contentBackgroundColor,
            topBarBackgroundColor: topBarBackgroundColor,
            showTopIndicator: showTopIndicator,
            onDismiss: onDismiss
        ) {
            if let unwrappedItem = item.wrappedValue {
              content(unwrappedItem).disabled(isPresented.wrappedValue)
            } else {
                EmptyView()
            }
        }
    }
    
    func sync<T: Equatable>(_ binding: Binding<T>, with focusState: FocusState<T>) -> some View {
            self
                .onChange(of: binding.wrappedValue) {
                    focusState.wrappedValue = $0
                }
                .onChange(of: focusState.wrappedValue) {
                    binding.wrappedValue = $0
                }
        }
    
    @inlinable func documentPicker(
       isPresented: Binding<Bool>,
       documentTypes: [String] = [],
       onCancel: @escaping () -> () = { },
       onDocumentsPicked: @escaping (_: [URL]) -> () = { _ in }
     ) -> some View {
       Group {
         self
         DocumentPicker(isPresented: isPresented, documentTypes: documentTypes, onCancel: onCancel, onDocumentsPicked: onDocumentsPicked)
       }
     }
}
