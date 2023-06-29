//
//  ModalPopUpView.swift
//  pokemon_with_ios
//
//  Created by Tatsunori on 2023/06/28.
//

import SwiftUI

struct ViewControllerHolder {
    weak var value: UIViewController?
}

struct ViewControllerKey: EnvironmentKey {
    static var defaultValue: ViewControllerHolder {
        let scenes = UIApplication.shared.connectedScenes
        let windowScenes = scenes.first as? UIWindowScene
        return ViewControllerHolder(value: windowScenes?.keyWindow?.rootViewController)
    }
}

extension EnvironmentValues {
    var viewController: UIViewController? {
        get { return self[ViewControllerKey.self].value }
        set { self[ViewControllerKey.self].value = newValue }
    }
}

extension UIViewController {
    func present<Content: View>(style: UIModalPresentationStyle = .automatic, transitionStyle: UIModalTransitionStyle = .coverVertical, @ViewBuilder builder: () -> Content) {
        let toPresent = UIHostingController(rootView: AnyView(EmptyView()))
        toPresent.modalPresentationStyle = style
        toPresent.modalTransitionStyle = transitionStyle
        toPresent.view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        toPresent.rootView = AnyView(
            builder()
                .environment(\.viewController, toPresent)
        )
        self.present(toPresent, animated: true, completion: nil)
    }
}

struct ModalPopUpView: View {
    @Environment(\.viewController) private var viewControllerHolder: UIViewController?

    private let entity: PokemonEntity

    init(entity: PokemonEntity) {
        self.entity = entity
    }

    var body: some View {
        VStack(alignment: .center) {
            WidgetContentView(viewModel: WidgetContentViewModel(pokemonEntity: entity, isApp: true))
            Button(action: {
                self.viewControllerHolder?.dismiss(animated: true, completion: nil)
            }) {
                Text("閉じる")
                    .font(.custom("Hiragino Kaku Gothic ProN", size: 16))
                    .foregroundColor(Color.text)
            }
            .padding(.bottom, 16)
        }
        .background(Color.layout2)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .frame(width: UIScreen.main.bounds.size.width - 80, height: UIScreen.main.bounds.size.height * 0.5)
        .shadow(radius: 3)
    }
}

struct ModalPopUpView_Previews: PreviewProvider {
    static let dto = PokemonEntityDTO(
        pokemon: LocalDataManager.shared.load(Pokemon.identifier),
        pokemonSpecies: LocalDataManager.shared.load(PokemonSpecies.identifier),
        pokemonTypes: LocalDataManager.shared.load(PokemonType.identifier))

    static var previews: some View {
        ModalPopUpView(entity: dto.createEntity())
    }
}
