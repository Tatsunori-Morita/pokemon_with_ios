//
//  pokemon_with_ios_widget.swift
//  pokemon_with_ios_widget
//
//  Created by Tatsunori on 2022/07/02.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    let entity = PokemonEntityDTO(
        pokemon: LocalDataManager.shared.load(Pokemon.identifier),
        pokemonSpecies: LocalDataManager.shared.load(PokemonSpecies.identifier),
        pokemonTypes: LocalDataManager.shared.load(PokemonType.identifier)).createEntity()

    func placeholder(in context: Context) -> PokemonEntry {
        PokemonEntry(
            date: Date(),
            viewHelper: ViewHelper(pokemonEntity: entity, isApp: false),
            configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (PokemonEntry) -> ()) {
        let entry = PokemonEntry(
            date: Date(),
            viewHelper: ViewHelper(pokemonEntity: entity, isApp: false),
            configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let number = Int.random(in: 1 ... PokemonApiService.POKEMON_AMOUNT)

        let repository: IRepository = RealmRepository()
        let entity = repository.getEntityBy(no: PokemonEntity.IdValue(id: number))
        if let entity = entity {
            repository.delete(entity: entity)
        }

        let apiService = PokemonApiService(number: number)

        apiService.fetch(url: apiService.pokemonURL) { (pokemon: Pokemon) in
            var pokemonTypes: [PokemonType] = []
            apiService.fetch(url: apiService.pokemonSpeciesURL) { (pokemonSpecies: PokemonSpecies) in
                guard let typeElements = pokemon.types else { return }
                let pokemonTypesGroup = DispatchGroup()
                typeElements.forEach { typeElement in
                    pokemonTypesGroup.enter()
                    if let url = typeElement.type?.url {
                        apiService.fetch(url: url) { (type: PokemonType) in
                            pokemonTypes.append(type)
                            pokemonTypesGroup.leave()
                        }
                    }
                }

                pokemonTypesGroup.notify(queue: .main) {
                    let currentDate = Date()
                    let dto = PokemonEntityDTO(
                        pokemon: pokemon,
                        pokemonSpecies: pokemonSpecies,
                        pokemonTypes: pokemonTypes)

                    let entity = dto.createEntity()
                    repository.add(entity: entity)
                    
                    let entry = PokemonEntry(
                        date: currentDate,
                        viewHelper: ViewHelper(pokemonEntity: entity, isApp: false),
                        configuration: configuration)

                    let futureDate = Calendar.current.date(byAdding: .minute, value: 15, to: currentDate)!
                    let timeline = Timeline(entries: [entry], policy: .after(futureDate))
                    completion(timeline)
                }
            }
        }
    }
}

struct PokemonEntry: TimelineEntry {
    var date: Date
    var viewHelper: ViewHelper
    let configuration: ConfigurationIntent
}

struct pokemon_with_ios_widgetEntryView : View {
    var entry: Provider.Entry

    @Environment(\.widgetFamily) var family

    var body: some View {
        WidgetContentView(viewHelper: entry.viewHelper)
    }
}

@main
struct pokemon_with_ios_widget: Widget {
    let kind: String = "pokemon_with_ios_widget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            pokemon_with_ios_widgetEntryView(entry: entry)
                .background(Color.layout)
        }
        .configurationDisplayName("configurationDisplayName")
        .description("description")
        .supportedFamilies([.systemLarge])
    }
}

struct pokemon_with_ios_widget_Previews: PreviewProvider {
    static let dto = PokemonEntityDTO(
        pokemon: LocalDataManager.shared.load(Pokemon.identifier),
        pokemonSpecies: LocalDataManager.shared.load(PokemonSpecies.identifier),
        pokemonTypes: LocalDataManager.shared.load(PokemonType.identifier))
    static var previews: some View {
        Group {
            pokemon_with_ios_widgetEntryView(
                entry: PokemonEntry(
                    date: Date(),
                    viewHelper: ViewHelper(pokemonEntity: dto.createEntity(), isApp: false),
                    configuration: ConfigurationIntent()))
            .background(.white)
            .previewContext(WidgetPreviewContext(family: .systemLarge))
        }
    }
}
