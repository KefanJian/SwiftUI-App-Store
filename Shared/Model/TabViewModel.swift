//
//  TabViewModel.swift
//  AppStrore
//
//  Created by Kefan Jian on 2021/7/23.
//

import SwiftUI

enum Tab: String {
    case today = "Today"
    case app = "App"
    case search = "Search"
}

final class TabViewModel: ObservableObject {
    
    @Published var selection: Tab
    @Published var hidden: Bool
    
    init() {
        selection = .today
        hidden = false
    }
    
}
