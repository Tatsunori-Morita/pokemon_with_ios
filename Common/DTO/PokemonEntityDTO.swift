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
            do {
                let languageValue = try PokemonEntity.LanguageValue(language: language.getName)
                let value = try PokemonEntity.NameValue(name: name.getName, language: languageValue)
                array.append(value)
            } catch {
                fatalError(error.localizedDescription)
            }
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
            do {
                let languageValue = try PokemonEntity.LanguageValue(language: language.getName)
                let value = try PokemonEntity.GenusValue(genus: genus.getGenus, language: languageValue)
                array.append(value)
            } catch {
                fatalError(error.localizedDescription)
            }
        }
        return array
    }
    
    private var getFlavorTextEntries: [PokemonEntity.FlavorTextEntryValue]  {
        var array: [PokemonEntity.FlavorTextEntryValue] = []
        _pokemonSpecies.flavorTextEntries?.forEach { flavorTextEntry in
            guard let language = flavorTextEntry.language else { return }
            do {
                let languageValue = try PokemonEntity.LanguageValue(language: language.getName)
                let value = try PokemonEntity.FlavorTextEntryValue(flavorTextEntry: flavorTextEntry.getFlavorText, language: languageValue)
                array.append(value)
            } catch {
                fatalError(error.localizedDescription)
            }
        }
        return array
    }
    
    private var getPokemonTypes: [PokemonEntity.PokemonTypeValue] {
        var array: [PokemonEntity.PokemonTypeValue] = []
        _pokemonTypes.forEach { pokemonType in
            pokemonType.names?.forEach { name in
                guard let language = name.language else { return }
                do {
                    let languageValue = try PokemonEntity.LanguageValue(language: language.getName)
                    let typeValue = try PokemonEntity.PokemonTypeValue(name: name.getName, language: languageValue)
                    array.append(typeValue)
                } catch {
                    fatalError(error.localizedDescription)
                }
            }
        }
        return array
    }
    
    public func createEntity() -> PokemonEntity {
        do {
            return PokemonEntity(
                id: try PokemonEntity.IdValue(id: _pokemon.getId),
                names: self.getNames,
                weight: try PokemonEntity.WeightValue(weight: _pokemon.getWeight),
                height: try PokemonEntity.HeightValue(height: _pokemon.getHeight),
                genera: self.getGenera,
                flavorTextEntries: self.getFlavorTextEntries,
                frontDefault: try PokemonEntity.FrontDefaultValue(frontDefault: self.getFrontDefault),
                pokemonTypeValues: self.getPokemonTypes)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
