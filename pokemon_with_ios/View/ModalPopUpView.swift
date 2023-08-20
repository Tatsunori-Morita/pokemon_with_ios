//
//  ModalPopUpView.swift
//  pokemon_with_ios
//
//  Created by Tatsunori on 2023/06/28.
//

import SwiftUI

struct ModalPopUpView: View {
    @Environment(\.viewController) private var viewControllerHolder: UIViewController?
    @State private var degrees = 0.0

    private let _viewConfig: ViewConfig
    private let _entity: PokemonEntity

    init(viewConfig: ViewConfig, entity: PokemonEntity) {
        _viewConfig = viewConfig
        _entity = entity
    }

    var body: some View {
        VStack(alignment: .center) {
            PokemonContentView(viewModel: PokemonContentViewModel(
                viewConfig: _viewConfig, pokemonEntity: _entity, isApp: true, isNew: false))
            Button(action: {
                self.viewControllerHolder?.dismiss(animated: true, completion: nil)
            }) {
                Text("Close")
                    .font(.custom("Hiragino Kaku Gothic ProN", size: 16))
                    .foregroundColor(Color.text)
            }
            .padding(24)
            .padding(.top, 24)
            .padding(.leading, 40)
            .padding(.trailing, 40)
            .padding(.bottom, 24)
        }
        .frame(maxWidth: UIScreen.main.bounds.width * 0.9)
        .background(Color.layout)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(radius: 3)
        .rotation3DEffect(
            .degrees(degrees),
            axis: (x: 0, y: 1, z: 0)
        )
        .onAppear {
            withAnimation {
                degrees += 360
            }
        }
    }
}

struct ModalPopUpView_Previews: PreviewProvider {
    @Environment(\.colorScheme)
    private static var colorScheme
    private static let _domainConfig = DomainConfig()
    
    static var previews: some View {
        ModalPopUpView(
            viewConfig: ViewConfig(
                locale: Locale(identifier: "ja_jp"),
                isDarkMode: colorScheme == .dark,
                domainConfig: _domainConfig),
            entity: PokemonEntityPreviewFactory.createPreviewEntity()
        )
        .environment(\.locale, .init(identifier: "ja"))
        
        ModalPopUpView(
            viewConfig: ViewConfig(
                locale: Locale(identifier: "en_jp"),
                isDarkMode: colorScheme == .dark,
                domainConfig: _domainConfig),
            entity: PokemonEntityPreviewFactory.createPreviewEntity()
        )
        .environment(\.locale, .init(identifier: "en"))
    }
}
