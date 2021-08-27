//
//  Tabbar.swift
//  AppStrore
//
//  Created by Kefan Jian on 2021/7/22.
//

import SwiftUI

struct Tabbar: View {
    
    @EnvironmentObject private var tabViewModel: TabViewModel
    
    var body: some View {
        
        HStack {
            Button(action: {
                tabViewModel.selection = .today
            }) {
                VStack(spacing: 4) {
                    Image(systemName: "calendar")
                        .resizable()
                        .frame(width: 24, height: 24)
                    Text(Tab.today.rawValue)
                }
            }
            .buttonStyle(PlainButtonStyle())
            
            Spacer()
            
            Button(action: {
                tabViewModel.selection = .app
            }) {
                VStack(spacing: 4) {
                    Image(systemName: "folder.circle")
                        .resizable()
                        .frame(width: 24, height: 24)
                    Text(Tab.app.rawValue)
                }
            }
            .buttonStyle(PlainButtonStyle())

            Spacer()
            
            Button(action: {
                tabViewModel.selection = .search
            }) {
                VStack(spacing: 4) {
                    Image(systemName: "calendar")
                        .resizable()
                        .frame(width: 24, height: 24)
                    Text(Tab.search.rawValue)
                }
            }
            .buttonStyle(PlainButtonStyle())
            
        }
        .font(.caption)
        .foregroundColor(.blue)
        .padding(.top, 8)
        .padding(.bottom, 4)
        .padding(.leading, 16)
        .padding(.trailing, 16)
        .background(BlurView().ignoresSafeArea())
        
    }
    
}

struct Tabbar_Previews: PreviewProvider {
    static var previews: some View {
        Tabbar()
            .environmentObject(TabViewModel())
            .previewLayout(.sizeThatFits)
    }
}



