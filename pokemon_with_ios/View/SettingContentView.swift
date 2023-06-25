//
//  SettingContentView.swift
//  pokemon_with_ios
//
//  Created by Tatsunori on 2022/07/02.
//

import SwiftUI

struct SettingContentView: View {
    private let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String

    var body: some View {
        let _ = RealmRepository()
        NavigationView {
            List {
                HStack {
                    Text("Version")
                        .foregroundColor(Color.text)
                    Spacer()
                    Text(version)
                        .foregroundColor(Color.text)
                }
            }
            .navigationTitle("Setting")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SettingContentView()
                .environment(\.locale, .init(identifier: "en"))
            SettingContentView()
                .environment(\.locale, .init(identifier: "ja"))
        }
    }
}
