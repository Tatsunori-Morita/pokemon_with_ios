//
//  IRepository.swift
//  pokemon_with_ios
//
//  Created by Tatsunori on 2023/05/19.
//

protocol IRepository {
    func add(entity: PokemonEntity)
    func getEntityBy(no: PokemonEntity.IdValue) -> PokemonEntity?
    func select() -> [PokemonEntity]
    func delete(entity: PokemonEntity)
}
