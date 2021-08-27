//
//  Transition.swift
//  AppStrore
//
//  Created by Kefan Jian on 2021/8/13.
//

import SwiftUI

extension AnyTransition {
    
    static var model: AnyTransition {
        AnyTransition.modifier(active: ModelModifier(percentage: 0.0), identity: ModelModifier(percentage: 1.0))
    }

}

struct ModelModifier: AnimatableModifier {
    
    var percentage: CGFloat
    
    var animatableData: CGFloat {
        get { percentage }
        set { percentage = newValue }
    }
    
    func body(content: Content) -> some View {
        content
            .environment(\.modelPercentage, percentage)
    }
}


extension EnvironmentValues {
    var modelPercentage: CGFloat {
        get { return self[modelPercentageKey.self] }
        set { self[modelPercentageKey.self] = newValue }
    }
}

public struct modelPercentageKey: EnvironmentKey {
    public static let defaultValue: CGFloat = 0
}
