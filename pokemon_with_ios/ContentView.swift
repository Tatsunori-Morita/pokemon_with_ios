//
//  ContentView.swift
//  pokemon_with_ios
//
//  Created by Tatsunori on 2022/07/02.
//

import SwiftUI

struct ContentView: View {
    @State private var isDarkMode = true
    @State private var selectedUpdatePeriod = UpdatePeriod.hour

    private enum UpdatePeriod {
        case hour
        case twelve
        case twentyFour
    }

    private let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String

    var body: some View {
        NavigationView {
            List {
                HStack {
                    Text("バージョン")
                    Spacer()
                    Text(version)
                }
            }
            .navigationTitle("Setting")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
