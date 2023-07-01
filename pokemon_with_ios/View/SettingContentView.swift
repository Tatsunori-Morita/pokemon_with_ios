//
//  SettingContentView.swift
//  pokemon_with_ios
//
//  Created by Tatsunori on 2022/07/02.
//

import SwiftUI

struct SettingContentView: View {
    private let models = RealmRepository().select()
    private let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    
    init() {
        UINavigationBar.appearance().titleTextAttributes = [
            .font : UIFont(name: "Hiragino Kaku Gothic ProN", size: 16)!
        ]
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .font : UIFont(name: "Hiragino Kaku Gothic ProN", size: 32)!
        ]
    }

    var body: some View {
        NavigationView {
            List {
                HStack {
                    Text("Library")
                        .font(.custom("Hiragino Kaku Gothic ProN", size: 16))
                        .foregroundColor(Color.text)
                    Spacer()
                    Text("\(models.count) / \(1010)")
                        .font(.custom("SF Pro Text", size: 16))
                        .foregroundColor(Color.text)
                }
                .listRowBackground(Color.layout)
                HStack {
                    Text("Version")
                        .font(.custom("Hiragino Kaku Gothic ProN", size: 16))
                        .foregroundColor(Color.text)
                    Spacer()
                    Text(version)
                        .font(.custom("SF Pro Text", size: 16))
                        .foregroundColor(Color.text)
                }
                .listRowBackground(Color.layout)
                HStack {
                    Text("Created by")
                        .font(.custom("SF Pro Text", size: 16))
                        .foregroundColor(Color.text)
                    Spacer()
                    Text("Tatsunori")
                        .font(.custom("SF Pro Text", size: 16))
                        .foregroundColor(Color.text)
                }
                .listRowBackground(Color.layout)
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
