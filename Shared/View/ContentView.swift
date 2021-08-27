//
//  ContentView.swift
//  Shared
//
//  Created by Kefan Jian on 2021/7/22.
//

import SwiftUI

struct ContentView: View {
    
    
    @StateObject private var tabViewModel = TabViewModel()
    
    @State private var tabbarSize: CGSize = .zero
    @State private var tabarHidden: Bool = false
    
    init() {
        // hide original tabbar
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        NavigationView {
            
            TabView(selection: $tabViewModel.selection) {
                
                Today()
                    .environment(\.tabBarSize, tabbarSize)
                    .tag(Tab.today)
                    .navigationBarHidden(true)
                    .environmentObject(tabViewModel)
                
                Text(Tab.app.rawValue)
                    .tag(Tab.app)
                
                Text(Tab.search.rawValue)
                    .tag(Tab.search)
            }

        }
        .overlay(
            ChildSizeReader(size: $tabbarSize, content: {
                Tabbar()
                    .environmentObject(tabViewModel)
                    .offset(x: 0, y: tabViewModel.hidden ? tabbarSize.height : 0)
            })
            , alignment: .bottom
        )
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct TabBarSizeKey: EnvironmentKey {
    static var defaultValue: CGSize = .zero
}

extension EnvironmentValues {
    var tabBarSize: CGSize {
        get { self[TabBarSizeKey.self] }
        set { self[TabBarSizeKey.self] = newValue }
    }
}

struct TabBarHiddenKey: EnvironmentKey {
    static var defaultValue: Bool = false
}
