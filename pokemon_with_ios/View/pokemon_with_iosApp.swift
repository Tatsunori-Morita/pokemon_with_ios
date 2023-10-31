//
//  pokemon_with_iosApp.swift
//  pokemon_with_ios
//
//  Created by Tatsunori on 2022/07/02.
//

import SwiftUI

@main
struct pokemon_with_iosApp: App {
    var body: some Scene {
        WindowGroup {
            MainContentView(viewModel: MainContentViewModel())
        }
    }
}
