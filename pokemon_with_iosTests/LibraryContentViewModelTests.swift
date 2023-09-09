//
//  LibraryContentViewModelTests.swift
//  pokemon_with_iosTests
//
//  Created by Tatsunori on 2023/08/18.
//

import Quick
import Nimble
import Foundation

final class LibraryContentViewModelTests: QuickSpec {
    static let viewConfig = ViewConfig(
        locale: Locale(identifier: "ja_jp"),
        colorSchemeMode: .dark,
        domainConfig: DomainConfig())
    static let entities = PokemonEntityPreviewFactory.createPreviewEntities()
    
    override class func spec() {
        describe("LibraryContentViewModelのテスト") {
            context("インスタンス生成時のセル数が正しいことを確認するテスト") {
                it("セルの件数が正しい") {
                    let viewModel = LibraryContentViewModel(viewConfig: viewConfig, pokemonEntities: entities)
                    expect(viewModel.cellViewModels.count).to(equal(20))
                }
            }
            
            context("追加読み込み時のセル数が正しいことを確認するテスト") {
                it("セルの件数が正しい") {
                    let viewModel = LibraryContentViewModel(viewConfig: viewConfig, pokemonEntities: entities)
                    viewModel.loadMore()
                    expect(viewModel.cellViewModels.count).to(equal(30))
                }
            }
        }
    }
}
