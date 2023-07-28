//
//  PokemonEntityValueTests.swift
//  pokemon_with_iosTests
//
//  Created by Tatsunori on 2023/07/10.
//

import Quick
import Nimble

class PokemonEntityValueTests: QuickSpec {
    override class func spec() {
        let language = try! PokemonEntity.LanguageValue(language: "ja")
        let testStr = "test"
        
        describe("ドメインバリューのテスト") {
            context("IdValueのインスタンス生成") {
                it("正常値でのインスタンス生成") {
                    let value = try! PokemonEntity.IdValue(id: 1)
                    expect(value.id).to(equal(1))
                }
                
                it("異常値でのインスタンス生成") {
                    expect { try PokemonEntity.IdValue(id: 0)}.to(throwError())
                }
            }
            
            context("NameValueのインスタンス生成") {
                it("正常値でのインスタンス生成") {
                    let value = try! PokemonEntity.NameValue(name: testStr, language: language)
                    expect(value.name).to(equal(testStr))
                }
                
                it("異常値でのインスタンス生成") {
                    expect { try PokemonEntity.NameValue(name: "", language: language)}.to(throwError())
                }
            }
            
            context("HeightValueのインスタンス生成") {
                it("正常値でのインスタンス生成") {
                    let value = try! PokemonEntity.HeightValue(height: 1)
                    expect(value.height).to(equal(1))
                }
                
                it("異常値でのインスタンス生成") {
                    expect { try PokemonEntity.HeightValue(height: 0)}.to(throwError())
                }
            }
            
            context("WeightValueのインスタンス生成") {
                it("正常値でのインスタンス生成") {
                    let value = try! PokemonEntity.WeightValue(weight: 1)
                    expect(value.weight).to(equal(1))
                }
                
                it("異常値でのインスタンス生成") {
                    expect { try PokemonEntity.WeightValue(weight: 0)}.to(throwError())
                }
            }
            
            context("GenusValueのインスタンス生成") {
                it("正常値でのインスタンス生成") {
                    let value = try! PokemonEntity.GenusValue(genus: testStr, language: language)
                    expect(value.genus).to(equal(testStr))
                }
                
                it("異常値でのインスタンス生成") {
                    expect { try PokemonEntity.GenusValue(genus: "", language: language)}.to(throwError())
                }
            }
            
            context("FlavorTextEntryValueのインスタンス生成") {
                it("正常値でのインスタンス生成") {
                    let value = try! PokemonEntity.FlavorTextEntryValue(flavorTextEntry: testStr, language: language)
                    expect(value.flavorTextEntry).to(equal(testStr))
                }
                
                it("異常値でのインスタンス生成") {
                    expect { try PokemonEntity.FlavorTextEntryValue(flavorTextEntry: "", language: language)}.to(throwError())
                }
            }
            
            context("FrontDefaultValueのインスタンス生成") {
                it("正常値でのインスタンス生成") {
                    let value = try! PokemonEntity.FrontDefaultValue(frontDefault: testStr)
                    expect(value.frontDefault).to(equal(testStr))
                }
                
                it("異常値でのインスタンス生成") {
                    expect { try PokemonEntity.FrontDefaultValue(frontDefault: "")}.to(throwError())
                }
            }
            
            context("PokemonTypeValueのインスタンス生成") {
                it("正常値でのインスタンス生成") {
                    let value = try! PokemonEntity.PokemonTypeValue(name: testStr, language: language)
                    expect(value.name).to(equal(testStr))
                }
                
                it("異常値でのインスタンス生成") {
                    expect { try PokemonEntity.PokemonTypeValue(name: "", language: language)}.to(throwError())
                }
            }
        }
    }
}
