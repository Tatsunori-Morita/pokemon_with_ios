//
//  ModalPopUpView.swift
//  pokemon_with_ios
//
//  Created by Tatsunori on 2023/06/28.
//

import SwiftUI

struct ModalPopUpView: View {
    @Environment(\.viewController)
    private var _viewControllerHolder: UIViewController?
    @State
    private var _degrees = 0.0
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
                self._viewControllerHolder?.dismiss(animated: true, completion: nil)
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
            .degrees(_degrees),
            axis: (x: 0, y: 1, z: 0)
        )
        .onAppear {
            withAnimation {
                _degrees += 360
            }
        }
    }
}

struct ModalPopUpView_Previews: PreviewProvider {
    @Environment(\.colorScheme)
    private static var _colorScheme
    private static let _domainConfig = DomainConfig()
    private static let _entity = PokemonEntityPreviewFactory.createPreviewEntity()
    private static let _selectedColorSchemeMode = (_colorScheme == .dark) ? ColorSchemeMode.dark : ColorSchemeMode.light
    
    static var previews: some View {
        ModalPopUpView(
            viewConfig: ViewConfig(
                locale: Locale(identifier: _domainConfig.japaneseInJapan),
                colorSchemeMode: _selectedColorSchemeMode,
                domainConfig: _domainConfig),
            entity: _entity
        )
        .environment(\.locale, .init(identifier: _domainConfig.japanese))
        .previewDisplayName("Japanese")
        
        ModalPopUpView(
            viewConfig: ViewConfig(
                locale: Locale(identifier: _domainConfig.englishInJapane),
                colorSchemeMode: _selectedColorSchemeMode,
                domainConfig: _domainConfig),
            entity: _entity
        )
        .environment(\.locale, .init(identifier: _domainConfig.english))
        .previewDisplayName("English")
        
        ModalPopUpView(
            viewConfig: ViewConfig(
                locale: Locale(identifier: _domainConfig.japaneseInJapan),
                colorSchemeMode: _selectedColorSchemeMode,
                domainConfig: _domainConfig),
            entity: _entity
        )
        .environment(\.locale, .init(identifier: _domainConfig.japanese))
        .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
        .previewDisplayName("iPhone SE")
    }
}
