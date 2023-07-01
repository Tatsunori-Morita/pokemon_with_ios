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
                    Label("Library", systemImage: "book")
                        .environment(\.symbolVariants, .none)
                }
            
            SettingContentView()
                .tabItem {
                    Label("Setting", systemImage: "gear")
                }
        }
        .accentColor(.accent)
    }
}

struct MainContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView()
            .environment(\.locale, .init(identifier: "en"))
        MainContentView()
            .environment(\.locale, .init(identifier: "ja"))
    }
}
