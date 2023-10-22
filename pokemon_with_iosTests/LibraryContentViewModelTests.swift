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
    static let viewModel = LibraryContentViewModel(viewConfig: viewConfig, pokemonEntities: entities)
    
    override class func spec() {
        describe("LibraryContentViewModelのテスト") {
            context("インスタンス生成時のセル数が正しいことを確認するテスト") {
                it("セルの件数が正しい") {
                    expect(viewModel.cellViewModels.count).to(equal(20))
                }
            }
            
            context("追加読み込み時のセル数が正しいことを確認するテスト") {
                it("セルの件数が正しい") {
                    viewModel.loadMore()
                    expect(viewModel.cellViewModels.count).to(equal(30))
                }
            }
            
            context("IDからポケモンの取得を確認するテスト") {
                it("すでに発見済みのポケモンの場合") {
                    let id = try! PokemonEntity.IdValue(id: 25)
                    guard let pokemon = viewModel.getPokemonEntity(idValue: id) else {
                        fail("必ずnilにはならない")
                        return
                    }
                    expect(pokemon.id).to(equal(25))
                }
                
                it("未発見のポケモンの場合") {
                    let id = try! PokemonEntity.IdValue(id: 999999)
                    let pokemon = viewModel.getPokemonEntity(idValue: id)
                    expect(pokemon).to(beNil())
                }
            }
        }
    }
}
