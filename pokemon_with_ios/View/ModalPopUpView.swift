//
//  ModalPopUpView.swift
//  pokemon_with_ios
//
//  Created by Tatsunori on 2023/06/28.
//

import SwiftUI

struct ModalPopUpView: View {
    @Environment(\.viewController)
    private var viewControllerHolder: UIViewController?
    @State
    private var degrees = 0.0
    
    private let systemConfig: SystemConfig
    private let entity: PokemonEntity

    init(systemConfig: SystemConfig, entity: PokemonEntity) {
        self.systemConfig = systemConfig
        self.entity = entity
    }

    var body: some View {
        let viewModel = PokemonContentViewModel(
            systemConfig: systemConfig, pokemonEntity: entity, isNew: false)
        
        VStack(alignment: .center) {
            PokemonContentView(viewModel: viewModel)
            Button(action: {
                self.viewControllerHolder?.dismiss(animated: true, completion: nil)
            }) {
                Image(systemName: "xmark.circle")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color.text)
            }
            .padding(24)
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
        .environment(\.locale, .init(identifier: systemConfig.getLanguage))
        .environment(\.colorScheme, systemConfig.getColorScheme)
    }
}

struct ModalPopUpView_Previews: PreviewProvider {
    private static let entity = PokemonEntityPreviewFactory.createPreviewEntity()
    
    static var previews: some View {
        let jaConfig = SystemConfig(languageMode: .ja, colorSchemeMode: .light)
        let enConfig = SystemConfig(languageMode: .en, colorSchemeMode: .dark)
        
        ModalPopUpView(
            systemConfig: jaConfig,
            entity: entity)
        .previewDisplayName("Japanese")
        
        ModalPopUpView(
            systemConfig: enConfig,
            entity: entity)
        .previewDisplayName("English")
        
        ModalPopUpView(
            systemConfig: jaConfig,
            entity: entity)
        .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
        .previewDisplayName("iPhone SE")
    }
}
