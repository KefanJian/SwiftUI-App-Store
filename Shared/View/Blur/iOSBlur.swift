//
//  iOSBlur.swift
//  AppStrore (iOS)
//
//  Created by Kefan Jian on 2021/7/22.
//

import SwiftUI

struct iOSBlur: View {
    var body: some View {
        VisualEffectView(uiVisualEffect: UIBlurEffect(style: .systemChromeMaterial))
    }
}

struct iOSBlur_Previews: PreviewProvider {
    static var previews: some View {
        iOSBlur()
    }
}


struct VisualEffectView: UIViewRepresentable {
    
    var uiVisualEffect: UIVisualEffect?
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView()
        
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) {
        uiView.effect = uiVisualEffect
    }
    
}
