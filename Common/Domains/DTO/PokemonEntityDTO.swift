//
//  PokemonEntityDTO.swift
//  pokemon_with_ios
//
//  Created by Tatsunori on 2022/07/12.
//

import Foundation

class PokemonEntityDTO {
    private let _pokemon: Pokemon
    private let _pokemonSpecies: PokemonSpecies
    private let _pokemonTypes: [PokemonType]

    init(pokemon: Pokemon, pokemonSpecies: PokemonSpecies, pokemonTypes: [PokemonType]) {
        _pokemon = pokemon
        _pokemonSpecies = pokemonSpecies
        _pokemonTypes = pokemonTypes
    }

    private var getNames: [PokemonEntity.NameValue] {
        var array: [PokemonEntity.NameValue] = []
        _pokemonSpecies.names?.forEach { name in
            guard let language = name.language else { return }
            let languageValue = PokemonEntity.LanguageValue(language: language.getName)
            let value = PokemonEntity.NameValue(name: name.getName, language: languageValue)
            array.append(value)
        }
        return array
    }
    
    private var getFrontDefault: String {
        guard let value = _pokemon.sprites?.other?.officialArtwork?.getFrontDefault else {
            return ""
        }
        return value
    }
    
    private var getGenera: [PokemonEntity.GenusValue] {
        var array: [PokemonEntity.GenusValue] = []
        _pokemonSpecies.genera?.forEach { genus in
            guard let language = genus.language else { return }
            let languageValue = PokemonEntity.LanguageValue(language: language.getName)
            let value = PokemonEntity.GenusValue(genus: genus.getGenus, language: languageValue)
            array.append(value)
        }
        return array
    }
    
    private var getFlavorTextEntries: [PokemonEntity.FlavorTextEntryValue]  {
        var array: [PokemonEntity.FlavorTextEntryValue] = []
        _pokemonSpecies.flavorTextEntries?.forEach { flavorTextEntry in
            guard let language = flavorTextEntry.language else { return }
            let languageValue = PokemonEntity.LanguageValue(language: language.getName)
            let value = PokemonEntity.FlavorTextEntryValue(flavorTextEntry: flavorTextEntry.getFlavorText, language: languageValue)
            array.append(value)
        }
        return array
    }
    
    private var getPokemonTypes: [PokemonEntity.PokemonTypeValue] {
        var array: [PokemonEntity.PokemonTypeValue] = []
        _pokemonTypes.forEach { pokemonType in
            pokemonType.names?.forEach { name in
                guard let language = name.language else { return }
                let languageValue = PokemonEntity.LanguageValue(language: language.getName)
                let typeValue = PokemonEntity.PokemonTypeValue(name: name.getName, language: languageValue)
                array.append(typeValue)
            }
        }
        return array
    }
    
    public func createEntity() -> PokemonEntity {
        return PokemonEntity(
            id: PokemonEntity.IdValue(id: _pokemon.getId),
            names: self.getNames,
            weight: PokemonEntity.WeightValue(weight: _pokemon.getWeight),
            height: PokemonEntity.HeightValue(height: _pokemon.getHeight),
            genera: self.getGenera,
            flavorTextEntries: self.getFlavorTextEntries,
            frontDefault: PokemonEntity.FrontDefaultValue(frontDefault: self.getFrontDefault),
            pokemonTypeValues: self.getPokemonTypes)
    }
}
