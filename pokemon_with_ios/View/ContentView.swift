//
//  ContentView.swift
//  pokemon_with_ios
//
//  Created by Tatsunori on 2022/07/02.
//

import SwiftUI

struct ContentView: View {
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
            ContentView()
                .environment(\.locale, .init(identifier: "en"))
            ContentView()
                .environment(\.locale, .init(identifier: "ja"))
        }
    }
}
