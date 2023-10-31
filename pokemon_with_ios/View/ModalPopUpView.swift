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
    
    private let _systemConfig: SystemConfig
    private let _entity: PokemonEntity

    init(systemConfig: SystemConfig, entity: PokemonEntity) {
        _systemConfig = systemConfig
        _entity = entity
    }

    var body: some View {
        let viewModel = PokemonContentViewModel(
            systemConfig: _systemConfig, pokemonEntity: _entity, isApp: true, isNew: false)
        
        VStack(alignment: .center) {
            PokemonContentView(viewModel: viewModel)
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
        .environment(\.locale, .init(identifier: _systemConfig.getLanguage))
        .environment(\.colorScheme, _systemConfig.getColorScheme)
    }
}

struct ModalPopUpView_Previews: PreviewProvider {
    private static let _entity = PokemonEntityPreviewFactory.createPreviewEntity()
    
    static var previews: some View {
        let jaConfig = SystemConfig(languageMode: .ja, colorSchemeMode: .light)
        let enConfig = SystemConfig(languageMode: .en, colorSchemeMode: .dark)
        
        ModalPopUpView(
            systemConfig: jaConfig,
            entity: _entity)
        .previewDisplayName("Japanese")
        
        ModalPopUpView(
            systemConfig: enConfig,
            entity: _entity)
        .previewDisplayName("English")
        
        ModalPopUpView(
            systemConfig: jaConfig,
            entity: _entity)
        .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
        .previewDisplayName("iPhone SE")
    }
}
