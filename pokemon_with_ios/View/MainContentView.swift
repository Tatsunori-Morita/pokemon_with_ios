//
//  MainContentView.swift
//  pokemon_with_ios
//
//  Created by Tatsunori on 2023/06/24.
//

import SwiftUI

struct MainContentView: View {
    var body: some View {
        TabView {
            LibraryContentView()
                .tabItem {
                    Label("図鑑", systemImage: "book")
                }
            
            SettingContentView()
                .tabItem {
                    Label("設定", systemImage: "gear")
                }
        }
    }
}

struct MainContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView()
    }
}
