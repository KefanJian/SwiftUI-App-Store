//
//  CardDetail.swift
//  AppStrore
//
//  Created by Kefan Jian on 2021/8/11.
//

import SwiftUI

struct FullPage<Content>: View where Content: View {
    
    @Environment(\.modelPercentage) var modelPercentage
    
    let content: Content
    @Binding var scale: CGFloat
    @State private var scrolledToTop: Bool = false
    @Binding var showed: Bool
    let close: () -> ()

    var body: some View {
            
        return
            
            ZStack {
            
                content
                    .opacity(scrolledToTop ? 0 : 1)
                    .onPreferenceChange(OffsetPreferenceKey.self, perform: { value in
                        if !showed {
                            return
                        }
                        let trigger: CGFloat = 0.8
                        scale = 1 - min(max(value, 0), 100) / 100 * trigger
                        scrolledToTop = value > 0
                        if scale <= trigger {
                            close()
                        }
                    })
                    .zIndex(0)

                if scrolledToTop {
                        content
                            .scaleEffect(scale)
                            .disabled(true)
                            .zIndex(1)
                }

            }
            .environment(\.presentingScale, scale)
            .shadow(color: .black.opacity(0.5), radius: 20, x: 0, y: 10)
            .clipped()
            .background(BlurView())
            .edgesIgnoringSafeArea(.all)
            .disabled(!showed)

    }
    
    init(showed: Binding<Bool>, scale: Binding<CGFloat>, close: @escaping () -> (), @ViewBuilder content: () -> Content) {
        self.content = content()
        self._showed = showed
        self._scale = scale
        self.close = close
    }
}

struct CardDetail_Previews: PreviewProvider {
    
    @Namespace static var namespace
    
    static var previews: some View {
        FullPage(showed: .constant(true), scale: .constant(1), close: {}) {
            CardDetail(showed: .constant(true), model: TodayViewModel().cards[0], namesapce: namespace)
                .ignoresSafeArea()
        }
    }
}
