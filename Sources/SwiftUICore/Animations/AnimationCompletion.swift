
import SwiftUI

/// An animatable modifier that is used for observing animations for a given animatable value.
public struct AnimationCompletionObserverModifier<Value>: AnimatableModifier where Value: VectorArithmetic {
    
    /// While animating, SwiftUI changes the old input value to the new target value using this property. This value is set to the old value until the animation completes.
    public var animatableData: Value {
        didSet {
            notifyCompletionIfFinished()
        }
    }
    
    /// The target value for which we're observing. This value is directly set once the animation starts. During animation, `animatableData` will hold the oldValue and is only updated to the target value once the animation completes.
    private var targetValue: Value
    
    /// The completion callback which is called once the animation completes.
    private var completion: () -> Void
    private let onChange: ((Value) -> Void)?
    init(observedValue: Value, onChange: ((Value) -> Void)?,completion: @escaping () -> Void) {
        self.completion = completion
        self.onChange = onChange
        self.animatableData = observedValue
        targetValue = observedValue
    }
    
    /// Verifies whether the current animation is finished and calls the completion callback if true.
    private func notifyCompletionIfFinished() {
        guard animatableData == targetValue else { return }
        
        /// Dispatching is needed to take the next runloop for the completion callback.
        /// This prevents errors like "Modifying state during view update, this will cause undefined behavior."
        DispatchQueue.main.async {
            self.completion()
        }
    }
    
    public func body(content: Content) -> some View {
        /// We're not really modifying the view so we can directly return the original input value.
        return content
    }
}

public extension View {
    func onAnimationCompleted<Value: VectorArithmetic>(for value: Value,onChange: @escaping (_ value:Value) -> Void,
                                                       completion: @escaping () -> Void) -> ModifiedContent<Self, AnimationCompletionObserverModifier<Value>> {
        modifier(AnimationCompletionObserverModifier(observedValue: value, onChange: onChange, completion: completion))
    }
}
