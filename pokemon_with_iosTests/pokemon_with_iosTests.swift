//
//  pokemon_with_iosTests.swift
//  pokemon_with_iosTests
//
//  Created by Tatsunori on 2022/07/02.
//

import XCTest
@testable import pokemon_with_ios

class pokemon_with_iosTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let e = expectation(description: "PokemonApiService")
        let viewModel = PokemonApiService(number: 1)
//        viewModel.fetchPokemonSpecies { species in
//            guard let generas = species.genera else { return }
//            let genera = generas.filter { $0.language?.name == "ja"}.first
//            print(genera?.genus)
//
//            guard let names = species.names else { return }
//            let name = names.filter { $0.language?.name == "ja" }.first
//            print(name?.name)
//
//            guard let flavorTextEntries = species.flavorTextEntries else { return }
//            let flavorTextEntry = flavorTextEntries.filter { $0.language?.name == "ja" }.last
//            print(flavorTextEntry?.flavorText)
//
//            e.fulfill()
//        }

//        viewModel.fetch { pokemon in
//            guard let typeElements = pokemon.types else { return }
//
//            typeElements.forEach { typeElement in
//                if let url = typeElement.type?.url {
//                    viewModel.fetchPokemonType(url: url) { type in
//                        guard let names = type.names else { return }
//                        let name = names.filter { $0.language?.name == "ja" }.first
//                        print(name)
//                    }
//                }
//            }
//            e.fulfill()
//        }
//
//        waitForExpectations(timeout: 5.0, handler: nil)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
