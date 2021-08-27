//
//  AppDetail.swift
//  AppStrore
//
//  Created by Kefan Jian on 2021/7/26.
//

import SwiftUI

struct CardDetail: View {
    
    @Binding var showed: Bool
    
    var model: CardModel
    var namesapce: Namespace.ID
    
    @Environment(\.modelPercentage) var modelPercentage
    @Environment(\.presentingScale) var scale
    
    func yOffset(proxy: GeometryProxy) -> CGFloat {
        let yOffset = proxy.frame(in: .named("scroll")).origin.y
        return yOffset
    }
    
    func cardOffset(proxy: GeometryProxy) -> CGFloat {
        
        let yOffset = yOffset(proxy: proxy)
        
        if yOffset <= 0 {
            return 0
        } else {
            return -yOffset
        }
    }
    
    func scale(proxy: GeometryProxy) -> CGFloat {
        let yOffset = yOffset(proxy: proxy)
        if yOffset > 0 {
            return 1 - min(max(yOffset, 0), 100) / 100 * 0.5
        } else {
            return 1
            
        }
    }
    
    @State private var textSize: CGSize = CGSize(width: 100, height: 50)
    
    var body: some View {
        
        let raduis = 25 * (1 - modelPercentage + (1 - scale) / 0.4)
        
        return ZStack {
            
            ScrollView {
                
                VStack(spacing: 0) {
                    
                    GeometryReader(content: { proxy in
                        
                        let offsetY = yOffset(proxy: proxy)
                        
                        Color.clear
                            .preference(key: OffsetPreferenceKey.self, value: offsetY)
                        
                    }).frame(height: 0)
                    
                    Card(cardModel: model)
                        .matchedGeometryEffect(id: model.id, in: namesapce, isSource: false)
                    
                        .frame(height: 600)
                    
                    ForEach(model.descriptions, id: \.self) { description in
                        Text(description)
                    }
                    .font(.title2)
                    .foregroundColor(.gray)
                    .padding()
                    
                }
                   
            }
            
            .coordinateSpace(name: "scroll")
            .background(Color.white.edgesIgnoringSafeArea(.all))
            
        }
        .cornerRadius(raduis)
        
    }
}

struct AppDetail_Previews: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
        CardDetail(showed: .constant(true), model: TodayViewModel().cards[0], namesapce: namespace)
    }
}


struct ScalePreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 1
    
    static func reduce(value _: inout Value, nextValue: () -> Value) {
        _ = nextValue()
    }
}

struct OffsetPreferenceKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue: CGFloat = 0
    
    static func reduce(value _: inout Value, nextValue: () -> Value) {
        _ = nextValue()
    }
}

extension EnvironmentValues {
    var presentingScale: CGFloat {
        get { return self[PresentingScaleKey.self] }
        set { self[PresentingScaleKey.self] = newValue }
    }
    
}

struct PresentingScaleKey: EnvironmentKey {
    static var defaultValue: CGFloat = 1
}

