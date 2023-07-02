//
//  ModalPopUpView.swift
//  pokemon_with_ios
//
//  Created by Tatsunori on 2023/06/28.
//

import SwiftUI

struct ModalPopUpView: View {
    @Environment(\.viewController) private var viewControllerHolder: UIViewController?

    private let _configuration: Configuration
    private let _entity: PokemonEntity

    init(configuration: Configuration, entity: PokemonEntity) {
        _configuration = configuration
        _entity = entity
    }

    var body: some View {
        VStack(alignment: .center) {
            PokemonContentView(viewModel: PokemonContentViewModel(
                configuration: _configuration, pokemonEntity: _entity, isApp: true))
            Button(action: {
                self.viewControllerHolder?.dismiss(animated: true, completion: nil)
            }) {
                Text("Close")
                    .font(.custom("Hiragino Kaku Gothic ProN", size: 16))
                    .foregroundColor(Color.text)
            }
            .padding(.bottom, 32)
        }
        .background(Color.layout)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .frame(width: UIScreen.main.bounds.size.width - 80, height: UIScreen.main.bounds.size.height * 0.55)
        .shadow(radius: 3)
    }
}

struct ModalPopUpView_Previews: PreviewProvider {
    @Environment(\.colorScheme)
    private static var colorScheme
    
    static let dto = PokemonEntityDTO(
        pokemon: LocalDataManager.shared.load(Pokemon.identifier),
        pokemonSpecies: LocalDataManager.shared.load(PokemonSpecies.identifier),
        pokemonTypes: LocalDataManager.shared.load(PokemonType.identifier))

    static var previews: some View {
        ModalPopUpView(configuration: Configuration(locale: Locale(identifier: "ja_jp"), isDarkMode: colorScheme == .dark), entity: dto.createEntity())
            .environment(\.locale, .init(identifier: "ja"))
        
        ModalPopUpView(configuration: Configuration(locale: Locale(identifier: "en_jp"), isDarkMode: colorScheme == .dark), entity: dto.createEntity())
            .environment(\.locale, .init(identifier: "en"))
    }
}
