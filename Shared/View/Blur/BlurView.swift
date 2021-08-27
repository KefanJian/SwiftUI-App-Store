//
//  BlurView.swift
//  AppStrore
//
//  Created by Kefan Jian on 2021/7/22.
//

import SwiftUI

struct BlurView: View {
    var body: some View {
        #if os(iOS)
        iOSBlur()
        #elseif os(macOS)
        MacOSBlur()
        #endif
    }
}

struct BlurView_Previews: PreviewProvider {
    static var previews: some View {
        BlurView()
    }
}
