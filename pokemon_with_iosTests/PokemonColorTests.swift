//
//  PokemonColorTests.swift
//  pokemon_with_iosTests
//
//  Created by Tatsunori on 2023/07/28.
//

import Quick
import Nimble

final class PokemonColorTests: QuickSpec {
    override class func spec() {
        describe("PokemonColorのテスト") {
            context("ColorTypeの取得") {
                it("正常値での取得") {
                    let jpName = "でんき"
                    let enName = "Electric"
                    let value = try! PokemonColor.shared.getColorType(name: jpName)
                    expect(value.jaName).to(equal(jpName))
                    expect(value.enName).to(equal(enName))
                }
                
                it("異常値での取得") {
                    expect {
                        try PokemonColor.shared.getColorType(name: "")
                    }
                    .to(throwError())
                }
            }
        }
    }
}
