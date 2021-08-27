//
//  MacOSBlur.swift
//  AppStrore (macOS)
//
//  Created by Kefan Jian on 2021/7/22.
//

import SwiftUI

struct MacOSBlur: View {
    var body: some View {
        VisualEffectView()
    }
}

struct MacOSBlur_Previews: PreviewProvider {
    static var previews: some View {
        MacOSBlur()
    }
}


struct VisualEffectView: NSViewRepresentable {
    
    func updateNSView(_ nsView: NSVisualEffectView, context: Context) {
        
    }
    
    func makeNSView(context: Context) -> NSVisualEffectView {
        return NSVisualEffectView()
    }
    
}
