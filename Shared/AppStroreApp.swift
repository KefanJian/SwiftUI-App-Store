//
//  AppStroreApp.swift
//  Shared
//
//  Created by Kefan Jian on 2021/7/22.
//

import SwiftUI

@main
struct AppStroreApp: App {
    
    @StateObject private var todayViewModel = TodayViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(todayViewModel)
        }
    }
}
